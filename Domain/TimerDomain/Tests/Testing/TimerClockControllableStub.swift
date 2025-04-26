//
//  TimerClockControllableStub.swift
//  TimerDomainTesting
//
//  Created by JUNHEE JO on 4/25/25.
//

import Foundation
import Combine
@testable import TimerDomainInterface

final class TimerClockControllableStub: TimerClockControllable {
    private let subject = PassthroughSubject<Int, Never>()

    func emitRemainingTime(_ time: Int) {
        subject.send(time)
    }

    var remainingTime: AnyPublisher<Int, Never> {
        subject.eraseToAnyPublisher()
    }

    func start(duration: Int) { }
    func resume(remainingTime: Int) { }
    func pause() { }
    func reset() { }
}
