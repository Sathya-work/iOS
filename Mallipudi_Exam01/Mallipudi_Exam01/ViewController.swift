    //
    //  ViewController.swift
    //  Mallipudi_Exam01
    //
    //  Created by Sathyanarayana on 2/25/25.
    //

    import UIKit

    class ViewController: UIViewController {
        
        @IBOutlet weak var pm2InputOL: UITextField!
        
        @IBOutlet weak var pm10InputOL: UITextField!
        
        @IBOutlet weak var imageOL: UIImageView!
        
        @IBOutlet weak var outputOL: UILabel!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }
        
        @IBAction func checkBtn(_ sender: UIButton) {
            var pm25: Double = 0
                var pm10: Double = 0
                var aqc: Double = 0
                
                if let pm25Str = pm2InputOL.text, !pm25Str.isEmpty,
                   let pm10Str = pm10InputOL.text, !pm10Str.isEmpty,
                   let pm25Value = Double(pm25Str), let pm10Value = Double(pm10Str) {
                    pm25 = pm25Value
                    pm10 = pm10Value
                    aqc = (pm25 + pm10) / 2
                } else {
                    outputOL.text = "Please enter valid numeric values for both PM 2.5 and PM 10"
                    imageOL.image = nil
                    return
                }
                
                if aqc < 50 {
                    outputOL.text = "The AQC value is " + String(format: "%.1f", aqc) + " This is considered to be the best👍 quality air."
                    imageOL.image = UIImage(named: "Best")
                } else if aqc < 100 {
                    outputOL.text = "The AQC value is " + String(format: "%.1f", aqc) + " This is considered to be moderate quality air🙁."
                    imageOL.image = UIImage(named: "Moderate")
                } else {
                    outputOL.text = "The AQC value is " + String(format: "%.1f", aqc) + " This is considered to be the poor quality air.😢"
                    imageOL.image = UIImage(named: "Poor")
                }
        }

        
        @IBAction func resetBtn(_ sender: UIButton) {
            pm2InputOL.text = ""
            pm10InputOL.text = ""
            outputOL.text = ""
            imageOL.image = nil
        }

    }

