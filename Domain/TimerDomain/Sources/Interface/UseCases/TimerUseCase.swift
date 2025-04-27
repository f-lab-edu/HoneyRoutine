//
//  TimerUseCase.swift
//  TimerDomainInterface
//
//  Created by JUNHEE JO on 4/24/25.
//

import Foundation
import Combine

/// 타이머의 실행 흐름을 제어하고 현재 상태를 스트리밍하는 UseCase 프로토콜입니다.
public protocol TimerUseCase {
    /// 현재 타이머 상태를 Combine Publisher로 스트리밍합니다.
    var currentTimerState: AnyPublisher<TimerState, Never> { get }

    /// 타이머를 처음부터 시작합니다.
    /// - Parameter duration: 타이머의 전체 실행 시간 (초)
    func start(duration: Int)

    /// 일시 정지된 타이머를 다시 실행합니다.
    func resume()

    /// 실행 중인 타이머를 일시 정지합니다.
    func pause()

    /// 타이머를 초기 상태로 리셋합니다.
    func reset()
}
