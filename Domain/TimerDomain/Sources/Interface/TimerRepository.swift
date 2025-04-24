//
//  TimerRepository.swift
//  TimerDomainInterface
//
//  Created by JUNHEE JO on 4/24/25.
//

import Foundation

public protocol TimerRepository {
    func save(_ timer: Timer)
    func load() -> Timer?
    func clear()
}
