//
//  ViewController.swift
//  Voice Notes 2
//
//  Created by Sathyanarayana on 4/2/25.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {


        @IBOutlet weak var recordButton: UIButton!
        @IBOutlet weak var allRecordingsButton: UIButton!
        @IBOutlet weak var settingsButton: UIButton!

        override func viewDidLoad() {
            super.viewDidLoad()
            
            recordButton.setImage(UIImage(named: "record"), for: .normal)
        }

        // Prepare for segue to RecordingViewController
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "recordSegue" {
                
            } else if segue.identifier == "allRecordingsSegue" {
                
            } else if segue.identifier == "settingsSegue" {
                
            } else if segue.identifier == "favouritesSegue"{
                
            }
        }
    }
