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
        
        bindRemainingTime()
    }

    // MARK: - UseCase Methods
    public func start(duration: Int) {
        var timer = Timer(duration: duration)
        timer.start()
        saveAndPublish(timer)
        timerController.start(duration: duration)
    }
    
    public func resume() {
        guard var currentTimer = timerSubject.value else { return }
        currentTimer.start()
        saveAndPublish(currentTimer)
        timerController.resume(remainingTime: currentTimer.remainingTime)
    }

    public func pause() {
        timerController.pause()
        guard var currentTimer = timerSubject.value else { return }
        currentTimer.pause()
        saveAndPublish(currentTimer)
    }

    public func reset() {
        timerController.reset()
        guard var currentTimer = timerSubject.value else { return }
        currentTimer.reset()
        saveAndPublish(currentTimer)
    }
    
    // MARK: - Private Methods
    private func bindRemainingTime() {
        timerController.remainingTime
            .sink { [weak self] in
                guard let self, var currentTimer = self.timerSubject.value else { return }
                currentTimer.updateRemainingTime($0)
                saveAndPublish(currentTimer)
            }
            .store(in: &cancellables)
    }
    
    private func saveAndPublish(_ timer: TimerDomainInterface.Timer) {
        timerRepository.save(timer)
        timerSubject.send(timer)
    }
}
