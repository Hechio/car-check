//
//  CarsModel.swift
//  HechioAutochek
//
//  Created by Steve Hechio on 17/06/2022.
//

import Foundation

struct CarsModelResponse: Codable {
    var result: [CarsListResult]?
    var pagination: Pagination?
}

struct CarsListResult: Codable {
    var id, title: String?
    var imageUrl: String?
    var year: Int?
    var city, state: String?
    var gradeScore: Double?
    var sellingCondition: String?
    var hasWarranty: Bool?
    var marketplacePrice, marketplaceOldPrice: CLong?
    var hasFinancing: Bool?
    var mileage: Int?
    var mileageUnit: String?
    var installment: Double?
    var depositReceived: Bool?
    var loanValue: Double?
    var websiteUrl: String?
    var bodyTypeId: String?
    var sold, hasThreeDImage: Bool?
    var fuelType: String?
    
    var dictionary: [String: Any?] {
        return["Year" : year,
               "Location": "\(city ?? ""),\(state ?? "")",
               "Has Warranty": setBool(value: hasWarranty ?? false),
               "Mileage": "\(mileage ?? 0) \(mileageUnit ?? "km")",
               "Installment": installment,
               "Has Financing": setBool(value: hasFinancing ?? false),
               "Deposit Received": depositReceived,
               "Loan Value": loanValue,
               "Body Type ID": bodyTypeId,
               "Sold": "",
        ]
    }

    func setBool(value: Bool) -> String{
        if (value){ return "Yes" } else { return "No"}
    }
}

struct CarDetail{
    var field: String
    var value: Any
}

struct CarMediaResponse: Codable{
    let carMediaList: [CarMediaList]
    let pagination: Pagination
}

struct CarMediaList: Codable{
    let id: Int
    let name: String
    let url: String
    let type: String
    
    func isImage(type: String) -> Bool{
        switch type {
        case MediaType.image.rawValue:
            return true
        case MediaType.video.rawValue:
            return false
        default:
            return false
        }
    }
}
enum MediaType: String {
    case image = "image/jpg"
    case video = "video/mp4"
}
