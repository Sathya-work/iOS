//
//  ViewController.swift
//  Mallipudi_TravelBooking
//
//  Created by Sathyanarayana on 4/17/25.
//

import UIKit

class BookingViewController: UIViewController {
    
    @IBOutlet weak var travellerNameOL: UITextField!
    
    @IBOutlet weak var noOfTravellersOL: UITextField!
    
    @IBOutlet weak var cabinTypeOL: UITextField!
    
    var travellerName = ""
    var noOfTravellers = 0
    var cabinType = ""
    var price = 0
    var result = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func bookNowButton(_ sender: UIButton) {
        travellerName = travellerNameOL.text!
        noOfTravellers = Int(noOfTravellersOL.text!)!
        cabinType = cabinTypeOL.text!
        
        if(cabinType.lowercased() == "economy"){
            price = 150
            result = price * noOfTravellers
        }
        if(cabinType.lowercased() == "luxury"){
            price = 250
            result = price * noOfTravellers
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var transition = segue.identifier
        if(transition == "resultSegue"){
            var destination = segue.destination as! MallipudiResultViewController
            destination.travellerName = travellerName
            destination.noOfTravellers = noOfTravellers
            destination.cabinType = cabinType
            destination.result = result
        }
    }
    
}

