//
//  Sound.swift
//  EarPractice
//
//  Created by mitchell hudson on 9/6/16.
//  Copyright © 2016 Mitchell Hudson. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

enum KeyColor {
    case white
    case black
    
    func color() -> UIColor {
        switch self {
        case .black:
            return UIColor.blackColor()
        case .white:
            return UIColor.whiteColor()
        }
    }
}

class Sound {
    let audio: AVAudioPlayer
    let name: String
    let keyColor: KeyColor
    
    init(audio: AVAudioPlayer, name: String, keyColor: KeyColor) {
        self.audio = audio
        self.name = name
        self.keyColor = keyColor
    }
}


extension AVAudioPlayer {
    func playSound() {
        self.stop()
        self.currentTime = 0
        self.play()
    }
}
