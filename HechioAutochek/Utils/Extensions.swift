//
//  Extensions.swift
//  HechioAutochek
//
//  Created by Steve Hechio on 17/06/2022.
//

import UIKit
import SVGKit

extension UIImageView {
    
    func loadSVG(url: URL){
        let loadingActivityIndicator: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView()
            
            indicator.style = .medium
            indicator.color = UIColor(named: "OrangeColor")
            
            indicator.startAnimating()
            
            // Setting the autoresizing mask to flexible for all
            // directions will keep the indicator in the center
            // of the view and properly handle rotation.
            indicator.autoresizingMask = [
                .flexibleLeftMargin, .flexibleRightMargin,
                .flexibleTopMargin, .flexibleBottomMargin
            ]
            
            return indicator
        }()
        loadingActivityIndicator.center = CGPoint(
            x: self.bounds.midX,
            y: self.bounds.midY
        )
        loadingActivityIndicator.tag = 25
        self.addSubview(loadingActivityIndicator)
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data , error == nil else {
                return
            }
            DispatchQueue.main.async {
                print(data)
                if let mView = self?.viewWithTag(25) {
                    mView.removeFromSuperview()
                }
                guard let image: SVGKImage = SVGKImage(data: data as Data) else {
                    guard let img  = UIImage(data: data) else {
                        return
                    }
                    self?.image = img
                    return
                }
                self?.image = image.uiImage
                
            }
        }.resume()
    }
    
    
    func load(url: URL) {
        let loadingActivityIndicator: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView()
            
            indicator.style = .medium
            indicator.color = UIColor(named: "OrangeColor")
            
            indicator.startAnimating()
            
            // Setting the autoresizing mask to flexible for all
            // directions will keep the indicator in the center
            // of the view and properly handle rotation.
            indicator.autoresizingMask = [
                .flexibleLeftMargin, .flexibleRightMargin,
                .flexibleTopMargin, .flexibleBottomMargin
            ]
            
            return indicator
        }()
        loadingActivityIndicator.center = CGPoint(
            x: self.bounds.midX,
            y: self.bounds.midY
        )
        loadingActivityIndicator.tag = 23
        self.addSubview(loadingActivityIndicator)
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if let mView = self?.viewWithTag(23) {
                            mView.removeFromSuperview()
                        }
                        self?.image = nil
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIViewController {
    func showLoadingActivityIndicator(_ show: Bool){
        let loadingActivityIndicator: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView()
            
            indicator.style = .large
            indicator.color = UIColor(named: "OrangeColor")
            
            //indicator.startAnimating()
            
            // Setting the autoresizing mask to flexible for all
            // directions will keep the indicator in the center
            // of the view and properly handle rotation.
            indicator.autoresizingMask = [
                .flexibleLeftMargin, .flexibleRightMargin,
                .flexibleTopMargin, .flexibleBottomMargin
            ]
            
            return indicator
        }()
        loadingActivityIndicator.center = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )
        loadingActivityIndicator.tag = 32
        view.addSubview(loadingActivityIndicator)
        
        if show {
            loadingActivityIndicator.isHidden = false
            if !loadingActivityIndicator.isAnimating{
                loadingActivityIndicator.startAnimating()
            }
        } else {
            if let mView = view.viewWithTag(32) {
                mView.removeFromSuperview()
            }
            loadingActivityIndicator.isHidden = true
            if loadingActivityIndicator.isAnimating{
                loadingActivityIndicator.stopAnimating()
            }
        }
        
    }
}

