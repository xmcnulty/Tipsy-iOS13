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
    
    func calculateSplit() -> Float? {
        let multiplier = 1.0 + tip
        
        return bill.map { b in
            (b * multiplier) / Float(people)
        }
    }
}
