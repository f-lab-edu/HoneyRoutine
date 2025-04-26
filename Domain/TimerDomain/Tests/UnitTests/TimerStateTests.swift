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
    func testStart_shouldReturnTimerStateWithPhaseActive() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 30, phase: .ready)

        // When
        let started = timerState.start()

        // Then
        XCTAssertEqual(started.phase, .active)
        XCTAssertEqual(started.duration, 60)
        XCTAssertEqual(started.remainingTime, 30)
    }

    // MARK: - pause()
    func testPause_shouldReturnTimerStateWithPhasePaused() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 10, phase: .active)

        // When
        let paused = timerState.pause()

        // Then
        XCTAssertEqual(paused.phase, .paused)
    }

    func testPause_shouldPreserveRemainingTime() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 10, phase: .active)

        // When
        let stopped = timerState.pause()

        // Then
        XCTAssertEqual(stopped.remainingTime, 10)
    }

    // MARK: - reset()
    func testReset_shouldReturnTimerStateWithRemainingTimeEqualsDuration() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 15, phase: .active)

        // When
        let reset = timerState.reset()

        // Then
        XCTAssertEqual(reset.remainingTime, 60)
    }

    func testReset_shouldReturnTimerStateWithPhaseReady() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 15, phase: .active)

        // When
        let reset = timerState.reset()

        // Then
        XCTAssertEqual(reset.phase, .ready)
    }

    // MARK: - updateRemainingTime()
    func testUpdateRemainingTime_shouldClampAboveMaxToDuration() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 30, phase: .active)

        // When
        let updated = timerState.updateRemainingTime(100)

        // Then
        XCTAssertEqual(updated.remainingTime, 60)
        XCTAssertEqual(updated.phase, .active)
    }

    func testUpdateRemainingTime_shouldClampBelowMinToZero() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 30, phase: .active)

        // When
        let updated = timerState.updateRemainingTime(-10)

        // Then
        XCTAssertEqual(updated.remainingTime, 0)
        XCTAssertEqual(updated.phase, .completed)
    }

    func testUpdateRemainingTime_shouldSetExactValueWithinBounds() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 30, phase: .active)

        // When
        let updated = timerState.updateRemainingTime(25)

        // Then
        XCTAssertEqual(updated.remainingTime, 25)
        XCTAssertEqual(updated.phase, .active)
    }
    
    func testUpdateRemainingTime_shouldChangePhaseToCompletedWhenTimeReachesZero() {
        // Given
        let timerState = TimerState(duration: 60, remainingTime: 5, phase: .active)
        
        // When
        let updated = timerState.updateRemainingTime(0)
        
        // Then
        XCTAssertEqual(updated.remainingTime, 0)
        XCTAssertEqual(updated.phase, .completed)
    }
}
