//
//  ViewController.swift
//  Mallipudi_SearchApp
//
//  Created by Sathyanarayana on 3/31/25.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
        
    @IBOutlet weak var searchTextField: UITextField!
    
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var prevImageButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var nextImageButton: UIButton!
    @IBOutlet weak var topicDescriptionTextView: UITextView!
    
        
        var selectedTopicIndex = 0
        var selectedImageIndex = 0
        
        let topics = ["Famous Landmarks", "Space Exploration", "Popular Festivals", "Wildlife Wonders", "Inventions & Innovations"]
        
        let topicImages = [
            ["eiffeltower", "greatwall", "mountrushmore"],
            ["moonlanding", "marsrover", "hubble"],
            ["diwali", "carnival", "oktoberfest"],
            ["tiger", "panda", "eagle"],
            ["lightbulb", "airplane", "computer"]
        ]
        
        let topicKeywords = [
            ["landmark", "architecture", "monument"],
            ["space", "astronomy", "exploration"],
            ["festival", "celebration", "event"],
            ["wildlife", "animals", "nature"],
            ["innovation", "invention", "technology"]
        ]
        
        let topicDescriptions = [
            ["Eiffel Tower: An iron lattice tower in Paris, France, and one of the most recognizable structures in the world.",
             "Great Wall of China: A historic fortification stretching over 13,000 miles, built to protect Chinese states.",
             "Mount Rushmore: A massive sculpture in South Dakota, USA, featuring the faces of four U.S. presidents—George Washington, Thomas Jefferson, Theodore Roosevelt, and Abraham Lincoln. It was completed in 1941 and symbolizes American history and leadership."],
            
            ["Moon Landing: NASA's Apollo 11 mission landed humans on the Moon in 1969.",
             "Mars Rover: Robotic explorers like Curiosity and Perseverance are exploring Mars for signs of life.",
             "Hubble Telescope: A space telescope that has provided breathtaking images of the universe."],
            
            ["Diwali: The Hindu festival of lights, celebrating the victory of good over evil.",
             "Carnival: A grand celebration with parades and masquerades, most famous in Rio de Janeiro.",
             "Oktoberfest: The world's largest beer festival, held annually in Munich, Germany."],
            
            ["Tiger: A majestic wild cat known for its power and agility, found in Asia.",
             "Panda: A black-and-white bear native to China, known for its bamboo diet.",
             "Eagle: A powerful bird of prey symbolizing freedom and strength."],
            
            ["Lightbulb: Invented by Thomas Edison, revolutionizing the way humans illuminate spaces.",
             "Airplane: The Wright brothers' innovation that changed global transportation forever.",
             "Computer: The foundation of modern computing and digital technology."]
        ]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupInitialView()
            searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
        
        func setupInitialView() {
            resultImageView.image = UIImage(named: "welcome")
            topicDescriptionTextView.text = "Hello, Sathyanarayana !!"
            searchButton.isEnabled = false
            nextImageButton.isEnabled = false
            prevImageButton.isEnabled = false
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            searchButton.isEnabled = !(textField.text?.isEmpty ?? true)
        }
        
        @IBAction func searchButtonTapped(_ sender: Any) {
            guard let searchText = searchTextField.text?.lowercased(), !searchText.isEmpty else { return }
            
            if let matchedIndex = topicKeywords.firstIndex(where: { $0.contains(searchText) }) {
                selectedTopicIndex = matchedIndex
                selectedImageIndex = 0
                displayImage()
                AudioServicesPlaySystemSound(1113)
            } else {
                resultImageView.image = UIImage(named: "error")
                topicDescriptionTextView.text = "No results found for \(searchText)"
            }
        }
        
        func displayImage() {
            let images = topicImages[selectedTopicIndex]
            if selectedImageIndex < images.count {
                resultImageView.image = UIImage(named: images[selectedImageIndex])
                topicDescriptionTextView.text = topicDescriptions[selectedTopicIndex][selectedImageIndex]
            }
            updateButtonStates()
        }
        
        @IBAction func nextImageTapped(_ sender: Any) {
            if selectedImageIndex < topicImages[selectedTopicIndex].count - 1 {
                selectedImageIndex += 1
                displayImage()
                AudioServicesPlaySystemSound(1105)
            }
        }
        
        @IBAction func prevImageTapped(_ sender: Any) {
            if selectedImageIndex > 0 {
                selectedImageIndex -= 1
                displayImage()
                AudioServicesPlaySystemSound(1105)
            }
        }
        
        @IBAction func resetTapped(_ sender: Any) {
            setupInitialView()
            searchTextField.text = ""
            selectedTopicIndex = 0
            selectedImageIndex = 0
            AudioServicesPlaySystemSound(1111)
        }
        
        func updateButtonStates() {
            prevImageButton.isEnabled = selectedImageIndex > 0
            nextImageButton.isEnabled = selectedImageIndex < topicImages[selectedTopicIndex].count - 1
        }
    }


