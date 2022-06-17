//
//  CarsWebClient.swift
//  HechioAutochek
//
//  Created by Steve Hechio on 17/06/2022.
//

import Foundation
import RxCocoa
import RxSwift

class CarsWebClient {
    private var REQUEST_ENDPOINT = "\(Constants.API_HOST)car/search"
    private var MEDIA_REQUEST_ENDPOINT = "\(Constants.API_HOST)car_media"
    
    let mCarsList = PublishSubject<CarsModelResponse>()
    let mCarDetails = PublishSubject<[CarDetail]>()
    let mCarMedia = PublishSubject<[CarMediaList]>()
    
    func getCarLists(currentPage: Int){
        REQUEST_ENDPOINT = "\(REQUEST_ENDPOINT)?page_number=\(currentPage)"
        let url = URL(string: REQUEST_ENDPOINT)!
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else {return}
            
            guard let data = data else {return}
           
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                print ("car data = \(jsonResponse)")
                let gsonResponse = try JSONDecoder().decode(CarsModelResponse.self, from: data)
                DispatchQueue.main.async {[self] in
                    mCarsList.onNext(gsonResponse)
                    mCarsList.onCompleted()
                }
            }catch let jsonErr {
                print ("OOps not good JSON formatted response:", jsonErr)
            }
            
        })
        task.resume()
    }
    
    func getCarListsObserver(currentPage: Int) -> Observable<CarsModelResponse>{
        
        print("cars endpoint\("\(REQUEST_ENDPOINT)?page_number=\(currentPage)")")
        return Observable.create { observer -> Disposable in
            let task = self.getCars(from: "\(self.REQUEST_ENDPOINT)?page_number=\(currentPage)") { result in
                switch result {
                case .success(let cars):
                    print(cars)
                    observer.onNext(cars)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create{
                task.cancel()
            }
        }
           
            
    }
    func getCars(from url: String, completion: @escaping ((Result<CarsModelResponse, Error>) -> Void)) -> URLSessionDataTask {
           let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
               if let error = error {
                   completion(.failure(error)); return
               }
               guard let data = data else {
                   let error = NSError(domain: "dataNilError", code: -10001, userInfo: nil)
                   completion(.failure(error)); return
               }
               do {
                   let cars = try JSONDecoder().decode(CarsModelResponse.self, from: data)
                   completion(.success(cars))
               } catch {
                   completion(.failure(error))
               }
           }
           task.resume()
           return task
       }

    func getCarMedia(carId: String){
        MEDIA_REQUEST_ENDPOINT = "\(MEDIA_REQUEST_ENDPOINT)?carId=\(carId)"
        let url = URL(string: MEDIA_REQUEST_ENDPOINT)!
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else {return}
            
            guard let data = data else {return}
           
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                print ("car details data = \(jsonResponse)")
                let gsonResponse = try JSONDecoder().decode(CarMediaResponse.self, from: data)
                DispatchQueue.main.async {[self] in
                    mCarMedia.onNext(gsonResponse.carMediaList)
                    mCarMedia.onCompleted()
                }
            }catch let jsonErr {
                print ("OOps not good JSON formatted response:", jsonErr)
            }
            
        })
        task.resume()
    }
    
    func getListOfDetails(car: CarsListResult){
        var detailsList = [CarDetail]()
        for(key, value) in car.dictionary {
            detailsList.append(CarDetail(field: key, value: value ?? "Not Specified"))
        }
        print(detailsList)
        mCarDetails.onNext(detailsList)
        mCarDetails.onCompleted()
    }
}
