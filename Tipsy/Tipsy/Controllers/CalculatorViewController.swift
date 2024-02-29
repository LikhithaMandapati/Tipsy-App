//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet var billTextField: UITextField!
    @IBOutlet var zeroPctButton: UIButton!
    @IBOutlet var tenPctButton: UIButton!
    @IBOutlet var twentyPctButton: UIButton!
    @IBOutlet var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var stepper = 2.0
    var amountPerPerson = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billTextField.text = ""
        splitNumberLabel.text = "2"
        stepper = 2
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        let buttonTitle = Double(String(sender.currentTitle!.dropLast()))!
        tip = buttonTitle / 100
    }
    
    @IBAction func stepValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        stepper = Double(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = Double(billTextField.text!)!
        amountPerPerson = (bill + (bill * tip)) / stepper
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.result = String(format: "%.2f", amountPerPerson)
            destinationVC.split = Int(stepper)
            destinationVC.tip = "\(Int(tip * 100))%"
        }
    }
}

