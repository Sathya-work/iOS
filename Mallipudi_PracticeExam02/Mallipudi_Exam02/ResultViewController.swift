//
//  ResultViewController.swift
//  Mallipudi_Exam02
//
//  Created by Sathyanarayana on 4/1/25.
//

import UIKit

class ResultViewController: UIViewController {
    
    var activityInput2: String = ""
    var durationInput2: Int = 0
    var caloriesInput2: Int = 0
    var totalCaloriesBurned2: Int = 0

    @IBOutlet weak var activityOutputOL: UILabel!
    
    @IBOutlet weak var durationOutputOL: UILabel!
    
    @IBOutlet weak var caloriesOutputOL: UILabel!
    
    @IBOutlet weak var totalOutputOL: UILabel!
    
    @IBOutlet weak var imageOutputOL: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityOutputOL.text = "Activity Type: \(activityInput2)"
        durationOutputOL.text = "Duration: \(durationInput2)"
        caloriesOutputOL.text = "Calories Per Minute: \(caloriesInput2)"
        totalOutputOL.text = "Total Calories Burned: \(totalCaloriesBurned2)"
        imageOutputOL.alpha = 0.0
        UIView.animate(withDuration: 1.5) {
            self.imageOutputOL.alpha = 1.0
        }
        //imageOutputOL.image = UIImage(named: (activityInput))
    }
    
    
    
}
