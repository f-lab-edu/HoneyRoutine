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
        var timer = Timer(duration: 60, remainingTime: 30, isRunning: false)

        // When
        timer.start()

        // Then
        XCTAssertTrue(timer.isRunning)
        XCTAssertEqual(timer.duration, 60)
        XCTAssertEqual(timer.remainingTime, 30)
    }

    // MARK: - stop()
    func testPause_shouldReturnTimerWithRunningFalse() {
        // Given
        var timer = Timer(duration: 60, remainingTime: 10, isRunning: true)

        // When
        timer.stop()

        // Then
        XCTAssertFalse(timer.isRunning)
    }

    func testPause_shouldPreserveRemainingTime() {
        // Given
        var timer = Timer(duration: 60, remainingTime: 10, isRunning: true)

        // When
        timer.stop()

        // Then
        XCTAssertEqual(timer.remainingTime, 10)
    }

    // MARK: - reset()
    func testReset_shouldReturnTimerWithRemainingTimeEqualsDuration() {
        // Given
        var timer = Timer(duration: 60, remainingTime: 15, isRunning: true)

        // When
        timer.reset()

        // Then
        XCTAssertEqual(timer.remainingTime, 60)
    }

    func testReset_shouldReturnTimerWithRunningFalse() {
        // Given
        var timer = Timer(duration: 60, remainingTime: 15, isRunning: true)

        // When
        timer.reset()

        // Then
        XCTAssertFalse(timer.isRunning)
    }

    // MARK: - updateRemainingTime()
    func testUpdateRemainingTime_shouldClampAboveMaxToDuration() {
        // Given
        var timer = Timer(duration: 60, remainingTime: 30)

        // When
        timer.updateRemainingTime(100)

        // Then
        XCTAssertEqual(timer.remainingTime, 60)
    }

    func testUpdateRemainingTime_shouldClampBelowMinToZero() {
        // Given
        var timer = Timer(duration: 60, remainingTime: 30)

        // When
        timer.updateRemainingTime(-10)

        // Then
        XCTAssertEqual(timer.remainingTime, 0)
    }

    func testUpdateRemainingTime_shouldSetExactValueWithinBounds() {
        // Given
        var timer = Timer(duration: 60, remainingTime: 30)

        // When
        timer.updateRemainingTime(25)

        // Then
        XCTAssertEqual(timer.remainingTime, 25)
    }
}
