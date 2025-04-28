//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Sathyanarayana on 4/8/25.
//

import UIKit

class Product {
    var name: String
    var description: String
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewOL.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        
        cell.textLabel?.text = productArray[indexPath.row].name
        
        return cell
    }
    

    @IBOutlet weak var tableViewOL: UITableView!
    var productArray = [Product]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableViewOL.dataSource = self
        tableViewOL.delegate = self
        
        
        
        let product1 = Product(name: "iPhone 13", description: "This is a new iPhone 13")
        productArray.append(product1)
        let product2 = Product(name: "MacBook Pro", description: "This is a new MacBook Pro")
        productArray.append(product2)
        let product3 = Product(name: "AirPods Pro", description: "This is a new AirPods Pro")
        productArray.append(product3)
        let product4 = Product(name: "iMac", description: "This is a new iMac")
        productArray.append(product4)
        let product5 = Product(name: "Apple Watch Series 7", description: "This is a new Apple Watch Series 7")
        productArray.append(product5)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var transition = segue.identifier
        if transition == "ResultSegue" {
            var destination = segue.destination as! ResultViewController
            destination.product = productArray[(tableViewOL.indexPathForSelectedRow?.row)!]
        }
    }

}

