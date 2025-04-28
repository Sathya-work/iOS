//
//  ViewController.swift
//  Initials App
//
//  Created by Sathyanarayana on 1/30/25.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var fNameOL: UITextField!
    
    @IBOutlet weak var lNameOL: UITextField!
        
    @IBOutlet weak var outputOL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func submitBtn(_ sender: Any) {
        let fName = fNameOL.text!
        let lName = lNameOL.text!
        
        //Generate the intials from the text given
        
        let intials = "\(fName.first!)\(lName.first!)"
        
        outputOL.text = "Your intials are " + intials.uppercased()
    }
    

}

