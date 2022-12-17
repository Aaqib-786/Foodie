//
//  ReciepeSteps.swift
//  Foodie
//
//  Created by Aaqib Seliya on 13/12/2022.
//

import Foundation

struct ReciepeSteps: Codable{
    var steps : [Steps]
}

struct Steps: Codable{
    let number : Int
    let step : String
    var id : Int {
        return number
    }
}
