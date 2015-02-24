//
//  ViewController.swift
//  SeanCalculator
//
//  Created by Sean Wilson on 2/6/15.
//  Copyright (c) 2015 Sean Wilson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsCurrentlyTypingANumber = false
    
    var brain = CalculatorBrain()
    
    @IBAction func numberPressed(sender: UIButton) {
        let number = sender.currentTitle!
        if userIsCurrentlyTypingANumber {
            display.text = display.text! + number
        }
        else {
            display.text = number
            userIsCurrentlyTypingANumber = true
        }
    }
    
    @IBAction func enter() {
        userIsCurrentlyTypingANumber = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }else {
            //Make display value take an optional for HW2
            displayValue = 0
        }
    }
    @IBAction func floatingPoint(sender: UIButton) {
        display.text = display.text! + "."
        userIsCurrentlyTypingANumber = true
    }

    @IBAction func operandPressed(sender: UIButton) {
        if userIsCurrentlyTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation){
            displayValue = result
            }
        } else {
            displayValue = 0
        }
        
        
    }

    @IBAction func clearDisplay() {
        brain.empty()
        display.text = "0"
        history.text = " "
        userIsCurrentlyTypingANumber = false
    }
    
    var displayValue: Double{
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsCurrentlyTypingANumber = false
        }
    }
}

