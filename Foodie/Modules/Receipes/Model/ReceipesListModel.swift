//
//  ReceipesListModel.swift
//  Foodie
//
//  Created by Aaqib Seliya on 13/12/2022.
//

import Foundation

struct ReceipesListModel: Codable {
    let id : Int
    let title : String
    let image : String
    let likes : Int
    let usedIngredients : [ReciepeIngredientData]
    let missedIngredients : [ReciepeIngredientData]
}

struct ReciepeIngredientData: Codable {
    let amount : Double
    let unit : String
    let name : String
    let image : String
    let original: String
}
