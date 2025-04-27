//
//  DefaultTimerUseCase.swift
//  TimerDomainImplementation
//
//  Created by JUNHEE JO on 4/24/25.
//

import Foundation
import Combine
import TimerDomainInterface

public final class DefaultTimerUseCase: TimerUseCase {
    // MARK: - Dependencies
    private let timerStateRepository: TimerStateRepository
    private let timerController: TimerClockControllable

    // MARK: - State
    private let timerStateSubject = CurrentValueSubject<TimerState?, Never>(nil)
    private var cancellables = Set<AnyCancellable>()

    public var currentTimerState: AnyPublisher<TimerState, Never> {
        timerStateSubject
            .compactMap { $0 }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    // MARK: - Init
    public init(
        timerStateRepository: TimerStateRepository,
        timerController: TimerClockControllable
    ) {
        self.timerStateRepository = timerStateRepository
        self.timerController = timerController
    }

    // MARK: - UseCase Methods
    public func start(duration: Int) {
        let startedTimerState = TimerState(duration: duration).start()

        saveAndPublish(startedTimerState)
        timerController.start(duration: duration)

        timerController.remainingTime
            .sink { [weak self] in
                guard let self else { return }
                guard let currentTimerState = timerStateSubject.value else { return }
                let updatedTimerState = currentTimerState.updateRemainingTime($0)
                saveAndPublish(updatedTimerState)
            }
            .store(in: &cancellables)
    }

    public func resume() {
        guard let currentTimerState = timerStateSubject.value else { return }
        let resumedTimerState = currentTimerState.start()
        saveAndPublish(resumedTimerState)

        timerController.resume(remainingTime: resumedTimerState.remainingTime)

        timerController.remainingTime
            .sink { [weak self] in
                guard let self, let currentTimerState = timerStateSubject.value else { return }
                let updatedTimerStat = currentTimerState.updateRemainingTime($0)
                self.saveAndPublish(updatedTimerStat)
            }
            .store(in: &cancellables)
    }

    public func pause() {
        timerController.pause()
        guard let currentTimerState = timerStateSubject.value else { return }
        let pausedTimerState = currentTimerState.pause()
        saveAndPublish(pausedTimerState)
        cancellables.removeAll()
    }

    public func reset() {
        timerController.reset()
        guard let currentTimerState = timerStateSubject.value else { return }
        let resetedTimerState = currentTimerState.reset()
        saveAndPublish(resetedTimerState)
        cancellables.removeAll()
    }

    // MARK: - Private Methods
    private func saveAndPublish(_ timerState: TimerState) {
        timerStateRepository.save(timerState)
        timerStateSubject.send(timerState)
    }
}
