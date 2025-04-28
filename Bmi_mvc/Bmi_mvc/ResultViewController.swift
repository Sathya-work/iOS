//
//  ResultViewController.swift
//  Bmi_mvc
//
//  Created by Sathyanarayana on 3/25/25.
//

import UIKit

class ResultViewController: UIViewController {
    
    var heightInFeet = ""
    var heightInInches = ""
    var weightInLbs = ""
    var categoryName = ""
    var imgName = ""
    var healthTip = ""
    var bmiValue = 0.0
    
    @IBOutlet weak var enteredHFeetOL: UILabel!
    
    @IBOutlet weak var enteredHInchesOL: UILabel!
    
    @IBOutlet weak var enteredWLbsOL: UILabel!
    
    @IBOutlet weak var outputOL: UILabel!
    
    @IBOutlet weak var imageOL: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enteredHFeetOL.text! += heightInFeet
        enteredHInchesOL.text! += heightInInches
        enteredWLbsOL.text! += weightInLbs
        
        outputOL.text! = """
    BMI Value: \(String(format: "%.1f", bmiValue))
    Category: \(categoryName)
    HealthTip: \(healthTip)
    """
        imageOL.image = UIImage(named: imgName)
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
