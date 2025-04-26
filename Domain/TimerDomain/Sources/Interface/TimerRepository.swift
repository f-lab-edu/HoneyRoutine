//
//  TimerRepository.swift
//  TimerDomainInterface
//
//  Created by JUNHEE JO on 4/24/25.
//

import Foundation

/// 도메인 타이머(Timer)의 상태를 저장, 불러오기, 초기화하는 추상 저장소 인터페이스입니다.
public protocol TimerRepository {
    /// 타이머 상태를 저장합니다.
    /// - Parameter timer: 저장할  타이머 인스턴스
    func save(_ timer: Timer)

    /// 저장된 타이머 상태를 불러옵니다.
    /// - Returns: 마지막으로 저장된 타이머 객체. 값이 없는 경우 nil 반환
    func load() -> Timer?

    /// 저장된 타이머 상태를 초기화합니다.
    func clear()
}
