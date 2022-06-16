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
    override func awakeFromNib() {
        super.awakeFromNib()
        carImage.layer.cornerRadius = 15
        carImage.clipsToBounds = true
        
        detailsView.layer.cornerRadius = 15
        detailsView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
