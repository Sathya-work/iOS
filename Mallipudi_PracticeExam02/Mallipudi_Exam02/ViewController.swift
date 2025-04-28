//
//  ViewController.swift
//  Mallipudi_Exam02
//
//  Created by Sathyanarayana on 4/1/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var activityInputOL: UITextField!
    
    @IBOutlet weak var durationInputOL: UITextField!
    
    @IBOutlet weak var caloriesInputOL: UITextField!
    
    @IBOutlet weak var calculateBtnOL: UIButton!
    
    var activityInput: String = ""
    var durationInput: Int = 0
    var caloriesInput: Int = 0
    var totalCaloriesBurned: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
    }
    
    func reset(){
        activityInputOL.text! = ""
        durationInputOL.text! = ""
        caloriesInputOL.text! = ""
    }
    
    @IBAction func calculateBtnClick(_ sender: Any) {
        activityInput = activityInputOL.text!
        durationInput = Int(durationInputOL.text!)!
        caloriesInput = Int(caloriesInputOL.text!)!
        
        totalCaloriesBurned = durationInput * caloriesInput
        print("Segue to ResultViewController triggered")
                print("Activity: \(activityInput), Duration: \(durationInput), Calories: \(caloriesInput), Total: \(totalCaloriesBurned)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var transition = segue.identifier
        if(transition == "ResultSegue"){
            var destination = segue.destination as! ResultViewController
            
            destination.activityInput2 = activityInput
            destination.durationInput2 = durationInput
            destination.caloriesInput2 = caloriesInput
            destination.totalCaloriesBurned2 = totalCaloriesBurned
        }
    }
    
    @IBAction func resetBtnClick(_ sender: Any) {
        reset()
    }
    
    
    
    @IBAction func textFieldEditingChange(_ textField: UITextField) {
        let isActivityFilled = !(activityInputOL.text?.isEmpty ?? true)
                let isDurationFilled = !(durationInputOL.text?.isEmpty ?? true)
                let isCaloriesFilled = !(caloriesInputOL.text?.isEmpty ?? true)
                
                calculateBtnOL.isEnabled = isActivityFilled && isDurationFilled && isCaloriesFilled
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//            reset()
//        }
}

