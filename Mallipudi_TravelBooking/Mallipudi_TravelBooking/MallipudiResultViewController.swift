//
//  MallipudiResultViewController.swift
//  Mallipudi_TravelBooking
//
//  Created by Sathyanarayana on 4/17/25.
//

import UIKit

class MallipudiResultViewController: UIViewController {
    
    @IBOutlet weak var imageOL: UIImageView!
    
    @IBOutlet weak var travellerNameOL: UILabel!
    
    @IBOutlet weak var noOfTravellersOL: UILabel!
    
    @IBOutlet weak var cabinTypeOL: UILabel!
    
    @IBOutlet weak var totalCostOL: UILabel!
    
    @IBOutlet weak var resultOL: UILabel!
    
    var travellerName = ""
    var noOfTravellers = 0
    var cabinType = ""
    var result = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        travellerNameOL.text! = "Traveller Name : \(travellerName)"
        noOfTravellersOL.text! = "No of Travellers : \(noOfTravellers)"
        cabinTypeOL.text! = "Cabin Type : \(cabinType)"
        totalCostOL.text! = "Total Cost : $\(result)"
        
        if(cabinType.lowercased() == "luxury"){
            resultOL.text = "Enjoy your Luxury Trip!"
            imageOL.image = UIImage(named: "luxury")
        }
        else if(cabinType.lowercased() == "economy"){
            resultOL.text = "Enjoy your Economy Trip!"
            imageOL.image = UIImage(named: "economy")
        }
        else{
            resultOL.text = "Please select a valid class"
            imageOL.image = UIImage(named: "invalid")
            cabinTypeOL.text = "Cabin Type :"
            totalCostOL.text = "Total Cost :"
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

}
