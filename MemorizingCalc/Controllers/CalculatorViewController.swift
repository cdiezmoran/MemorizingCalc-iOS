//
//  ViewController.swift
//  MemorizingCalc
//
//  Created by Carlos Diez on 11/16/16.
//  Copyright © 2016 cdiezm. All rights reserved.
//

import UIKit

enum OperationType: String {
  case addition = "+"
  case substraction = "-"
  case none = ""
}

class CalculatorViewController: UIViewController {

  
  // MARK: Outlets
  
  @IBOutlet weak var operationsLabel: UILabel!
  @IBOutlet weak var computedResultsLabel: UILabel!
  
  
  // MARK: Properties
  var numbersToApply = (x: 0, y: 0)
  var currentOperation: OperationType = .none
  var operations = [Operation]() {
    didSet {
      computedResultsLabel.text = "Computed results: \(operations.count)"
    }
  }
  
  
  // MARK: View Controller Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    operationsLabel.text = ""
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showOperations" {
      let operationsTableViewController = segue.destination as! OperationsTableViewController
      operationsTableViewController.operations = operations
    }
  }
  
  
  // MARK: Operator Actions
  
  @IBAction func clearClicked(_ sender: AnyObject) {
    numbersToApply = (x: 0, y: 0)
    operationsLabel.text = ""
  }
  
  @IBAction func plusClicked(_ sender: AnyObject) {
    if operationsLabel.text == "" {
      return
    }
    
    updateNumbers(withOperation: .addition)
  }
  
  @IBAction func minusClicked(_ sender: AnyObject) {
    if operationsLabel.text == "" {
      return
    }
    
    updateNumbers(withOperation: .substraction)
  }
  
  @IBAction func equalClicked(_ sender: AnyObject) {
    if numbersToApply.x == 0 && numbersToApply.y == 0 {
      return
    }
    
    if operationsLabel.text != "" {
      if numbersToApply.x != 0 && numbersToApply.y == 0 {
        numbersToApply.y = Int(operationsLabel.text!)!
        operationsLabel.text = String(doOperation())
      }
      else if numbersToApply.x != 0 && numbersToApply.y != 0 {
        numbersToApply.x = doOperation()
        numbersToApply.y = Int(operationsLabel.text!)!
        operationsLabel.text = String(doOperation())
      }
    }
    else {
      if numbersToApply.x != 0 && numbersToApply.y != 0 {
        operationsLabel.text = String(doOperation())
      }
      else {
        return
      }
    }
    
    numbersToApply = (x: 0, y:0)
  }
  
  
  // MARK: Number actions

  @IBAction func numberClicked(_ sender: AnyObject) {
    let currentText = operationsLabel.text
    
    if let text = currentText {
      operationsLabel.text = text + sender.currentTitle!!
    }
    else {
      if sender.currentTitle == "0" {
        return
      }
      
      operationsLabel.text = sender.currentTitle
    }
  }
  
  
  // MARK: Helper functions
  
  func updateNumbers(withOperation operation: OperationType) {
    currentOperation = operation
    
    if numbersToApply.x == 0 && numbersToApply.y == 0 {
      numbersToApply.x = Int(operationsLabel.text!)!
    }
    else if numbersToApply.x != 0 && numbersToApply.y == 0 {
      numbersToApply.y = Int(operationsLabel.text!)!
    }
    else if numbersToApply.x != 0 && numbersToApply.y != 0 {
      numbersToApply.x = doOperation()
      numbersToApply.y = Int(operationsLabel.text!)!
    }
    
    operationsLabel.text = ""
  }
  
  func doOperation() -> Int {
    var result: Int!
    
    switch currentOperation {
    case .addition: result =  numbersToApply.x + numbersToApply.y
    case .substraction: result = numbersToApply.x - numbersToApply.y
    case .none: result = 0
    }
    
    let operation = Operation(firstOperand: numbersToApply.x, secondOperand: numbersToApply.y, operation: currentOperation, result: result)
    
    operations.append(operation)
    
    return result
  }
}

