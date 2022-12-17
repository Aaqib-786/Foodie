//
//  ReceipesViewController.swift
//  Foodie
//
//  Created by Aaqib Seliya on 13/12/2022.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView

class ReceipesViewController: UIViewController {

    static func instantiate() -> ReceipesViewController {
        let name = String(describing: ReceipesViewController.self)
        let storyboard = UIStoryboard(name: "ReceipesViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name)
        return viewController as! ReceipesViewController
    }
    
    @IBOutlet weak var receipesTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    var receipesData: [ReceipesListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.type = .ballRotateChase
        receipesTableView.delegate = self
        receipesTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(AppConstants.ingredientName)")
        fetchReceipeFromAPI(ingredients: AppConstants.selectedIngredientList)
    }

    
    func fetchReceipeFromAPI(ingredients : [String]) {
        receipesData = []
        activityIndicatorView.startAnimating()
        
        var initialUrl = "\(AppConstants.BASE_URL)/findByIngredients?apiKey=\(AppConstants.API_KEY)&ingredients="
        
        for item in ingredients {
            initialUrl = "\(initialUrl)\(item),+"
        }
        
        initialUrl = String(initialUrl.dropLast())
        initialUrl = String(initialUrl.dropLast())
        
        let finalUrl = initialUrl.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        print(finalUrl)
        URLSession.shared.dataTask(with: URL(string: finalUrl)!, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
            
            if error != nil {
                Utils.showAlert(title: "Error!", message: error!.localizedDescription)
                return
            } else {
                if let data = data {
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 402 {
                            if let value = String(data: data, encoding: String.Encoding.ascii), let jsonData = value.data(using: String.Encoding.utf8) {
                                do {
                                    let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
                                    
                                    if let message = json["message"] as? String {
                                        Utils.showAlert(title: "Error!", message: message)
                                    }
                                    
                                } catch {
                                    NSLog("ERROR \(error.localizedDescription)")
                                }
                                
                            }
                            return
                        }
                    }
                    
                    do {
                         let decoder = JSONDecoder()
                        self.receipesData = try decoder.decode([ReceipesListModel].self, from: data)
                         DispatchQueue.main.async {
                           self.receipesTableView.reloadData()
                         }

                    } catch {
                        Utils.showAlert(title: "Error!", message: error.localizedDescription)
                    }
                    
                }
            }
        })
        .resume()
    }
}

extension ReceipesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receipesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = receipesTableView.dequeueReusableCell(withIdentifier: "ReceipesTableViewCell", for: indexPath) as! ReceipesTableViewCell
        if receipesData.count == 0 {
            return UITableViewCell()
        }
        cell.receipesImageView.sd_setImage(with: URL(string: receipesData[indexPath.row].image), placeholderImage: UIImage(named: "placeholder"))
        cell.receipesNamelbl.text = receipesData[indexPath.row].title
        cell.receipesLikelbl.text = "\(receipesData[indexPath.row].likes)"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if receipesData.count > 0 {
            let selectedItem = receipesData[indexPath.row]
            let vc = RecipesDetailViewController.instantiate()
            vc.receipesDetails = selectedItem
            self.present(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
