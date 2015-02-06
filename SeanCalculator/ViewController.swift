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
    
    var userIsCurrentlyTypingANumber = false
    
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
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        operandStack.append(displayValue)
        userIsCurrentlyTypingANumber = false
        println("\(operandStack)")
    }

    @IBAction func operandPressed(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsCurrentlyTypingANumber {
            enter()
        }

        switch operation{
            case "×": calculateOperand {$0 * $1}
            case "÷": calculateOperand {$1 / $0}
            case "+": calculateOperand {$0 + $1}
            case "−": calculateOperand {$0 - $1}
            case "√": calculateOperand {sqrt($0)}
            default: break
        }
    }
    
    func calculateOperand (operation: (Double, Double) -> Double) {
        
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    func calculateOperand (operation: Double ->Double) {
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
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

