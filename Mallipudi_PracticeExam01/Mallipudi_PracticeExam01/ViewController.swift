//
//  ViewController.swift
//  Mallipudi_PracticeExam01
//
//  Created by Sathyanarayana on 2/20/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var heightInFeetOL: UITextField!
    
    @IBOutlet weak var heightInInchOL: UITextField!
    
    @IBOutlet weak var weightInLbOL: UITextField!
    
    @IBOutlet weak var outputOL: UILabel!
    
    @IBOutlet weak var imageOL: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateBMI(_ sender: UIButton) {
        let heightInFeet = Double(heightInFeetOL.text ?? "0")!
        let heightInInch = Double(heightInInchOL.text ?? "0")!
        let weightInLb = Double(weightInLbOL.text ?? "0")!
        
        let height = heightInFeet * 12 + heightInInch
        let bmiValue = 703 * (weightInLb / pow(height, 2))
        
        //Print
        if(bmiValue <= 18.5){
            outputOL.text = "Your Body Mass Index is " + String(format: "%.1f", bmiValue) + "\nThis is considered Underweight🪫 \nHealthTip: Eat more protein and healthy fats."
            imageOL.image = UIImage(named: "underWeight")
        }
        else if(bmiValue <= 24.9){
            outputOL.text = "Your Body Mass Index is " + String(format: "%.1f", bmiValue) + "\n" + "This is considered Normal👍 \nHealthTip: Excellent! Maintain a balanced lifestyle."
            imageOL.image = UIImage(named: "normal")
        }
        else if(bmiValue <= 29.9){
            outputOL.text = "Your Body Mass Index is " + String(format: "%.1f", bmiValue) + "\nThis is considered Overweight.\nHealthTip: Lose weight by maintaining a balanced diet less and increasing physical activity."
            imageOL.image = UIImage(named: "overWeight")
        }
        else if (bmiValue >= 30){
            outputOL.text = "Your Body Mass Index is " + String(format: "%.1f", bmiValue) + "\nThis is considered Obese.\nHealthTip: Consult a doctor for personalized advice."
            imageOL.image = UIImage(named: "obese")
        }
    }
    
}

