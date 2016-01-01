//  ViewController.swift
//  tip$ter
//
//  Created by Mitali Avadhani on 12/2/15.
//  Copyright © 2015 Mitali Avadhani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billText: UITextField!
    @IBOutlet weak var peopleText: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var individualLabel: UILabel!
    var date = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //comment
    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        //var billAmount = billText.text as NSinteger
        let billAmount = (billText.text! as NSString).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        var peopleNumber = (peopleText.text! as NSString).doubleValue
        if peopleNumber < 1{
            peopleNumber = 1}
        let indtotal = total/peopleNumber
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format: "%.2f", total)
        individualLabel.text = String(format: "%.2f", indtotal)
    }

@IBAction func Save(sender: AnyObject) {
        // save indTot, the current individual total, and date, the current date
        // create string with date and amount
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .ShortStyle
        let saveStr = formatter.stringFromDate(date) + ":  $\(individualLabel)"
        // print("adding   \(saveStr)")
        // get current list & check if it already exists
        let defaults = NSUserDefaults.standardUserDefaults()
        var spendList = defaults.arrayForKey("SpendList")
        if (spendList == nil) {
            // list doesn't exist, initialize to array with new amount
            spendList = [ saveStr ]
        } else {
            // list exists, append new amount to it
            spendList!.append(saveStr)
        }
        // save updated list
        defaults.setObject(spendList, forKey: "SpendList")
    }


    /* 
    working on building second screen that displays saved values for spendings and date
    @IBOutlet weak var displayList: UILabel!
    @IBAction func showSimpleAlert(sender: AnyObject) {
        let alert = UIAlertView(title: "Recent Spending", message: "Spend 1 SPend 2", delegate: self, cancelButtonTitle:"back")
        alert.show()
    }
     func ViewSpending(sender: AnyObject) {
        displayList.text = "Spendlist #1\n SpendList #2"

        // print the spending list
        
        //get current list & check if it already exists
        let defaults = NSUserDefaults.standardUserDefaults()
    
        var spendList = defaults.arrayForKey("SpendList")

        if (spendList == nil) {
            // print( "SpendList is Empty")
            displayList.text = "Spendlist is Empty"
        }
        else {
            
            let nItems = spendList!.count
            displayList.text = String(format: "%f", nItems)

            for index in 0...nItems-1 {
                print( "\(index+1):  \(spendList![index])")
            }
        }
    }
    */
    
    @IBAction func OnTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

