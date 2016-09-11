//
//  CustomButton.swift
//  EarPractice
//
//  Created by mitchell hudson on 9/7/16.
//  Copyright © 2016 Mitchell Hudson. All rights reserved.
//

// TODO: Add enum for button states


import UIKit

@IBDesignable
class IntervalButton: UIButton {
    
    var interval: Interval? = nil {
        didSet {
            if let interval = interval {
                self.setTitle(interval.toString(), forState: .Normal)
            }
        }
    }
    
    
    func reset() {
        backgroundColor = Colors.blue
        userInteractionEnabled = true
    }
    
    func selectCorrect() {
        backgroundColor = Colors.green
        userInteractionEnabled = false
    }
    
    func selectIncorrect() {
        backgroundColor = Colors.red
        userInteractionEnabled = false
    }
    
    func disable() {
        borderColor = Colors.gray
        setTitleColor(Colors.gray, forState: .Normal)
        userInteractionEnabled = false
        backgroundColor = UIColor.clearColor()
        borderColor = Colors.gray
        borderWidth = 1
    }
    
    
    // -----------------------------------------------------------------------
    
    // MARK: - Inspectibles
    
    @IBInspectable var borderColor: UIColor? = UIColor.clearColor() {
        didSet {
            layer.borderColor = self.borderColor?.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = self.cornerRadius
            layer.masksToBounds = self.cornerRadius > 0
        }
    }
    
    
    // -----------------------------------------------------------------------
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    // -----------------------------------------------------------------------
    
    // MARK: - Draw 
    
    override func drawRect(rect: CGRect) {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor?.CGColor
    }
}







