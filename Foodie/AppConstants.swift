//
//  AppConstants.swift
//  Foodie
//
//  Created by Aaqib Seliya on 13/12/2022.
//

import UIKit

public struct AppConstants {
    
    static var ingredientName = ""
    static var selectedIngredientList: [String] = []
    static let BASE_URL = "https://api.spoonacular.com/recipes"
    static let API_KEY = "df8dbc79d53d49c8a1d3da5447b69c68"
    static var savedCurrentReceipe: ReceipesListModel?
    static var reciepeSteps: [ReciepeSteps] = []
    
    struct TableViewIdentifiers {
        static let message = "MessageTableViewCell"
        static let conversation = "ConversationListTableViewCell"
    }
    
    struct PlaceHolders {
        static let fullName = "Enter your full name"
        static let email = "Enter your email"
        static let password = "Enter your password"
        static let confirmPassword = "Confirm your password"
    }
    
    struct Keys {
        static let currentNonce = "CURRENT_NONCE"
        static let noMatchPassword = "Your password did not match."
        static let isUserLoggedIn = "IS_USER_LOGGED_IN"
        static let email = "USER_EMAIL"
        static let valuesInitialized = "APP_SETTINGS_VALUES_INITIALIZED"
    }
    
    struct Message {
        static let resetMessage = "A link has sent to your email address, please check your email to reset password."
        static let inviteToApp = "This user is not using TICKON. Please invite the user to download the app."
        static let noConversation = "No Conversation Selected"
        static let gridMessage = "Write your Grid message"
        static let recipientEmail  = "enter recipient email"
    }
}



struct Color {
    static let offWhite: UIColor = UIColor(named: "offWhite")!
    static let coralPink: UIColor = UIColor(named: "coralPink")!
    static let lightSkyBlue: UIColor = UIColor(named: "lightSkyBlue")!
    static let veryLightBlue: UIColor = UIColor(named: "veryLightBlue")!
    static let coolGray: UIColor = UIColor(named: "coolGray")!
    static let bluishGrey: UIColor = UIColor(named: "bluishGrey")!
    static let clearBlue: UIColor = UIColor(named: "clearBlue")!
    static let lightPink: UIColor = UIColor(named: "lightPink")!
    static let darkText: UIColor = UIColor(named: "darkText")!
    static let paleGrey: UIColor = UIColor(named: "paleGrey")!
    static let turquoise: UIColor = UIColor(named: "turquoise")!
    static let lightBlueGrey: UIColor = UIColor(named: "lightBlueGrey")!
    static let iceBlue: UIColor = UIColor(named: "iceBlue")!
    static let lightBlueGreyTwo: UIColor = UIColor(named: "lightBlueGreyTwo")!
    static let iceBlueTwo: UIColor = UIColor(named: "iceBlueTwo")!
    static let shadowColor: UIColor = UIColor(named: "shadow")!
    static let tabBarText: UIColor = UIColor(named: "tabBarText")!
    static let cloudyBlue: UIColor = UIColor(named: "cloudyBlue")!
    static let tabbarInactive: UIColor = UIColor(named: "tabbarInactive")!
    static let slateGrey: UIColor = UIColor(named: "slateGrey")!
    static let powderBlue: UIColor = UIColor(named: "powderBlue")!
    static let tagsColor: UIColor = UIColor(named: "tagsColor")!
    static let tagsIceBlue: UIColor = UIColor(named: "tagsIceBlue")!
    static let navyBlue: UIColor = UIColor(named: "navyBlue")!
    static let lightGreyBlue: UIColor = UIColor(named: "lightGreyBlue")!
    static let veryLightPink: UIColor = UIColor(named: "veryLightPink")!
    static let lightBlue: UIColor = UIColor(named: "lightBlue")!
}
