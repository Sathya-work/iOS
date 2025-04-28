//
//  ViewController.swift
//  VoterEligibilityApp
//
//  Created by Sathyanarayana on 1/28/25.
//

import UIKit
 
class ViewController: UIViewController {
    
    @IBOutlet weak var inputOL: UITextField!
    
    @IBOutlet weak var outputOL: UILabel!
    
    @IBOutlet weak var imageviewOL: UIImageView!
    
    @IBAction func submitBtnClicked(_ sender: UIButton) {

                let age = inputOL.text!
                let doubleAge:Double = Double(age)!
                if doubleAge>18{
                    outputOL.text="Eligible🗳️"
                    imageviewOL.image=UIImage(named:"eligible.jpg")
                }
                else{
                    imageviewOL.image=UIImage(named:"noteligible.jpg")
                    outputOL.text="Not Eligible🔞"
                }
            }
        }
