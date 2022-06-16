//
//  ViewController.swift
//  HechioAutochek
//
//  Created by Steve Hechio on 08/06/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var cartCountLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var filterImage: UIImageView!
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var brandCollectionView: UICollectionView!
    
    @IBOutlet weak var carsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    func configureViews(){
        cartCountLabel.layer.cornerRadius = 15
        cartCountLabel.clipsToBounds = true
        
        cartCountLabel.layer.borderWidth = 2
        cartCountLabel.layer.borderColor = UIColor.white.cgColor
        
        filterView.layer.cornerRadius = 3
        filterView.clipsToBounds = true
        
        carsTableView.delegate = self
        carsTableView.dataSource = self
        
        brandCollectionView.delegate = self
        brandCollectionView.dataSource = self
    }

    func perfomCarDetailsSegue() {
        navigationController?.performSegue(withIdentifier: "goToCarDetails", sender: self)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarsTableViewCell", for: indexPath) as! CarsTableViewCell
        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        perfomCarDetailsSegue()
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandsCollectionViewCell", for: indexPath) as! BrandsCollectionViewCell
        cell.setUpViews()
        return cell
    }
    
   
}
