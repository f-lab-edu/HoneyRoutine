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
        let startedTimer = Timer(duration: duration).start()

        saveAndPublish(startedTimer)
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

    public func resume() {
        guard let current = timerSubject.value else { return }
        let resumedTimer = current.start()
        saveAndPublish(resumedTimer)

        timerController.resume(remainingTime: resumedTimer.remainingTime)

        timerController.remainingTime
            .sink { [weak self] in
                guard let self, let currentTimer = timerSubject.value else { return }
                let updated = currentTimer.updateRemainingTime($0)
                self.saveAndPublish(updated)
            }
            .store(in: &cancellables)
    }

    public func stop() {
        timerController.stop()
        guard let currentTimer = timerSubject.value else { return }
        let stopedTimer = currentTimer.stop()
        saveAndPublish(stopedTimer)
        cancellables.removeAll()
    }

    public func reset() {
        timerController.reset()
        guard let currentTimer = timerSubject.value else { return }
        let resetedTimer = currentTimer.reset()
        saveAndPublish(resetedTimer)
        cancellables.removeAll()
    }

    // MARK: - Private Methods
    private func saveAndPublish(_ timer: TimerDomainInterface.Timer) {
        timerRepository.save(timer)
        timerSubject.send(timer)
    }
}
