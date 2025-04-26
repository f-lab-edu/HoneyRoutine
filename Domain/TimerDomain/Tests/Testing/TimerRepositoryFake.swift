//
//  TimerRepositoryFake.swift
//  TimerDomainTesting
//
//  Created by JUNHEE JO on 4/25/25.
//

import Foundation
import TimerDomainInterface

final class TimerRepositoryFake: TimerRepository {
    private(set) var savedTimer: TimerDomainInterface.Timer?

    func save(_ timer: TimerDomainInterface.Timer) {
        savedTimer = timer
    }
    
    func load() -> TimerDomainInterface.Timer? {
        savedTimer
    }
    
    func clear() {
        savedTimer = nil
    }
}
