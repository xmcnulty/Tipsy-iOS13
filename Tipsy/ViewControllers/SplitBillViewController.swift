//
//  SplitBillViewController.swift
//  Tipsy
//
//  Created by Xavier McNulty on 3/6/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

class SplitBillViewController: UIViewController {
    
    @IBOutlet weak var splitBillLabel: UILabel!
    @IBOutlet weak var splitDescriptionLabel: UILabel!
    
    
    var tipCalculator: TipCalculator?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        splitBillLabel.text = tipCalculator?.getSplit() ?? "Error"
        
        splitDescriptionLabel.text = tipCalculator?.splitDescription() ?? "Error"
    }
    

    @IBAction func recalculateButton(_ sender: UIButton) {
        self.dismiss(animated: true)
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
