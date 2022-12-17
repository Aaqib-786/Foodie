//
//  IngredientsData.swift
//  Foodie
//
//  Created by Aaqib Seliya on 13/12/2022.
//

import Foundation

class IngredientData {
    
     var ingredientData : [IngredientDataModel]  = [.init(id: 0, name: "avocado", code: "9037") ,
                                                          .init(id: 1, name: "bacon", code: "10123") ,
                                                          .init(id: 2, name: "banana", code: "9040"),
                                                          .init(id: 3, name: "beef", code: "23572"),
                                                          .init(id: 4, name: "black pepper", code: "1002030"),
                                                          .init(id: 5, name: "cat fish filets", code: "15010"),
                                                          .init(id: 6, name: "cauliflower", code: "11135"),
                                                          .init(id: 7, name: "celery", code: "11143"),
                                                          .init(id: 8, name: "cheese", code: "1041009"),
                                                          .init(id: 9, name: "cherry tomatoes", code: "10311529"),
                                                          .init(id: 10, name: "chicken base", code: "6080"),
                                                          .init(id: 11, name: "chicken wings", code: "5100"),
                                                          .init(id: 12, name: "chili powder", code: "2009"),
                                                          .init(id: 13, name: "clarified butter", code: "93632"),
                                                          .init(id: 14, name: "clove", code : "1002011"),
                                                          .init(id: 15, name: "coconut", code: "12104"),
                                                          .init(id: 16, name: "corn", code: "11168"),
                                                          .init(id: 17, name: "cream", code: "1053"),
                                                          .init(id: 18, name: "fish", code: "10115261"),
                                                          .init(id: 19, name: "garlic", code: "11215"),
                                                          .init(id: 20, name: "ginger", code: "11216"),
                                                          .init(id: 21, name: "lamb", code: "10017224"),
                                                          .init(id: 22, name: "ham", code: "10151"),
                                                          .init(id: 23, name: "lemon", code: "9150"),
                                                          .init(id: 24, name: "meat", code: "1015006"),
                                                          .init(id: 25, name: "pasta", code: "20420"),
                                                          .init(id: 26, name: "Peanuts", code: "16091"),
                                                          .init(id: 27, name: "Pork", code: "10010219"),
                                                          .init(id: 28, name: "Pumpkin", code: "11422"),
                                                          .init(id: 29, name: "Salami", code: "7071"),
                                                          .init(id: 30, name: "Sausage", code: "1017063"),
                                                          .init(id: 31, name: "tofu", code: "16213"),
                                                          .init(id: 32, name: "tortilla", code: "18364"),
                                                          .init(id: 33, name: "yogurt", code: "1116"),
                                                          .init(id: 34, name: "yeast", code: "18375"),
                                                          .init(id: 35, name: "vinegar", code: "2053"),
                                                          .init(id: 36, name: "walnuts", code: "12155"),
                                                          .init(id: 37, name: "turnips", code: "11564"),
                                                          .init(id: 38, name: "turmeric", code: "2043"),
                                                          .init(id: 39, name: "tuna", code: "10015121"),
                                                          .init(id: 40, name: "tamari", code: "10116124"),
                                                          .init(id: 41, name: "tahini", code: "12698"),
                                                          .init(id: 42, name: "sugar", code: "19335"),
                                                          .init(id: 43, name: "stout", code: "93619"),
                                                          .init(id: 44, name: "spinach", code: "10011457"),
                                                          .init(id: 45, name: "spaghetti", code: "11420420"),
                                                          .init(id: 46, name: "sherry", code: "10114106"),
                                                          .init(id: 47, name: "salt", code: "2047"),
                                                          .init(id: 48, name: "sage", code: "2038"),
                                                          .init(id: 49, name: "rice", code: "20444"),
                                                          .init(id: 50, name: "raisins", code: "9299"),
                                                          .init(id: 51, name: "radishes", code: "11429"),
                                                          .init(id: 52, name: "quinoa", code: "20035"),
                                                          .init(id: 53, name: "potatoes", code: "11362"),
                                                          .init(id: 54, name: "pesto", code: "93698"),
                                                          .init(id: 55, name: "peppers", code: "10111333"),
                                                          .init(id: 56, name: "pepperoni", code: "7057"),
                                                          .init(id: 57, name: "peas", code: "11304"),
                                                          .init(id: 58, name: "parsley", code: "11297"),
                                                          .init(id: 59, name: "paprika", code: "2028"),
                                                          .init(id: 60, name: "orzo", code: "10920420"),
                                                          .init(id: 61, name: "onion", code: "11282"),
                                                          .init(id: 62, name: "oil", code: "4582"),
                                                          .init(id: 63, name: "nutella", code: "19125"),
                                                          .init(id: 64, name: "nori", code: "11446"),
                                                          .init(id: 65, name: "mustard", code: "2046"),
                                                          .init(id: 66, name: "mushroom", code: "11260"),
                                                          .init(id: 67, name: "milk", code: "1077"),
                                                          .init(id: 68, name: "mango", code: "9176"),
                                                          .init(id: 69, name: "maple syrup", code: "19911"),
                                                          .init(id: 70, name: "lime", code: "9159"),
                                                          .init(id: 71, name: "ladyfingers", code: "18423"),
                                                          .init(id: 72, name: "jalapeno", code: "11979"),
                                                          .init(id: 73, name: "jaggery", code: "99002"),
                                                          .init(id: 74, name: "hot sauce", code: "6168"),
                                                          .init(id: 75, name: "fresh corn", code: "11167"),
                                                          .init(id: 76, name: "flour", code: "20081"),
                                                          .init(id: 77, name: "fennel", code: "11957"),
                                                          .init(id: 78, name: "eggplant", code: "11209"),
                                                          .init(id: 79, name: "cup cake", code:"18139"),
                                                          .init(id: 80, name: "cucumber", code: "11206"),
                                                          .init(id: 81, name: "corn flour", code: "20019"),
                                                          .init(id: 82, name: "cinnamon stick", code: "1002010"),
                                                          .init(id: 83, name: "chili peppers", code: "11962"),
                                                          .init(id: 84, name: "chili sauce", code: "6972"),
                                                          .init(id: 85, name: "cereal", code: "8029"),
                                                          .init(id: 86, name: "carrots", code: "11124"),
                                                          .init(id: 87, name: "cardamom", code: "2006"),
                                                          .init(id: 88, name: "caramels", code: "19074"),
                                                          .init(id: 89, name: "cabbage", code: "11109"),
                                                          .init(id: 90, name: "buttermilk", code: "1230"),
                                                          .init(id: 91, name: "butter", code: "1001")
                                                          
                                                        ]

    public static var shared : IngredientData = .init()
    
}

struct IngredientDataModel: Hashable {
    var id : Int
    var name : String
    var code : String
    var isIngredientSelected : Bool = false
}
