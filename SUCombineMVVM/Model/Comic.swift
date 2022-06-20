//
//  Comic.swift
//  SUCombineMVVM
//
//  Created by Mauricio Zarate on 20/06/22.
//

import Foundation

struct ApiComicResult: Codable {
    var data: ApiComicHeroData
}

struct ApiComicHeroData: Codable {
    var count: Int
    var results: [Comic]
}

struct Comic: Identifiable, Codable {
    var id: Int
    var title: String
    var description: String?
    var thumbnail: [String: String]
    var urls: [[String: String]]
}

