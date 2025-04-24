//
//  TimerControllable.swift
//  TimerDomainInterface
//
//  Created by JUNHEE JO on 4/24/25.
//

import Foundation
import Combine

/// 타이머의 실행 상태를 제어하고 남은 시간을 외부에 스트리밍할 수 있도록 추상화한 프로토콜입니다.
public protocol TimerControllable {
    /// 타이머를 처음부터 시작합니다.
    /// - Parameter duration: 타이머 전체 실행 시간(초)
    func start(duration: Int)

    /// 일시 정지된 타이머를 다시 시작합니다.
    /// 현재 남은 시간을 기준으로 재개됩니다.
    /// - Parameter remainingTime: 타이머 남은 실행 시간(초)
    func resume(remainingTime: Int)

    /// 타이머를 일시 정지합니다.
    func stop()

    /// 타이머를 초기 상태로 되돌립니다.
    func reset()

    /// 남은 시간을 1초 단위로 발행하는 Publisher입니다.
    var remainingTime: AnyPublisher<Int, Never> { get }
}
