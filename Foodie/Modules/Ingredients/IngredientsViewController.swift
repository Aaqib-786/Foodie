//
//  IngredientsViewController.swift
//  Foodie
//
//  Created by Aaqib Seliya on 13/12/2022.
//

import UIKit

class IngredientsViewController: UIViewController {
    
    static func instantiate() -> IngredientsViewController {
        let name = String(describing: IngredientsViewController.self)
        let storyboard = UIStoryboard(name: "IngredientsViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)
        return viewController as! IngredientsViewController
    }
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var searchBtn: UIButton!
    
    var listData = IngredientData.shared.ingredientData
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.allowsMultipleSelection = true
        mainTableView.allowsSelection = true
        searchBtn.layer.cornerRadius = searchBtn.frame.height / 2
    }
    
    
    @IBAction func searchBtnTapped(_ sender: UIButton) {
        let elements = AppConstants.selectedIngredientList
        let updatedElements = Array(Set(elements))
        print(updatedElements)
        if updatedElements.count == 0 {
            Utils.showAlert(title: "Error!", message: "Please select the your required Ingredient.")
        } else {
            self.tabBarController?.selectedIndex = 1
        }
    }
}

extension IngredientsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientCell
        cell.checkBoxText.text = listData[indexPath.row].name
        let item = listData[indexPath.row]
        cell.checkBoxImageView.image = listData[item.id].isIngredientSelected ? UIImage(named:"check-mark") : UIImage(named:"unCheck")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = listData[indexPath.row]
        
        listData[item.id].isIngredientSelected.toggle()
        
        if AppConstants.selectedIngredientList.contains(item.name) {
            AppConstants.selectedIngredientList = AppConstants.selectedIngredientList.filter({$0 != item.name})
        } else {
            AppConstants.selectedIngredientList.append(item.name)
        }
        
        print(AppConstants.selectedIngredientList)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

class IngredientCell: UITableViewCell {
    @IBOutlet weak var checkBoxImageView: UIImageView!
    @IBOutlet weak var checkBoxText: UILabel!
    
    override func awakeFromNib() {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //        checkBoxImageView.image = selected ? UIImage(named:"check-mark") : UIImage(named:"unCheck")
    }
}
