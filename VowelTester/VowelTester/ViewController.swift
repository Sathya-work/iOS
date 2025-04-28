//
//  ViewController.swift
//  VowelTester
//
//  Created by Sathyanarayana on 1/28/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputOL: UITextField!
    
    @IBOutlet weak var outputOL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkBtn(_ sender: UIButton) {
        
        var str:String = inputOL.text!
        
        var count:Int = 0
        
        for i in str{
            
            if(i == "a" || i == "e" || i == "i" || i == "o" || i == "u"){
                
                count += 1
            }
        }
        
        outputOL.text = "Number of Vowels: \(count)"
        
    }
    

}

