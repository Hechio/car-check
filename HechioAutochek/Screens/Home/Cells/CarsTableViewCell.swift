//
//  CarsTableViewCell.swift
//  HechioAutochek
//
//  Created by Steve Hechio on 16/06/2022.
//

import UIKit

class CarsTableViewCell: UITableViewCell {

    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var gradeScoreLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carImage.layer.cornerRadius = 15
        carImage.clipsToBounds = true
        
        detailsView.layer.cornerRadius = 15
        detailsView.clipsToBounds = true
    }
    
    func setUpView(car: CarsListResult?){
        guard let car = car else {return}
        carImage.load(url: URL(string: car.imageUrl!)!)
        priceLabel.text = "Ksh. \(car.marketplacePrice ?? 0)"
        conditionLabel.text = car.sellingCondition ?? "condition"
        titleLabel.text = car.title
        gradeScoreLabel.text = "\(car.gradeScore?.rounded() ?? 0.0)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
