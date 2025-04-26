//
//  TimerTests.swift
//  TimerDomainTests
//
//  Created by JUNHEE JO on 4/24/25.
//

import XCTest
@testable import TimerDomainInterface

final class TimerTests: XCTestCase {
    // MARK: - start()
    func testStart_shouldReturnTimerWithRunningTrue() {
        // Given
        let timer = Timer(duration: 60, remainingTime: 30, isRunning: false)

        // When
        let started = timer.start()

        // Then
        XCTAssertTrue(started.isRunning)
        XCTAssertEqual(started.duration, 60)
        XCTAssertEqual(started.remainingTime, 30)
    }

    // MARK: - stop()
    func testPause_shouldReturnTimerWithRunningFalse() {
        // Given
        let timer = Timer(duration: 60, remainingTime: 10, isRunning: true)

        // When
        let stopped = timer.stop()

        // Then
        XCTAssertFalse(stopped.isRunning)
    }

    func testPause_shouldPreserveRemainingTime() {
        // Given
        let timer = Timer(duration: 60, remainingTime: 10, isRunning: true)

        // When
        let stopped = timer.stop()

        // Then
        XCTAssertEqual(stopped.remainingTime, 10)
    }

    // MARK: - reset()
    func testReset_shouldReturnTimerWithRemainingTimeEqualsDuration() {
        // Given
        let timer = Timer(duration: 60, remainingTime: 15, isRunning: true)

        // When
        let reset = timer.reset()

        // Then
        XCTAssertEqual(reset.remainingTime, 60)
    }

    func testReset_shouldReturnTimerWithRunningFalse() {
        // Given
        let timer = Timer(duration: 60, remainingTime: 15, isRunning: true)

        // When
        let reset = timer.reset()

        // Then
        XCTAssertFalse(reset.isRunning)
    }

    // MARK: - updateRemainingTime()
    func testUpdateRemainingTime_shouldClampAboveMaxToDuration() {
        // Given
        let timer = Timer(duration: 60, remainingTime: 30)

        // When
        let updated = timer.updateRemainingTime(100)

        // Then
        XCTAssertEqual(updated.remainingTime, 60)
    }

    func testUpdateRemainingTime_shouldClampBelowMinToZero() {
        // Given
        let timer = Timer(duration: 60, remainingTime: 30)

        // When
        let updated = timer.updateRemainingTime(-10)

        // Then
        XCTAssertEqual(updated.remainingTime, 0)
    }

    func testUpdateRemainingTime_shouldSetExactValueWithinBounds() {
        // Given
        let timer = Timer(duration: 60, remainingTime: 30)

        // When
        let updated = timer.updateRemainingTime(25)

        // Then
        XCTAssertEqual(updated.remainingTime, 25)
    }
}
