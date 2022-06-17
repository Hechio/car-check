//
//  CarImagesCollectionViewCell.swift
//  HechioAutochek
//
//  Created by Steve Hechio on 16/06/2022.
//

import UIKit
import AVFoundation

class CarImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var carMedia: UIImageView!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        carMedia.image = nil
    }
    
    func onSelected(selected: Bool = false){
        if(selected){
            self.contentView.layer.borderColor = UIColor.systemGray4.cgColor
            self.contentView.layer.borderWidth = 2
        }else {
            self.contentView.layer.borderColor = nil
            self.contentView.layer.borderWidth = 0
        }
    }
    
    func setUpViews(urlString: String, type: String){
        let url = URL(string:  urlString)!
        if type == MediaType.video.rawValue {
            if let thumbnailImage = getThumbnailImage(forUrl: url) {
                carMedia.image = thumbnailImage
            }
        }else {
            carMedia.load(url: url)
        }
        self.contentView.layer.cornerRadius = 10
        self.contentView.clipsToBounds = true
    }
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
}
