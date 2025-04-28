//
//  ViewController.swift
//  multiplescreens
//
//  Created by Sathyanarayana on 3/20/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var amountOL: UITextField!
    
    @IBOutlet weak var discountOL: UITextField!
    
    var priceAfterDiscount: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calcBtn(_ sender: UIButton) {
        
        var amount = Double(amountOL.text!)
        var discount = Double(discountOL.text!)
        
        priceAfterDiscount = amount! * (1 - discount!/100)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var transition = segue.identifier
        if transition == "ResultSegue"{
            var destination = segue.destination as! ResultViewController
            
            destination.amount = amountOL.text!
            destination.discount = discountOL.text!
            destination.priceAfterDiscount = String(priceAfterDiscount)
        }
    }
}

