//
//  IntervalQuiz.swift
//  EarPractice
//
//  Created by mitchell hudson on 9/7/16.
//  Copyright © 2016 Mitchell Hudson. All rights reserved.
//

import Foundation
import AVFoundation

class IntervalQuiz {
    let soundA: Sound
    let soundB: Sound
    let interval: Interval
    
    init(soundA: Sound, soundB: Sound, interval: Interval) {
        self.soundA = soundA
        self.soundB = soundB
        self.interval = interval
    }
    
    func playSoundA() {
        soundA.audio.playSound()
    }
    
    func playSoundB() {
        soundB.audio.playSound()
    }
     
}