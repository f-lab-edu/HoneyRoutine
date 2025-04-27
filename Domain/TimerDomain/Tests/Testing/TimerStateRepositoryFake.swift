//
//  TimerStateRepositoryFake.swift
//  TimerDomainTesting
//
//  Created by JUNHEE JO on 4/25/25.
//

import Foundation
import TimerDomainInterface

final class TimerStateRepositoryFake: TimerStateRepository {
    private(set) var savedTimerState: TimerState?

    func save(_ timerState: TimerState) {
        savedTimerState = timerState
    }
    
    func load() -> TimerState? {
        savedTimerState
    }
    
    func clear() {
        savedTimerState = nil
    }
}
