//
//  CurrentViewController.swift
//  Foodie
//
//  Created by Aaqib Seliya on 09/12/2022.
//

import UIKit
import SDWebImage

class CurrentViewController: UIViewController {

    static func instantiate() -> CurrentViewController {
        let name = String(describing: CurrentViewController.self)
        let storyboard = UIStoryboard(name: "CurrentViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)
        return viewController as! CurrentViewController
    }
    
    @IBOutlet weak var receipesTableView: UITableView!
    @IBOutlet weak var receipeImageView: UIImageView!
    
    var currentImageCache = NSCache<NSString, UIImage>()
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let cacheImage = currentImageCache.object(forKey: "currentImage") {
            receipeImageView.image = cacheImage
        }
        
        if AppConstants.savedCurrentReceipe != nil {
            receipeImageView.sd_setImage(with: URL(string: AppConstants.savedCurrentReceipe?.image ?? ""))
        }
        
        receipesTableView.delegate = self
        receipesTableView.dataSource = self
        receipesTableView.reloadData()
    }
}

extension CurrentViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if AppConstants.reciepeSteps.count == 0 || AppConstants.savedCurrentReceipe == nil {
            self.receipesTableView.setEmptyMessage("No Current Recipe")
        } else {
            self.receipesTableView.restore()
        }
        
        if section == 2 {
            return AppConstants.reciepeSteps.first?.steps.count ?? 0
        }
        return section == 0 ? AppConstants.savedCurrentReceipe?.usedIngredients.count ?? 0 : AppConstants.savedCurrentReceipe?.missedIngredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 2 {
            let cell = receipesTableView.dequeueReusableCell(withIdentifier: "ReceipesCurrentStepsViewCell", for: indexPath) as! ReceipesCurrentStepsViewCell
            if let step = AppConstants.reciepeSteps.first?.steps[indexPath.row] {
                cell.stepNumlbl.text = "Step \(step.number):"
                cell.stepDesclbl.text = "\(step.step)"
            }
            return cell
        } else {
            let cell = receipesTableView.dequeueReusableCell(withIdentifier: "ReceipesCurrentDetailTableViewCell", for: indexPath) as! ReceipesCurrentDetailTableViewCell
            guard let receipesDetails = AppConstants.savedCurrentReceipe else {return UITableViewCell()}
            if indexPath.section == 0 && receipesDetails.usedIngredients.count > 0 {
                cell.IngredientTypeLbl.text = indexPath.row == 0 ? "Used Ingredients" : ""
                cell.IngredientTypeLbl.isHidden = indexPath.row == 0 ? false : true
                let item = receipesDetails.usedIngredients[indexPath.row]
                cell.IngredientImageView.sd_setImage(with: URL(string: receipesDetails.usedIngredients[indexPath.row].image), placeholderImage: UIImage(named: "placeholder"))
                cell.IngredientDescLbl.text = "\(item.original)"
            } else if indexPath.section == 1 && receipesDetails.missedIngredients.count > 0 {
                cell.IngredientTypeLbl.text = indexPath.row == 0 ? "Missed Ingredients" : ""
                cell.IngredientTypeLbl.isHidden = indexPath.row == 0 ? false : true
                let item = receipesDetails.missedIngredients[indexPath.row]
                cell.IngredientImageView.sd_setImage(with: URL(string: receipesDetails.missedIngredients[indexPath.row].image), placeholderImage: UIImage(named: "placeholder"))
                cell.IngredientDescLbl.text = "\(item.original)"
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class ReceipesCurrentStepsViewCell: UITableViewCell {
    @IBOutlet weak var stepNumlbl: UILabel!
    @IBOutlet weak var stepDesclbl: UILabel!
}

class ReceipesCurrentDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var IngredientTypeLbl: UILabel!
    @IBOutlet weak var IngredientDescLbl: UILabel!
    @IBOutlet weak var IngredientImageView: UIImageView!
}
