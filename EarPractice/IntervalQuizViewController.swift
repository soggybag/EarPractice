//
//  DetailViewController.swift
//  EarPractice
//
//  Created by mitchell hudson on 9/9/16.
//  Copyright © 2016 Mitchell Hudson. All rights reserved.
//



// TODO: Next/Play button should read Play until the correct answer is selected
// TODO: Should only score correct or incorrect on the first attempt
// TODO: Random postives like Great! Nice, Good job etc. when answering correctly.
// TODO: Add an enum/struct for play/next button titles



import UIKit


class IntervalQuizViewController: UIViewController {
    
    
    var intervalsToQuiz: [Interval]?
    var intervalQuiz: IntervalQuiz?
    
    // MARK: - Getters and setters
    
    var scoreCorrect: Int = 0 {
        didSet {
            displayScore()
        }
    }
    var scoreIncorrect: Int = 0 {
        didSet {
            displayScore()
        }
    }
    
    var quizComplete = false {
        didSet {
            playNextButton.setTitle("Next", forState: .Normal)
        }
    }
    
    
    // ----------------------------------------------------------------------------
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var playNextButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet var intervalButtonCollection: [IntervalButton]!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    // ----------------------------------------------------------------------------
    
    // MARK: - IBActions
    
    @IBAction func playNextButtonTapped(sender: UIButton) {
        if quizComplete {
            nextQuiz()
        } else {
            interval()
        }
    }
    
    @IBAction func intervalButtonTapped(sender: IntervalButton) {
        if checkQuiz(sender.interval!) {
            sender.selectCorrect()
        } else {
            sender.selectIncorrect()
        }
    }
    
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        // TODO: Total quiz session save to CD
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
    // ----------------------------------------------------------------------------
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // setupIntervalButtons()
        setupIntervalButtonsAll()
        nextIntervalQuiz()
        
        titleLabel.text = " "
        detailLabel.text = " "
        playNextButton.setTitle("Start", forState: .Normal)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Setup
    
    func setupIntervalButtons() {
        hideIntervalButtons()
        
        guard let intervalsToQuiz = intervalsToQuiz else {
            return
        }
        
        var buttonIndex = 0
        
        for interval in intervalsToQuiz {
            let button = intervalButtonCollection[buttonIndex]
            button.interval = interval
            button.hidden = false
            buttonIndex += 1
            
        }
        
        // Hide other buttons
    }
    
    func hideIntervalButtons() {
        for button in intervalButtonCollection {
            button.hidden = true
            button.interval = nil
        }
    }
    
    func setupIntervalButtonsAll() {
        let allIntervals = Interval.allIntervals
        for button in intervalButtonCollection {
            let interval = allIntervals[button.tag]
            button.interval = interval
            if intervalsToQuiz!.contains(interval) {
                button.reset()
            } else {
                button.disable()
            }
        }
    }
    
    func nextIntervalQuiz() {
        if let intervalsToQuiz = intervalsToQuiz {
            if intervalsToQuiz.count > 0 {
            intervalQuiz = SoundManager.sharedInstance.random(intervalsToQuiz[Int(arc4random() % UInt32(intervalsToQuiz.count))])
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // ----------------------------------------------------------------------------
    
    // MARK: - Quiz Functions
    
    func interval() {
        if let intervalQuiz = intervalQuiz {
            playNextButton.setTitle("Hear Interval", forState: .Normal)
            intervalQuiz.playSoundA()
            runAfterDelay(1) {
                self.intervalQuiz!.playSoundB()
            }
        }
    }
    
    func checkQuiz(answer: Interval) -> Bool {
        guard let intervalQuiz = intervalQuiz else {
            return false
        }
        let correct = intervalQuiz.interval == answer
        
        if correct {
            titleLabel.text = "Correct! that was a \(intervalQuiz.interval.toString())"
        } else {
            titleLabel.text = "Try again"
        }
        
        if !quizComplete {
            if correct {
                scoreCorrect += 1
                quizComplete = true
            } else {
                scoreIncorrect += 1
            }
            ScoreManager.sharedInstance.score(intervalQuiz.interval, correct: correct)
        }
        
        return correct
    }
    
    func nextQuiz() {
        setupIntervalButtonsAll()
        
        playNextButton.setTitle("Hear Interval", forState: .Normal)
        titleLabel.text = " "
        quizComplete = false
        intervalQuiz = SoundManager.sharedInstance.random(intervalsToQuiz![Int(arc4random() % UInt32(intervalsToQuiz!.count))])
        interval()
    }
    
    func displayScore() {
        detailLabel.text = "\(scoreCorrect) of \(scoreIncorrect) correct"
        progressView.progress = Float(max(scoreCorrect - scoreIncorrect, 0)) / 10
    }
    
    
    // ----------------------------------------------------------------------------
    
    // MARK: - Utility
    
    func runAfterDelay(delay: NSTimeInterval, block: dispatch_block_t) {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), block)
    }
}
