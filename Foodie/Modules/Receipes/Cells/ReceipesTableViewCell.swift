//
//  ReceipesTableViewCell.swift
//  Foodie
//
//  Created by Aaqib Seliya on 13/12/2022.
//

import UIKit

class ReceipesTableViewCell: UITableViewCell {
    @IBOutlet weak var receipesImageView: UIImageView!
    @IBOutlet weak var receipesNamelbl: UILabel!
    @IBOutlet weak var receipesLikelbl: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        receipesImageView.layer.cornerRadius = 10
        backView.layer.cornerRadius = 10
    }
}
