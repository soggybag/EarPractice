//
//  SoundManager.swift
//  EarPractice
//
//  Created by mitchell hudson on 9/2/16.
//  Copyright © 2016 Mitchell Hudson. All rights reserved.
//


// TODO: Look for improved sounds


import Foundation
import AVFoundation

class SoundManager {
    static let sharedInstance = SoundManager()
    
    var sounds = [Sound]()
    
    
    // MARK: - Utility
    
    func randomNote() -> Sound {
        return sounds[Int(arc4random() % UInt32(sounds.count))]
    }
    
    func randomInterval(steps: Int) -> [Sound] {
        let indexA = Int(arc4random() % UInt32(sounds.count - steps))
        let a = sounds[indexA]
        let b = sounds[indexA + steps]
        return [a, b]
    }
    
    func random(interval: Interval) -> IntervalQuiz {
        let soundsAB = randomInterval(interval.rawValue)
        let intervalQuiz = IntervalQuiz(soundA: soundsAB[0], soundB: soundsAB[1], interval: interval)
        return intervalQuiz
    }
    
    func playSoundAt(index: Int) {
        sounds[index].audio.playSound()
    }
    
    
    // MARK: - Init
    
    init() {
        setup()
    }
    
    
    // MARK: - Setup
    
    func setup() {
        let noteNames = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
        
        for i in 1 ... 64 {
            let path = NSBundle.mainBundle().pathForResource("\(i).wav", ofType: nil)!
            let url = NSURL(fileURLWithPath: path)
            do {
                let audio = try AVAudioPlayer(contentsOfURL: url)
                let index = i - 1
                let soundName = "\(noteNames[index % 12])\(index / 12 + 1)"
                var keyColor = KeyColor.white
                if index  % 12 == 1 || index % 12 == 3 || index % 12 == 6 || index % 12 == 8 || index % 12 == 10 {
                    keyColor = KeyColor.black
                }
                let sound = Sound(audio: audio, name: soundName, keyColor: keyColor)
                sounds.append(sound)
                
            } catch let error {
                print("unable to load sound. \(i).wav \(error)")
                
            }
        }
    }
}







