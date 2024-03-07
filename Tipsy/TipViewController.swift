//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class TipViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var splitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureTextField()
        configureTapGesture()
        calculateButton.isEnabled = false
    }
    
    private func configureTextField() {
        billTextField.delegate = self
    }
    
    // Stop editing and close keyboard when view tapped
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TipViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        print("Tap was called.")
        view.endEditing(true)
    }
    
    @IBAction func splitStepperChanged(_ sender: UIStepper) {
        splitLabel.text = String(Int(sender.value))
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("Replacing text: ")
        print("Range - \(range.lowerBound), \(range.upperBound)")
        print(string)
        
        // only allow one decimal point
        if string == "." && textField.text?.contains(".") ?? false {
            return false
        }
        
        if range.lowerBound == 0 && range.upperBound == 0 && string == "." {
            textField.text = "0."
            
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil {
            calculateButton.isEnabled = false
            
            return
        }
        
        if let value = Float(textField.text!) {
            if value == 0.0 {
                calculateButton.isEnabled = false
                textField.text = ""
            } else {
                textField.text = String(format: "%.2f", value)
                calculateButton.isEnabled = true
            }
        } else {
            textField.text = ""
            
            calculateButton.isEnabled = false
        }
    }
}

