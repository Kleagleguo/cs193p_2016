//
//  CalculatorBrian.swift
//  Calculator
//
//  Created by Bingkun Guo on 7/14/16.
//  Copyright © 2016 Bingkun Guo. All rights reserved.
//

import Foundation

class CalculatorBrian
{
  private var accumulator = 0.0
  
  private var operations: Dictionary<String, Operation> = [
    "π" : Operation.Constant(M_PI),
    "e" : Operation.Constant(M_E),
    "-" : Operation.UnaryOperation({ -$0 }),
    "√" : Operation.UnaryOperation(sqrt),
    "cos": Operation.UnaryOperation(cos),
    "×": Operation.BinaryOperation({$0 * $1}),
    "÷": Operation.BinaryOperation({$0 / $1}),
    "+": Operation.BinaryOperation({$0 + $1}),
    "−": Operation.BinaryOperation({$0 - $1}),
    "=": Operation.Equals
  ]
  
  private enum Operation {
    case Constant(Double)
    case UnaryOperation((Double) -> Double)
    case BinaryOperation((Double, Double) -> Double)
    case Equals
  }
  
  private var pending: PendingBinaryOperationInFo?
  
  private struct PendingBinaryOperationInFo {
    var binaryFunction: (Double, Double) -> Double
    var firstOperand: Double
  }
  
  func setOperand(operand: Double) {
    accumulator = operand
  }
  
  func performOperation(symbol: String) {
    if let operation = operations[symbol] {
      switch operation {
      case .Constant(let value):
        accumulator = value
        break
      case .UnaryOperation(let function):
        accumulator = function(accumulator)
        break
      case .BinaryOperation(let function):
        executePendingBinaryOperation()
        pending = PendingBinaryOperationInFo(binaryFunction: function, firstOperand: accumulator)
        break
      case .Equals:
        executePendingBinaryOperation()
        break
      }
    }
  }
  
  private func executePendingBinaryOperation() {
    if pending != nil {
      accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
      pending = nil
    }
  }
  
  var result: Double {
    get {
      return accumulator
    }
  }
}