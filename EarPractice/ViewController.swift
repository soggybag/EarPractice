//
//  ViewController.swift
//  EarPractice
//
//  Created by mitchell hudson on 9/8/16.
//  Copyright © 2016 Mitchell Hudson. All rights reserved.
//


// TODO: Show and update percent when returning from quiz
// TODO: Set cell background for selected cell
// TODO: Add small sub title with number of semitones (3 semitones)


import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableViewData = [IntervalCellData]()
    var practiceIntervals = [Interval]()
    let practiceDefaultsKey = "practiceDefaultsKey"
    let numberFormatter = NSNumberFormatter()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // -------------------------------------------------------------------
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCellData()
        setupTableView()
        setupNumberFormatter()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        savePracticeIntervals()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Setup
    
    func setupCellData() {
        getPracticeIntervals()
        for interval in Interval.allIntervals {
            let selected = practiceIntervals.contains(interval)
            let quiz = ScoreManager.sharedInstance.quizFor(Interval.allIntervals[interval.rawValue - 1])
            let intervalCellData = IntervalCellData(quiz: quiz, interval: interval, selected: selected)
            tableViewData.append(intervalCellData)
        }
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
    }
    
    func setupNumberFormatter() {
        numberFormatter.roundingMode = .RoundHalfUp
        numberFormatter.maximumSignificantDigits = 1
    }
    
    
    
    
    // ---------------------------------------------------------------------
    // MARK: - Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get the cell
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        let data = tableViewData[indexPath.row]
        
        // Set title
        cell.textLabel?.text = data.interval.toString()
        
        // Show Quiz data
        if let quiz = data.quiz {
            let correct = quiz.correct!.integerValue
            let incorrect = quiz.incorrect!.integerValue
            let percentStr = numberFormatter.stringFromNumber(data.percent)!
            cell.detailTextLabel?.text = "\(correct) of \(incorrect) correct \(percentStr)%"
        } else {
            cell.detailTextLabel?.text = "No data"
        }
        
        // Show checkmark
        if data.selected {
            cell.accessoryType = .Checkmark
            cell.selected = true
            savePracticeIntervals()
        } else {
            cell.accessoryType = .None
            cell.selected = false
            savePracticeIntervals()
        }
        
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        cell?.accessoryType = .Checkmark
        tableViewData[indexPath.row].selected = true
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        cell?.accessoryType = .None
        tableViewData[indexPath.row].selected = false
    }

    
    
    // -----------------------------------------------------------------------------------
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetailSegue" {
            var intervals = [Interval]()
            for cellData in tableViewData {
                if cellData.selected {
                    intervals.append(cellData.interval)
                }
            }
            let intervalQuizVC = segue.destinationViewController as! IntervalQuizViewController
            intervalQuizVC.intervalsToQuiz = intervals
        }
    }
    
    
    
    // ----------------------------------------------------------------------------------
    // MARK: - User Defaults
    
    func getPracticeIntervals() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        print("Get Practice Intervals ******")
        
        if let array = defaults.arrayForKey(practiceDefaultsKey) {
            // TODO: Save practice intervals, this would be a list of the selected intervals
            for value in array {
                print("Get practice intervals: \(value)")
                practiceIntervals.append(Interval(rawValue: Int(value as! NSNumber))!)
            }
        } else {
            print("Setting default practice intervals")
            practiceIntervals = [.Major3rd, .Perfect5th, .Octave]
        }
    }
    
    func savePracticeIntervals() {
        let defaults = NSUserDefaults.standardUserDefaults()
        var array = [Int]()
        print("Save practice intervals")
        
        practiceIntervals = []
        
        for cellData in tableViewData {
            if cellData.selected {
                practiceIntervals.append(cellData.interval)
            }
        }
        
        for value in practiceIntervals {
            array.append(value.rawValue)
            defaults.setObject(array, forKey: practiceDefaultsKey)
        }
    }
}



// ----------------------------------------------------------------------------------

struct IntervalCellData {
    let quiz: Quiz?
    let interval: Interval
    var selected: Bool
    var percent: Float {
        get {
            if let quiz = quiz {
                let correct = quiz.correct!.integerValue
                let incorrect = quiz.incorrect!.integerValue
                return Float(correct) / Float(correct + incorrect) * 100
            } else {
                return 0
            }
        }
    }
}

