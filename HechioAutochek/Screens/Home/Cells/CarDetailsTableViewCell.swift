//
//  CarDetailsTableViewCell.swift
//  HechioAutochek
//
//  Created by Steve Hechio on 16/06/2022.
//

import UIKit

class CarDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpView(carDetail: CarDetail){
        fieldLabel.text = carDetail.field
        valueLabel.text = "\(carDetail.value)"
    }
}
