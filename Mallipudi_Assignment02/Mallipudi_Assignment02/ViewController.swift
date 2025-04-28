//
//  ViewController.swift
//  Mallipudi_Assignment02
//
//  Created by Sathyanarayana on 2/6/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameOutlet: UITextField!
    
    @IBOutlet weak var billAmountOutlet: UITextField!

    @IBOutlet weak var tipPercentageOutlet: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var billAmountLabel: UILabel!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func SubmitBtn(_ sender: UIButton) {
        let name: String = nameOutlet.text!
        let billAmount: Double = Double(billAmountOutlet.text!)!
        let tipPercentage: Double = Double(tipPercentageOutlet.text!)!
        
        let tipAmount: Double = (billAmount * tipPercentage) / 100
        let totalAmount: Double = billAmount + tipAmount
        
        nameLabel.text = "Name: \(name)"
        billAmountLabel.text = "Bill Amount: \(String(format: "%.2f", billAmount))"
        tipAmountLabel.text = "Tip Amount: \(String(format: "%.2f", tipAmount))"
        totalAmountLabel.text = "Total Amount: \(String(format: "%.2f", totalAmount))"
    }
    
    @IBAction func ResetBtn(_ sender: UIButton) {
        nameLabel.text = ""
        billAmountLabel.text = ""
        tipAmountLabel.text = ""
        totalAmountLabel.text = ""
        nameOutlet.text = ""
        billAmountOutlet.text = ""
        tipPercentageOutlet.text = ""
    }
}

