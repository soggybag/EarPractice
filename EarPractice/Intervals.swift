//
//  Intervals.swift
//  EarPractice
//
//  Created by mitchell hudson on 8/28/16.
//  Copyright © 2016 Mitchell Hudson. All rights reserved.
//

import Foundation

enum Interval: Int {
    case Minor2nd = 1, Major2nd, Minor3rd, Major3rd, Perfect4th, Tritone, Perfect5th, Minor6th, Major6th, Minor7th, Major7th, Octave, Minor9th, Major9th
    
    static let allIntervals = [Minor2nd, Major2nd, Minor3rd, Major3rd, Perfect4th, Tritone, Perfect5th, Minor6th, Major6th, Minor7th, Major7th, Octave, Minor9th, Major9th]
    
    func toString() -> String {
        switch self {
        case .Minor2nd:
            return "Minor 2nd"
            
        case .Major2nd:
            return "Major 2nd"
            
        case .Minor3rd:
            return "Minor 3rd"
            
        case .Major3rd:
            return "Major 3rd"
            
        case .Perfect4th:
            return "Perfect 4th"
            
        case .Tritone:
            return "Tritone"
            
        case .Perfect5th:
            return "Perfect 5th"
            
        case .Minor6th:
            return "Minor 6th"
            
        case .Major6th:
            return "Major 6th"
            
        case .Minor7th:
            return "Minor 7th"
            
        case .Major7th:
            return "Major 7th"
            
        case .Octave:
            return "Octave"
            
        case .Minor9th:
            return "Minor 9th"
            
        case .Major9th:
            return "Major 9th"
            
        }
    }
}
