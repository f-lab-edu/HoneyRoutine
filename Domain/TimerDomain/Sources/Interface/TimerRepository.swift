//
//  TimerRepository.swift
//  TimerDomainInterface
//
//  Created by JUNHEE JO on 4/24/25.
//

import Foundation

public protocol TimerRepository {
    func saveTime(_ timer: Timer)
    func loadTimer() -> Timer
    func clearTimer()
}
