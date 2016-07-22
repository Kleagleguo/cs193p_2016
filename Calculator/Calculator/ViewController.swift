//
//  ViewController.swift
//  Calculator
//
//  Created by Bingkun Guo on 7/12/16.
//  Copyright © 2016 Bingkun Guo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet private weak var display: UILabel!

  private var userIsInTheMiddleOfTyping = false
  
  private var brian = CalculatorBrian()
  
  // Computed property
  var displayValue: Double {
    get {
      return Double(display.text!)!
    }
    set {
      display.text = String(newValue)
    }
  }

  @IBAction private func touchDigit(sender: UIButton) {
    let digit = sender.currentTitle!
    if userIsInTheMiddleOfTyping {
      let currText = display.text!
      display.text = currText + digit
    } else {
      display.text = digit
    }
    userIsInTheMiddleOfTyping = true
  }
  
  @IBAction private func performOperation(sender: UIButton) {
    if userIsInTheMiddleOfTyping {
      brian.setOperand(displayValue)
      userIsInTheMiddleOfTyping = false
    }
    if let mathematicalSymbol = sender.currentTitle {
      brian.performOperation(mathematicalSymbol)
    }
    displayValue = brian.result
  }
}

