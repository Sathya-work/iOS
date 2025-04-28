//
//  ViewController.swift
//  Bmi_mvc
//
//  Created by Sathyanarayana on 3/25/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightInFeetOL: UITextField!
    
    @IBOutlet weak var heightInInchesOL: UITextField!
    
    @IBOutlet weak var weightInLbsOL: UITextField!
    
    var categoryName = ""
    var imgName = ""
    var healthTip = ""
    var bmiValue = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func calculateBtn(_ sender: Any) {
        var heightInFeet = Double(heightInFeetOL.text!)!
        var heightInInches = Double(heightInInchesOL.text!)!
        var weightInLbs = Double(weightInLbsOL.text!)!
        
        var height = (heightInFeet * 12) + heightInInches
        bmiValue = 703 * (weightInLbs / Double(height * height))
        
        if(bmiValue <= 18.5){
            categoryName = "Underweight"
            imgName = "underWeight"
            healthTip = "Eat more protein and healthy fats."
        }
        else if(bmiValue <= 24.9){
            categoryName = "Normal"
            imgName = "normal"
            healthTip = "Excellent! Maintain a balanced lifestyle."
        }
        else{
            categoryName = "Overweight"
            imgName = "overWeight"
            healthTip = "Lose weight by maintaining a balanced diet less and increasing physical activity."
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var transition = segue.identifier
        if transition == "ResultSegue" {
            var destination = segue.destination as! ResultViewController
            destination.heightInFeet = heightInFeetOL.text!
            destination.heightInInches = heightInInchesOL.text!
            destination.weightInLbs = weightInLbsOL.text!
            
            destination.categoryName = categoryName
            destination.imgName = imgName
            destination.healthTip = healthTip
            destination.bmiValue = bmiValue
        }
    }
}

