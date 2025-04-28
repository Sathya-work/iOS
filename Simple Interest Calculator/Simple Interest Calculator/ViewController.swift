//
//  ViewController.swift
//  Simple Interest Calculator
//
//  Created by Sathyanarayana on 3/27/25.
//

import UIKit

class ViewController: UIViewController {
    
    var prinicpal:Double!
    var roi:Double!
    var time:Double!
    var si:Double!
    var category:String!
    
    @IBOutlet weak var principalOL: UITextField!
    
    @IBOutlet weak var roiOL: UITextField!
    
    @IBOutlet weak var timeOL: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateBtn(_ sender: Any) {
        
        prinicpal = Double(principalOL.text!)
        roi = Double(roiOL.text!)
        time = Double(timeOL.text!)
        
        si = (prinicpal * roi * time)/100
        if(si<100)
        {
            category = "Low"
        }
        else if(si>=100 && si<500)
        {
            category = "Medium"
        }
        else
        {
            category = "High"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var transition = segue.identifier
        if transition == "ResultSegue"{
            var destination = segue.destination as! ResultViewController
            destination.prinicpal = prinicpal
            destination.roi = roi
            destination.time = time
            destination.si = si
            destination.category = category
        }
    }
    
}

