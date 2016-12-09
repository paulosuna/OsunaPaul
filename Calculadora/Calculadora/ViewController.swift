  //
//  ViewController.swift
//  Calculadora
//
//  Created by user on 11/11/16.
//  Copyright (c) 2016 cris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    @IBAction func appenDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
           display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
    }
    
    @IBAction func operate(_ sender: UIButton) {
        let operacion = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operacion {
        case "X": performOperacion { $0 * $1 }
        case "÷": performOperacion { $1 / $0 }
        case "✚": performOperacion { $0 + $1 }
        case "−": performOperacion { $1 - $0 }
        case "⚡️": performOperacion2 { sqrt($0) }
            
        default: break
            
        }
    }
    func performOperacion(_ operacion: (Double, Double) -> Double) {
        if operacionStack.count >= 2 {
            displayValue = operacion(operacionStack.removeLast(), operacionStack.removeLast())
            enter()
        }
    }
    
    func performOperacion2(_ operacion: (Double) -> Double) {
        if operacionStack.count >= 1 {
            displayValue = operacion(operacionStack.removeLast())
            enter()
        }
    }
    
    var operacionStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operacionStack.append(displayValue)
        print("operacionStack + \(operacionStack)")
    }
    var displayValue: Double {
        get {
            return NumberFormatter().number(from: display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }

}

