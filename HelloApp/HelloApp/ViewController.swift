//
//  ViewController.swift
//  HelloApp
//
//  Created by Mallipudi,Sathyanarayana on 1/21/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputOL: UITextField!
    
    @IBOutlet weak var outputOL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

         @IBAction func submitButton(_ sender: UIButton) {
         //Read the text field data and assign it to a variable
        
        var name = inputOL.text!
        
        //Display the output in the format ("Hello,\(name)!")
        
        outputOL.text = "Hello, \(name)!"
    }
    
}

