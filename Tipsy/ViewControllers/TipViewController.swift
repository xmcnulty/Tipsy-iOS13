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
    
    // tip buttons
    @IBOutlet weak var tipButtonZero: UIButton!
    @IBOutlet weak var tipButtonTen: UIButton!
    @IBOutlet weak var tipButtonTwenty: UIButton!
    
    
    var tipCalculator = TipCalculator(tip: 0.10, people: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureTextField()
        configureTapGesture()
        
        tipButtonZero.addTarget(self, action: #selector(zeroButtonTapped), for: .touchUpInside)
        tipButtonTen.addTarget(self, action: #selector(tenButtonTapped), for: .touchUpInside)
        tipButtonTwenty.addTarget(self, action: #selector(twentyButtonTapped), for: .touchUpInside)
        
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
        view.endEditing(true)
    }
    
    @objc func zeroButtonTapped() {
        tipCalculator.tip = 0.0
        
        tipButtonZero.isSelected = true
        tipButtonTen.isSelected = false
        tipButtonTwenty.isSelected = false
    }
    
    @objc func tenButtonTapped() {
        tipCalculator.tip = 0.1
        
        tipButtonZero.isSelected = false
        tipButtonTen.isSelected = true
        tipButtonTwenty.isSelected = false
    }
    
    @objc func twentyButtonTapped() {
        tipCalculator.tip = 0.2
        
        tipButtonZero.isSelected = false
        tipButtonTen.isSelected = false
        tipButtonTwenty.isSelected = true
    }
    
    @IBAction func splitStepperChanged(_ sender: UIStepper) {
        splitLabel.text = String(Int(sender.value))
        
        tipCalculator.people = Int(sender.value)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // only allow one decimal point, and two decimal places.
        if textField.text?.contains(".") ?? false {
            if string.contains(".") {
                return false
            }
            
            let components = textField.text!.split(separator: ".")
            
            if components.count > 1 && components[1].count >= 2 && string != "" {
                return false
            }
        }
        
        if range.lowerBound == 0 && range.upperBound == 0 && string == "." {
            textField.text = "0."
            
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let fValue = Float(text) else {
            calculateButton.isEnabled = false
            tipCalculator.bill = nil
            textField.text = ""
            return
        }
        
        if fValue == 0 {
            calculateButton.isEnabled = false
            tipCalculator.bill = nil
            textField.text = ""
        } else {
            calculateButton.isEnabled = true
            tipCalculator.bill = fValue
            textField.text = String(format: "%.2f", fValue)
        }
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! SplitBillViewController
            
            destinationVC.tipCalculator = self.tipCalculator
        }
    }
}

