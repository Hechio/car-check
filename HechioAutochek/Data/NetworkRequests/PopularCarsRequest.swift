//
//  PopularCarsRequest.swift
//  HechioAutochek
//
//  Created by Steve Hechio on 17/06/2022.
//

import Foundation
import RxCocoa
import RxSwift

class PopularCarsRequest {
    private let REQUEST_ENDPOINT = "\(Constants.API_HOST)make?popular=true"
    
    let mPopularCars = PublishSubject<[MakeList]>()
    
    func getPopularCars(){
        let session = URLSession.shared
        let url = URL(string: REQUEST_ENDPOINT)!
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else {return}
            
            guard let data = data else {return}
           
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                print ("car data = \(jsonResponse)")
                let gsonResponse = try JSONDecoder().decode(PopularCars.self, from: data)
                DispatchQueue.main.async {[self] in
                    mPopularCars.onNext(gsonResponse.makeList)
                    mPopularCars.onCompleted()
                }
            }catch let jsonErr {
                print ("OOps not good JSON formatted response:", jsonErr)
            }
            
        })
        task.resume()
    }
}
