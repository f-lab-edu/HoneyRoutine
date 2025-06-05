//
//  Timer.swift
//  TimerDomainInterface
//
//  Created by JUNHEE JO on 4/23/25.
//

import Foundation

public struct Timer {
    // MARK: - Properties
    public private(set) var duration: Int
    public private(set) var remainingTime: Int
    public private(set) var isRunning: Bool
    
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
    /// 타이머 시작 상태로 변경
    public mutating func start() {
        isRunning = true
    }

    /// 타이머 정지 상태로 변경
    public mutating func stop() {
        isRunning = false
    }

    /// 남은 시간 업데이트
    public mutating func updateRemainingTime(_ newTime: Int) {
        remainingTime = max(0, min(newTime, duration))
    }

    /// 타이머 초기화
    public mutating func reset() {
        remainingTime = duration
        isRunning = false
    }
}

// MARK: - Equatable & Hashable
extension Timer: Equatable {}
extension Timer: Hashable {}

// MARK: - Custom String Convertible
extension Timer: CustomStringConvertible {
    public var description: String {
        "Timer(duration: \(duration)s, remaining: \(remainingTime)s, running: \(isRunning))"
    }
}
