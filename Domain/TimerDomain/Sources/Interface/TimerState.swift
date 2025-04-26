//
//  TimerState.swift
//  TimerDomainInterface
//
//  Created by JUNHEE JO on 4/23/25.
//

import Foundation

public struct TimerState {
    // MARK: - Properties
    public let duration: Int
    public let remainingTime: Int
    public let isRunning: Bool

    // MARK: - Initialization
    public init(
        duration: Int,
        remainingTime: Int? = nil,
        isRunning: Bool = false
    ) {
        self.duration = duration
        self.remainingTime = remainingTime ?? duration
        self.isRunning = isRunning
    }

    // MARK: - State Changes
    /// 타이머 상태를 시작 상태로 변경
    public func start() -> TimerState {
        TimerState(
            duration: self.duration,
            remainingTime: self.remainingTime,
            isRunning: true
        )
    }

    /// 타이머 상태를 일시 정지 상태로 변경
    public func pause() -> TimerState {
        TimerState(
            duration: self.duration,
            remainingTime: self.remainingTime,
            isRunning: false
        )
    }

    /// 남은 시간 업데이트
    public func updateRemainingTime(_ newTime: Int) -> TimerState {
        let clampedTime = max(0, min(newTime, duration))
        return TimerState(
            duration: self.duration,
            remainingTime: clampedTime,
            isRunning: self.isRunning
        )
    }

    /// 타이머 상태를 초기화
    public func reset() -> TimerState {
        TimerState(
            duration: self.duration,
            remainingTime: self.duration,
            isRunning: false
        )
    }
}

// MARK: - Equatable & Hashable
extension TimerState: Equatable {}
extension TimerState: Hashable {}

// MARK: - Custom String Convertible
extension TimerState: CustomStringConvertible {
    public var description: String {
        "TimerState(duration: \(duration)s, remaining: \(remainingTime)s, running: \(isRunning))"
    }
}
