//
//  ViewController.swift
//  Mallipudi_Exam02
//
//  Created by Sathyanarayana on 4/3/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var goalInputOL: UITextField!
    
    @IBOutlet weak var amountInputOL: UITextField!
    
    @IBOutlet weak var interestInputOL: UITextField!
    
    @IBOutlet weak var yearsInputOL: UITextField!
    
    @IBOutlet weak var calculateBtnOL: UIButton!
    
    @IBOutlet weak var resetBtnOL: UIButton!
    
    var totalMonths: Double = 0.0
    var monthlyInterestRate : Double = 0.0
    var monthlySavingsPayment: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateBtnOL.isEnabled = false
        resetBtnOL.isEnabled = false
        goalInputOL.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        amountInputOL.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        interestInputOL.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        yearsInputOL.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        goalInputOL.text = ""
        amountInputOL.text = ""
        interestInputOL.text = ""
        yearsInputOL.text = ""
        
        }

    
    @objc func textFieldsChanged() {
        if let goal = goalInputOL.text, !goal.isEmpty,
           let amount = amountInputOL.text, !amount.isEmpty,
           let interest = interestInputOL.text, !interest.isEmpty,
           let years = yearsInputOL.text, !years.isEmpty {
            calculateBtnOL.isEnabled = true
            resetBtnOL.isEnabled = true
        } else {
            calculateBtnOL.isEnabled = false
            resetBtnOL.isEnabled = false
        }
    }
    
    @IBAction func calculateBtn(_ sender: UIButton) {
        var goalInput = goalInputOL.text!
        var amountInput = Double(amountInputOL.text!)!
        var interestInput = Double(interestInputOL.text!)!
        var yearsInput = Double(yearsInputOL.text!)!
        
        totalMonths = yearsInput * 12
        monthlyInterestRate = (interestInput / 100) / 12
        monthlySavingsPayment = amountInput / ((pow(1 + monthlyInterestRate, totalMonths ) - 1) / monthlyInterestRate)
    }
    
    @IBAction func resetBtn(_ sender: UIButton) {
        goalInputOL.text = ""
        amountInputOL.text = ""
        interestInputOL.text = ""
        yearsInputOL.text = ""
        calculateBtnOL.isEnabled = false
        resetBtnOL.isEnabled = false
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var transition = segue.identifier
        if transition == "ResultSegue" {
            var destination = segue.destination as! ResultViewController
            
            destination.totalMonths = totalMonths
            destination.monthlyInterestRate = monthlyInterestRate
            destination.monthlySavingsPayment = monthlySavingsPayment
            destination.goalInput = goalInputOL.text!
            destination.amountInput = Double(amountInputOL.text!)!
            destination.interestInput = Double(interestInputOL.text!)!
        }
    }
}

