//
//  ViewController.swift
//  HechioAutochek
//
//  Created by Steve Hechio on 08/06/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet weak var cartCountLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var filterImage: UIImageView!
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var brandCollectionView: UICollectionView!
    
    @IBOutlet weak var carsTableView: UITableView!
    
    let disposeBag = DisposeBag()
    let popularCars = PopularCarsRequest()
    let carsWebClient = CarsWebClient()
    var carModelResponse = CarsModelResponse()
    var carDetails = CarsListResult()
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
        
        setUpBrandsCollectionView()
        setUpTableView()
    }
    
    func setUpBrandsCollectionView(){
        popularCars.mPopularCars.bind(to: brandCollectionView.rx.items(cellIdentifier: "BrandsCollectionViewCell", cellType: BrandsCollectionViewCell.self)){
            (row, item, cell) in
            cell.setUpViews(urlString: item.imageUrl, name: item.name)
        }.disposed(by: disposeBag)
        
        popularCars.getPopularCars()
    }
    
    func setUpTableView(){
        carsWebClient.mCarsList.subscribe(onNext: {
            (carList) in
            self.carModelResponse = carList
            self.carsTableView.reloadData()
        }).disposed(by: disposeBag)
        //carsWebClient.getCarLists(currentPage: 1)
        getCarList(currentPage: 1)
    }
    
    func getCarList(currentPage: Int){
        carsWebClient.getCarListsObserver(currentPage: currentPage)
            .subscribe(
                onNext: { carsModelResponse in
                    if(carsModelResponse.result == nil){
                        self.getCarList(currentPage: currentPage + 1)
                        return
                    }
                    self.carModelResponse = carsModelResponse
                    DispatchQueue.main.async {
                        self.carsTableView.reloadData()
                    }
                }, onError: { error in
                    print("error: \(error)")
                }, onCompleted: {
                    print("Completed")
                }, onDisposed: {
                    print("Disposed")
                }
            ).disposed(by: disposeBag)
    }
    
    func perfomCarDetailsSegue() {
        navigationController?.performSegue(withIdentifier: "goToCarDetails", sender: self)
        let destinationVC  = navigationController?.topViewController as? CarDetailsViewController
        destinationVC?.carDetails = carDetails
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carModelResponse.result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarsTableViewCell", for: indexPath) as! CarsTableViewCell
        cell.setUpView(car: carModelResponse.result?[indexPath.row])
        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        carDetails = carModelResponse.result?[indexPath.row] ?? CarsListResult()
        perfomCarDetailsSegue()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = (carModelResponse.result?.count ?? 0) - 2
        var currentPage = carModelResponse.pagination?.currentPage ?? 1
        let totalPages = carModelResponse.pagination?.pageSize ?? 1
        if indexPath.row == lastItem {
            if currentPage > totalPages {
                currentPage = 1
                getCarList(currentPage: currentPage)
            }else {
                currentPage += 1
                getCarList(currentPage: currentPage)
            }
            
        }
    }
}
