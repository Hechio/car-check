//
//  BrandsCollectionViewCell.swift
//  HechioAutochek
//
//  Created by Steve Hechio on 16/06/2022.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var carBrandImage: UIImageView!
    
    func setUpViews(){
        carBrandImage.layer.cornerRadius = 40
        carBrandImage.clipsToBounds = true
    }
    
}
