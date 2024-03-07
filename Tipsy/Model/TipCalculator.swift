//
//  TipCalculator.swift
//  Tipsy
//
//  Created by Xavier McNulty on 3/6/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct TipCalculator {
    var bill: Float?
    var tip: Float
    var people: Int
    
    func getSplit() -> String? {
        let multiplier = 1.0 + tip
        
        return bill.map { b in
            let split = (b * multiplier) / Float(people)
            
            return String(format: "%.2f", split)
        }
    }
    
    func splitDescription() -> String {
        let percent = Int(tip * 100)
        
        return "Split between \(people) people, with \(percent)% tip."
    }
}
