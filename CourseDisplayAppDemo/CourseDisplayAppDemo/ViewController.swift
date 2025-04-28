//
//  ViewController.swift
//  CourseDisplayAppDemo
//
//  Created by Sathyanarayana on 2/11/25.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var ImageViewOL: UIImageView!
    
    @IBOutlet weak var crsNumOL: UILabel!
    
    
    @IBOutlet weak var crsTitleOL: UILabel!
    
    @IBOutlet weak var semOffOL: UILabel!
    
    
    @IBOutlet weak var previousOL: UIButton!
    
    @IBOutlet weak var nextOL: UIButton!
    
    
    let courses = [[44542,"Advanced Java Programming", "Fall","java"], [44642,"Patterns and Frameworks","Fall","patterns"], [44610,"Project Management", "Spring","project"]]
    var imageNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let courseNumber = courses[0][0]
        let courseTitle = courses[0][1]
        let semOffered = courses[0][2]
        ImageViewOL.image = UIImage(named: "java")
        crsNumOL.text = "\(courseNumber)"
        crsTitleOL.text = "\(courseTitle)"
        semOffOL.text = "\(semOffered)"
        
        //previous button is disabled
        previousOL.isEnabled = false
        nextOL.isEnabled = true
    }

    @IBAction func previousBtnClick(_ sender: UIButton) {
        imageNumber-=1
        
        updateCourseDetails(imageNumber: imageNumber)
        
        if(imageNumber == 0){
            previousOL.isEnabled = false
        }
        nextOL.isEnabled = true
    }
    
    @IBAction func nextBtnClick(_ sender: Any) {
        
        imageNumber+=1
        
        updateCourseDetails(imageNumber: imageNumber)
        
        previousOL.isEnabled = true
        
        if(imageNumber == courses.count - 1){
            nextOL.isEnabled = false
        }
    }
    
    func updateCourseDetails(imageNumber:Int){
        ImageViewOL.image = UIImage(named: courses[imageNumber][3] as! String)
        crsNumOL.text = "\(courses[imageNumber][0])"
        crsTitleOL.text = "\(courses[imageNumber][1])"
        semOffOL.text = "\(courses[imageNumber][2])"
    }
}

