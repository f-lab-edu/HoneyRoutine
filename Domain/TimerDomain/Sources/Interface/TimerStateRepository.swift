//
//  TimerStateRepository.swift
//  TimerDomainInterface
//
//  Created by JUNHEE JO on 4/24/25.
//

import Foundation

/// TimerState를 저장, 로드, 초기화하는 Repository 객체 프로토콜입니다.
public protocol TimerStateRepository {
    /// 타이머 상태를 저장합니다.
    /// - Parameter timerState: 저장할  타이머 상태
    func save(_ timerState: TimerState)

    /// 저장된 타이머 상태를 불러옵니다.
    /// - Returns: 마지막으로 저장된 타이머 상태. 값이 없는 경우 nil 반환
    func load() -> TimerState?

    /// 저장된 타이머 상태를 초기화합니다.
    func clear()
}
