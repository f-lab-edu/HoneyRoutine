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
    private let timerRepository: TimerRepository
    private let timerController: TimerControllable

    // MARK: - State
    private let timerSubject = CurrentValueSubject<TimerDomainInterface.Timer?, Never>(nil)
    private var cancellables = Set<AnyCancellable>()

    public var currentTimer: AnyPublisher<TimerDomainInterface.Timer, Never> {
        timerSubject
            .compactMap { $0 }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    // MARK: - Init
    public init(
        timerRepository: TimerRepository,
        timerController: TimerControllable
    ) {
        self.timerRepository = timerRepository
        self.timerController = timerController
    }

    // MARK: - UseCase Methods
    public func start(duration: Int) {
        let timer = Timer(duration: duration)

        saveAndPublish(timer)
        timerController.start(duration: duration)

        timerController.remainingTime
            .sink { [weak self] in
                guard let self else { return }
                guard let currentTimer = timerSubject.value else { return }
                let updatedTimer = currentTimer.updateRemainingTime($0)
                saveAndPublish(updatedTimer)
            }
            .store(in: &cancellables)
    }

    public func stop() {
        timerController.stop()
    }

    public func reset() {
        timerController.reset()
        guard let resetTimer = timerSubject.value?.reset() else { return }
        saveAndPublish(resetTimer)
    }

    // MARK: - Private Methods
    private func saveAndPublish(_ timer: TimerDomainInterface.Timer) {
        timerRepository.save(timer)
        timerSubject.send(timer)
    }
}
