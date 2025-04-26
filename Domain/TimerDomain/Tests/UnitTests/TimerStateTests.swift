//
//  TimerStateTests.swift
//  TimerDomainTests
//
//  Created by JUNHEE JO on 4/24/25.
//

import XCTest
@testable import TimerDomainInterface

final class TimerStateTests: XCTestCase {
    // MARK: - start()
    func testStart_shouldReturnTimerStateWithRunningTrue() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 30, isRunning: false)

        // When
        let started = timerState.start()

        // Then
        XCTAssertTrue(started.isRunning)
        XCTAssertEqual(started.duration, 60)
        XCTAssertEqual(started.remainingTime, 30)
    }

    // MARK: - pause()
    func testPause_shouldReturnTimerStateWithRunningFalse() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 10, isRunning: true)

        // When
        let paused = timerState.pause()

        // Then
        XCTAssertFalse(paused.isRunning)
    }

    func testPause_shouldPreserveRemainingTime() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 10, isRunning: true)

        // When
        let stopped = timerState.pause()

        // Then
        XCTAssertEqual(stopped.remainingTime, 10)
    }

    // MARK: - reset()
    func testReset_shouldReturnTimerStateWithRemainingTimeEqualsDuration() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 15, isRunning: true)

        // When
        let reset = timerState.reset()

        // Then
        XCTAssertEqual(reset.remainingTime, 60)
    }

    func testReset_shouldReturnTimerStateWithRunningFalse() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 15, isRunning: true)

        // When
        let reset = timerState.reset()

        // Then
        XCTAssertFalse(reset.isRunning)
    }

    // MARK: - updateRemainingTime()
    func testUpdateRemainingTime_shouldClampAboveMaxToDuration() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 30)

        // When
        let updated = timerState.updateRemainingTime(100)

        // Then
        XCTAssertEqual(updated.remainingTime, 60)
    }

    func testUpdateRemainingTime_shouldClampBelowMinToZero() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 30)

        // When
        let updated = timerState.updateRemainingTime(-10)

        // Then
        XCTAssertEqual(updated.remainingTime, 0)
    }

    func testUpdateRemainingTime_shouldSetExactValueWithinBounds() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 30)

        // When
        let updated = timerState.updateRemainingTime(25)

        // Then
        XCTAssertEqual(updated.remainingTime, 25)
    }
}
