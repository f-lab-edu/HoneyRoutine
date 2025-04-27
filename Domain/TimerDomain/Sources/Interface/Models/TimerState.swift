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
    public let phase: TimerPhase

    // MARK: - Initialization
    public init(
        duration: Int,
        remainingTime: Int? = nil,
        phase: TimerPhase = .ready
    ) {
        self.duration = duration
        self.remainingTime = remainingTime ?? duration
        self.phase = phase
    }

    // MARK: - State Changes
    /// 타이머 상태를 시작 상태로 변경
    public func start() -> TimerState {
        TimerState(
            duration: self.duration,
            remainingTime: self.remainingTime,
            phase: .active
        )
    }

    /// 타이머 상태를 일시 정지 상태로 변경
    public func pause() -> TimerState {
        TimerState(
            duration: self.duration,
            remainingTime: self.remainingTime,
            phase: .paused
        )
    }

    /// 남은 시간 업데이트
    public func updateRemainingTime(_ newTime: Int) -> TimerState {
        let clampedTime = max(0, min(newTime, duration))
        let newPhase = clampedTime == 0 ? TimerPhase.completed : self.phase
        return TimerState(
            duration: self.duration,
            remainingTime: clampedTime,
            phase: newPhase
        )
    }

    /// 타이머 상태를 초기화
    public func reset() -> TimerState {
        TimerState(
            duration: self.duration,
            remainingTime: self.duration,
            phase: .ready
        )
    }
}

// MARK: - Equatable & Hashable
extension TimerState: Equatable {}
extension TimerState: Hashable {}

// MARK: - Custom String Convertible
extension TimerState: CustomStringConvertible {
    public var description: String {
        "TimerState(duration: \(duration)s, remaining: \(remainingTime)s, phase: \(phase))"
    }
}
