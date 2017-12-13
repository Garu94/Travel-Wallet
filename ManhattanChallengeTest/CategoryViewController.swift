//
//  CategoryViewController.swift
//  ManhattanChallengeTest
//
//  Created by Simone Garuglieri on 13/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var categoryName: String!
    var trip: Trip!
    var total: Float = 0.0
    var expenses: [Expense] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var expensePriceLabel: UILabel!
    @IBOutlet weak var expenseOptionalNote: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryName
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //Get expenses of the category
        expenses = CoreDataController.shared.loadExpensesOfCategoryGivenTrip(trip: trip, category: categoryName)
        
        //Calculate total expenses of the category
        for expense in expenses {
            total += expense.price
        }
        
        totalPriceLabel.text = String(total)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let expenseInCell = expenses[indexPath.row]
        cell?.textLabel?.text = String(expenseInCell.price)
        cell?.detailTextLabel?.text = expenseInCell.note
        
        return cell!
    }


}
