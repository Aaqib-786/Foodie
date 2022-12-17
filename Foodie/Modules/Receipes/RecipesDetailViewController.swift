//
//  RecipesDetailViewController.swift
//  Foodie
//
//  Created by Aaqib Seliya on 13/12/2022.
//

import UIKit
import NVActivityIndicatorView
import SDWebImage

class RecipesDetailViewController: UIViewController {
    
    static func instantiate() -> RecipesDetailViewController {
        let name = String(describing: RecipesDetailViewController.self)
        let storyboard = UIStoryboard(name: "ReceipesViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)
        return viewController as! RecipesDetailViewController
    }
    
    @IBOutlet weak var receipesImageView: UIImageView!
    @IBOutlet weak var receipesTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    var receipesDetails: ReceipesListModel!
    var reciepeSteps: [ReciepeSteps] = []
    var currentImageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.type = .ballRotateChase
        receipesTableView.delegate = self
        receipesTableView.dataSource = self
        receipesTableView.rowHeight = UITableView.automaticDimension
        receipesTableView.estimatedRowHeight = 44.0
        AppConstants.savedCurrentReceipe = receipesDetails
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.populateData()
        self.fetchReceipesSteps(id: receipesDetails.id)
    }
    
    func populateData() {
        receipesImageView.sd_setImage(with: URL(string: receipesDetails.image), placeholderImage: UIImage(named: "placeholder"))
    }
    
    func fetchReceipesSteps(id: Int) {
        reciepeSteps = []
        let url = "\(AppConstants.BASE_URL)/\(id)/analyzedInstructions?apiKey=\(AppConstants.API_KEY)"
        activityIndicatorView.startAnimating()
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
            if error != nil {
                Utils.showAlert(title: "Error!", message: error!.localizedDescription)
                return
            } else {
                if let data = data {
                    do {
                        self.reciepeSteps = try JSONDecoder().decode([ReciepeSteps].self, from: data)
                        AppConstants.reciepeSteps = self.reciepeSteps
                        DispatchQueue.main.async {
                            self.currentImageCache.setObject((self.receipesImageView.image ?? UIImage(named: "placeholder"))!,
                                                           forKey: "currentImage")
                        }
                        
                        DispatchQueue.main.async {
                            self.receipesTableView.reloadData()
                        }
                    } catch  {
                        Utils.showAlert(title: "Data Parsing Error!", message: error.localizedDescription)
                    }
                }
                
            }
        })
        .resume()
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RecipesDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return reciepeSteps.first?.steps.count ?? 0
        }
        return section == 0 ? receipesDetails.usedIngredients.count : receipesDetails.missedIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 2 {
            let cell = receipesTableView.dequeueReusableCell(withIdentifier: "ReceipesStepsViewCell", for: indexPath) as! ReceipesStepsViewCell
            if let step = reciepeSteps.first?.steps[indexPath.row] {
                cell.stepNumlbl.text = "Step \(step.number):"
                cell.stepDesclbl.text = "\(step.step)"
            }
            return cell
        } else {
            let cell = receipesTableView.dequeueReusableCell(withIdentifier: "ReceipesDetailTableViewCell", for: indexPath) as! ReceipesDetailTableViewCell
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



