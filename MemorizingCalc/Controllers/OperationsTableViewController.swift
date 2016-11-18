//
//  historyTableViewController.swift
//  MemorizingCalc
//
//  Created by Carlos Diez on 11/16/16.
//  Copyright © 2016 cdiezm. All rights reserved.
//

import UIKit

class OperationsTableViewController: UITableViewController {
  
  
  // MARK: Properties
  
  var operations = [Operation]() {
    didSet {
      tableView.reloadData()
    }
  }
  
  
  // MARK: View controller's life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  
  // MARK: Table View functions
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return operations.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "OperationsCell") as! OperationsTableViewCell
    
    let operation = operations[indexPath.row]
    
    cell.operationLabel.text = operation.constructString()
    
    return cell
  }
  
}
