//
//  CarDetailsViewController.swift
//  HechioAutochek
//
//  Created by Steve Hechio on 08/06/2022.
//

import UIKit

class CarDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartView: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
        setUpViews()
    }
    
    func setUpViews(){
        cartView.layer.cornerRadius = 15
        cartView.clipsToBounds = true
        
        cartView.layer.borderWidth = 2
        cartView.layer.borderColor = UIColor.white.cgColor
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        actionButton.layer.cornerRadius = 10
        actionButton.clipsToBounds = true
        
        let path = UIBezierPath(roundedRect:bottomView.bounds,
                                byRoundingCorners:[.topRight, .bottomLeft],
                                cornerRadii: CGSize(width: 20, height:  20))

        let maskLayer = CAShapeLayer()

        maskLayer.path = path.cgPath
        bottomView.layer.mask = maskLayer
        tabBarController?.tabBar.isHidden = true
    }

}

extension CarDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarDetailsTableViewCell", for: indexPath)
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = .white
        } else {
            cell.backgroundColor = .systemGray6
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
}
