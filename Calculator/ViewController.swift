//
//  ViewController.swift
//  Calculator
//
//  Created by Bastian Gruber on 15/06/2016.
//  Copyright © 2016 gruberb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    @IBOutlet private weak var history: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
  
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!

        if userIsInTheMiddleOfTyping {
            if digit == "." && display.text!.range(of: ".") != nil { return }
            
            let textCurrentInDisplay = display.text!
            display.text = textCurrentInDisplay + digit
        } else {
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var historyValue: String {
        get {
            return history.text!
        }
        set {
            history.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.description = display.text!
            brain.description = sender.currentTitle!
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
            
        }
        
        historyValue = brain.description
        displayValue = brain.result
        
        if sender.currentTitle! == "=" {
            brain.resetHistory()
        }
    }
}

