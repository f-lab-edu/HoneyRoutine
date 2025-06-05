//
//  DefaultTimerUseCaseTests.swift
//  TimerDomainTests
//
//  Created by JUNHEE JO on 4/24/25.
//

import XCTest
import Foundation
import Combine
@testable import TimerDomainImplementation
@testable import TimerDomainInterface
@testable import TimerDomainTesting

final class DefaultTimerUseCaseTests: XCTestCase {
    private var useCase: DefaultTimerUseCase!
    private var repository: TimerRepositoryFake!
    private var controller: TimerControllableStub!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        repository = TimerRepositoryFake()
        controller = TimerControllableStub()
        useCase = DefaultTimerUseCase(
            timerRepository: repository,
            timerController: controller
        )
        cancellables = []
    }

    override func tearDown() {
        useCase = nil
        repository = nil
        controller = nil
        cancellables = nil
        super.tearDown()
    }

    // MARK: - start()
    func testStart_shouldStreamInitialRunningTimer() {
        // Given
        let expectation = expectation(description: "should receive initial started timer")
        var received: TimerDomainInterface.Timer?

        useCase.currentTimer
            .sink {
                received = $0
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // When
        useCase.start(duration: 60)

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(received!.duration, 60)
        XCTAssertEqual(received!.remainingTime, 60)
        XCTAssertTrue(received!.isRunning)
    }

    // MARK: - remainingTime update
    func testRemainingTime_shouldReflectEachTick() {
        // Given
        useCase.start(duration: 60)
        let expectation = expectation(description: "should receive 3 timer updates")
        var receivedTimes: [Int] = []

        useCase.currentTimer
            .sink {
                receivedTimes.append($0.remainingTime)
                if receivedTimes.count == 4 { // 60, 59, 58, 57
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        controller.emitRemainingTime(59)
        controller.emitRemainingTime(58)
        controller.emitRemainingTime(57)

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedTimes, [60, 59, 58, 57])
    }

    // MARK: - resume()
    func testResume_shouldResumePausedTimerAndContinueTicking() {
        // Given
        useCase.start(duration: 60)
        controller.emitRemainingTime(59)
        controller.emitRemainingTime(58)
        useCase.pause()

        let expectation = expectation(description: "should receive resumed state and tick")
        var results: [TimerDomainInterface.Timer] = []

        useCase.currentTimer
            .sink {
                results.append($0)
                if results.count == 3 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        useCase.resume()
        controller.emitRemainingTime(57)
        controller.emitRemainingTime(56)

        // Then
        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(results, [
            Timer(duration: 60, remainingTime: 58, isRunning: false),
            Timer(duration: 60, remainingTime: 58, isRunning: true),
            Timer(duration: 60, remainingTime: 57, isRunning: true),
            Timer(duration: 60, remainingTime: 56, isRunning: true)
        ])
    }

    // MARK: - pause()
    func testPause_shouldEmitPausedState() {
        // Given
        useCase.start(duration: 60)

        let expectation = expectation(description: "should emit paused timer")
        var received: TimerDomainInterface.Timer?

        useCase.currentTimer
            .sink {
                received = $0
                if !$0.isRunning {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        useCase.pause()

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(received!.duration, 60)
        XCTAssertFalse(received!.isRunning)
    }
    
    func testPause_shouldPreventFurtherTimeUpdates() {
        // Given
        useCase.start(duration: 60)

        var results: [TimerDomainInterface.Timer] = []
        let expectation = expectation(description: "should pause updating")

        useCase.currentTimer
            .sink {
                results.append($0)
                if results.count == 2 { expectation.fulfill() }
            }
            .store(in: &cancellables)

        controller.emitRemainingTime(59)
        useCase.pause()
        controller.emitRemainingTime(58)// 이 값은 무시되어야 함
        controller.emitRemainingTime(57)// 이 값은 무시되어야 함

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(results, [
            Timer(duration: 60, remainingTime: 60, isRunning: true),
            Timer(duration: 60, remainingTime: 59, isRunning: true),
            Timer(duration: 60, remainingTime: 59, isRunning: false)
        ])
    }

    // MARK: - reset()
    func testReset_shouldEmitResetState() {
        // Given
        useCase.start(duration: 60)
        controller.emitRemainingTime(10)

        let expectation = expectation(description: "should receive reset state")
        var latest: TimerDomainInterface.Timer?

        useCase.currentTimer
            .sink {
                latest = $0
                if $0.remainingTime == 60 && !$0.isRunning {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        useCase.reset()

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(latest!.remainingTime, 60)
        XCTAssertFalse(latest!.isRunning)
    }
}
