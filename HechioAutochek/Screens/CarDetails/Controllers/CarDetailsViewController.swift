//
//  CarDetailsViewController.swift
//  HechioAutochek
//
//  Created by Steve Hechio on 08/06/2022.
//

import UIKit
import AVFoundation
import AVKit
import RxSwift
import RxCocoa

class CarDetailsViewController: UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartView: UILabel!
    
    @IBOutlet weak var bookVisitButton: UIButton!
    @IBOutlet weak var backButton: UIImageView!
    @IBOutlet weak var imageVideoView: UIView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var carDetailsView: UIView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var gradeScoreLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var fuelType: UILabel!
    
    let carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    var carDetails = CarsListResult()
    let carsWebClient = CarsWebClient()
    let disposebag = DisposeBag()
    var player = AVPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        setUpViews()
    }
    
    func setUpViews(){
        try! AVAudioSession.sharedInstance().setCategory(.playback)
        cartView.layer.cornerRadius = 15
        cartView.clipsToBounds = true
        
        cartView.layer.borderWidth = 2
        cartView.layer.borderColor = UIColor.white.cgColor
        
        tableView.separatorStyle = .none
        
        actionButton.layer.cornerRadius = 10
        actionButton.clipsToBounds = true
        
        bookVisitButton.layer.cornerRadius = 8
        bookVisitButton.clipsToBounds = true
        
        imageVideoView.layer.cornerRadius = 15
        imageVideoView.clipsToBounds = true
        
        imageVideoView.layer.borderWidth = 2
        imageVideoView.layer.borderColor = UIColor.white.cgColor
        
        carDetailsView.layer.cornerRadius = 15
        carDetailsView.clipsToBounds = true
        
        tabBarController?.tabBar.isHidden = true
        
        titleLabel.text = carDetails.title
        priceLabel.text = "Ksh. \(carDetails.marketplacePrice ?? 0)"
        conditionLabel.text = carDetails.sellingCondition ?? "condition"
        gradeScoreLabel.text = "\(carDetails.gradeScore?.rounded() ?? 0.0)"
        fuelType.text = carDetails.fuelType
        
        let tab = UITapGestureRecognizer(target: self, action: #selector(self.handleBackTap(_:)))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(tab)
        
        setUpMediaCollectionView()
        generateTableData()
    }
    
    @objc func handleBackTap(_ sender: UITapGestureRecognizer){
        navigationController?.popViewController(animated: true)
    }
    
    func setUpMediaCollectionView(){
        collectionView.delegate = nil
        collectionView.dataSource = nil
        carsWebClient.mCarMedia.bind(to: collectionView.rx.items(cellIdentifier: "CarImagesCollectionViewCell", cellType: CarImagesCollectionViewCell.self)){
            (row, item, cell) in
            cell.setUpViews(urlString: item.url, type: item.type)
        }.disposed(by: disposebag)
        
        carsWebClient.mCarMedia.subscribe { carMediaList in
            self.setSelectedImage(urlString: carMediaList[0].url)
        }.disposed(by: disposebag)
        
        Observable.zip(
            collectionView
                .rx
                .itemSelected
            ,collectionView
                .rx
                .modelSelected(CarMediaList.self)
        )
        .bind{ [unowned self] indexPath, model in
            let cell = self.collectionView.cellForItem(at: indexPath) as? CarImagesCollectionViewCell
            let selectedPaths = collectionView.indexPathsForSelectedItems
            for pathIndex in selectedPaths! {
                collectionView.deselectItem(at: pathIndex, animated: true)
                let cellSelected = self.collectionView.cellForItem(at: pathIndex) as? CarImagesCollectionViewCell
                cellSelected?.onSelected()
            }
            cell?.onSelected(selected: true)
            cell?.isSelected = true
            if model.type == MediaType.video.rawValue {
                setSelectedVideo(urlString: model.url)
            }else {
                setSelectedImage(urlString: model.url)
            }
        }
        .disposed(by: disposebag)
        
        carsWebClient.getCarMedia(carId: carDetails.id!)
    }
    func setSelectedVideo(urlString: String){
        imageVideoView.subviews.forEach({ $0.removeFromSuperview() })
        //let url = URL(string:  urlString)!
        let playerItem = AVPlayerItem( url:NSURL( string:urlString )! as URL )
        player = AVPlayer(playerItem: playerItem)
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        self.addChild(playerController)
        imageVideoView.addSubview(playerController.view)
        playerController.view.frame = CGRect(x: 0, y: 0, width: 310, height: 217)
        player.play()
    }
    
    func setSelectedImage(urlString: String){
        imageVideoView.subviews.forEach({ $0.removeFromSuperview() })
        let url = URL(string:  urlString)!
        carImageView.frame = CGRect(x: 0, y: 0, width: 310, height: 217)
        imageVideoView.addSubview(carImageView)
        imageVideoView.bringSubviewToFront(carImageView)
        carImageView.load(url: url)
    }
    
    func  generateTableData(){
        carsWebClient.mCarDetails.bind(to: tableView.rx.items(cellIdentifier: "CarDetailsTableViewCell", cellType: CarDetailsTableViewCell.self)){
            (row, item, cell) in
            if (row % 2 == 0) {
                cell.backgroundColor = .systemGray6
            } else {
                cell.backgroundColor = .white
            }
            cell.setUpView(carDetail: item)
        }.disposed(by: disposebag)
        carsWebClient.getListOfDetails(car: carDetails)
    }
}
