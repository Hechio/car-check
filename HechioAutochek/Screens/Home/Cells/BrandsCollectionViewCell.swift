//
//  BrandsCollectionViewCell.swift
//  HechioAutochek
//
//  Created by Steve Hechio on 16/06/2022.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var carBrandImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setUpViews(urlString: String, name: String){
        let url = URL(string:  urlString)!
        carBrandImage.loadSVG(url: url)
        carBrandImage.layer.cornerRadius = 30
        carBrandImage.clipsToBounds = true
        nameLabel.text = name
    }
    
    override func prepareForReuse() {
        self.carBrandImage.image = nil
        super.prepareForReuse()
    }
    
}
