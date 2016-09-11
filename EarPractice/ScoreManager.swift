//
//  ScoreManager.swift
//  EarPractice
//
//  Created by mitchell hudson on 9/9/16.
//  Copyright © 2016 Mitchell Hudson. All rights reserved.
//



// TODO: Save quiz sessions to core data for review
// TODO: Add a new view displaying quiz sessions 


import Foundation
import UIKit
import CoreData

class ScoreManager {
    static let sharedInstance = ScoreManager()
    
    var quizzes = [Quiz]()
    let context: NSManagedObjectContext!
    
    
    // MARK: - Init
    
    init() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDelegate.managedObjectContext
        fetchQuizzes()
    }
    
    
    // MARK: -
    
    func saveContext() {
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save context: \(error) -- \(error.userInfo)")
        }
    }
    
    func fetchQuizzes() {
        let fetchRequest = NSFetchRequest(entityName: "Quiz")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            quizzes = results as! [Quiz]
            
        } catch let error as NSError {
            print("Could not fetch Quiz: \(error) -- \(error.userInfo)")
        }
    }
    
    
    func quizFor(interval: Interval) -> Quiz? {
        for quiz in quizzes {
            if Int(quiz.interval!) == interval.rawValue {
                return quiz
            }
        }
        
        return nil
    }
    
    
    func score(interval: Interval, correct: Bool) {
        // Find the interval
        for quiz in quizzes {
            if Int(quiz.interval!) == interval.rawValue {
                if correct {
                    let newScore = quiz.correct!.integerValue + 1
                    quiz.correct! = newScore
                } else {
                    let newScore = quiz.incorrect!.integerValue + 1
                    quiz.incorrect = newScore
                }
                return
            }
        }
        
        // Add this interval
        
        let quiz = NSEntityDescription.insertNewObjectForEntityForName("Quiz", inManagedObjectContext: context) as! Quiz
        quiz.interval = interval.rawValue
        if correct {
            quiz.correct = 1
            quiz.incorrect = 0
        } else {
            quiz.correct = 0
            quiz.incorrect = 1
        }
        
        quizzes.append(quiz)
        
        saveContext()
    }
    
    
    func getScoreFor(interval: Interval) {
        
    }
}