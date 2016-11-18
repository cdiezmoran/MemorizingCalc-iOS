//
//  Operation.swift
//  MemorizingCalc
//
//  Created by Carlos Diez on 11/16/16.
//  Copyright © 2016 cdiezm. All rights reserved.
//

import Foundation


class Operation {
  var firstOperand: Int
  var secondOperand: Int
  var operation: OperationType
  var result: Int
  
  init(firstOperand: Int, secondOperand: Int, operation: OperationType, result: Int) {
    self.firstOperand = firstOperand
    self.secondOperand = secondOperand
    self.operation = operation
    self.result = result
  }
  
  func constructString() -> String {
    return "\(self.firstOperand) " + self.operation.rawValue + " \(self.secondOperand) = \(self.result)"
  }
}
