//
//  ResultViewController.swift
//  Simple Interest Calculator
//
//  Created by Sathyanarayana on 3/27/25.
//

import UIKit

class ResultViewController: UIViewController {
    
    var prinicpal:Double!
    var roi:Double!
    var time:Double!
    var si:Double!
    var category:String!
    
    @IBOutlet weak var principalOutputOL: UILabel!
    
    @IBOutlet weak var roiOutputOL: UILabel!
    
    @IBOutlet weak var timeOutputOL: UILabel!
    
    @IBOutlet weak var siOutputOL: UILabel!
    
    @IBOutlet weak var siCategoryImageOL: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        principalOutputOL.text = String(format:"Entered prinicipal : %.2f",Double(prinicpal))
        roiOutputOL.text = String(format:"Entered Rate of Interest : %.2f %",Double(roi))
        timeOutputOL.text = String(format:"Entered time : %.2f",Double(time))
        siOutputOL.text = String(format: """
            The Calculated Simple Interest is : %.2f
            Simple Interest category : %@
            """, Double(si), String(category))
        siCategoryImageOL.alpha = 0.0
        UIView.animate(withDuration: 2, animations: {
            self.siCategoryImageOL.alpha = 1.0
                })
        siCategoryImageOL.image = UIImage(named: category)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
