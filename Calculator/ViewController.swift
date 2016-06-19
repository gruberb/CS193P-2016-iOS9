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
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        
        displayValue = brain.result
    }
}

