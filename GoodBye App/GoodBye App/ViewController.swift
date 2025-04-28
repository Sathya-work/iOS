//
//  ViewController.swift
//  GoodBye App
//
//  Created by Sathyanarayana on 1/27/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputFNameOL: UITextField!
    
    
    @IBOutlet weak var inputLNameOL: UITextField!
    
    
    @IBOutlet weak var outputOL: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func submitButton(_ sender: UIButton) {
        var fname = inputFNameOL.text!
        var lname = inputLNameOL.text!
        
        outputOL.text = "Goodbye, \(fname) \(lname)!"
    }
    
    }
