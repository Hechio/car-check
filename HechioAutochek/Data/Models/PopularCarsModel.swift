//
//  PopularCarsModel.swift
//  HechioAutochek
//
//  Created by Steve Hechio on 17/06/2022.
//

import Foundation

struct PopularCars: Codable{
    let makeList : [MakeList]
    let pagination : Pagination

    enum CodingKeys: String, CodingKey {

        case makeList = "makeList"
        case pagination = "pagination"
    }
}

struct MakeList : Codable {
    let id : Int
    let name : String
    let imageUrl : String

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case imageUrl = "imageUrl"
    }
}

struct Pagination : Codable {
    let total : Int
    let currentPage : Int
    let pageSize : Int

    enum CodingKeys: String, CodingKey {

        case total = "total"
        case currentPage = "currentPage"
        case pageSize = "pageSize"
    }
}
