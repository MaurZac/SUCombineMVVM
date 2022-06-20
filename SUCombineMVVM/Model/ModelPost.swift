//
//  ModelPost.swift
//  SUCombineMVVM
//
//  Created by Mauricio Zarate on 13/06/22.
//

import Foundation

// MARK: - Marvel
//struct Marvel: Codable, Identifiable {
//    var id: Int
//    let code: Int
//    let status, copyright, attributionText, attributionHTML: String
//    let etag: String
//    let data: DataClass
//}
//
//// MARK: - DataClass
//struct DataClass: Codable {
//    let offset, limit, total, count: Int
//    let results: [Result]
//}

// MARK: - Result
struct ApiResult: Codable {
    var data: ApiHeroData
}

struct ApiHeroData: Codable {
    var count: Int
    var results: [Heroes]
}

struct Heroes: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: [String: String]
    var urls: [[String: String]]
}


//struct Result: Codable,Identifiable {
//    let id: Int
//    let name, resultDescription: String
//    let modified: Date
//    let thumbnail: Thumbnail
//    let resourceURI: String
//    let comics, series: Comics
//    let stories: Stories
//    let events: Comics
//    let urls: [URLElement]
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case resultDescription = "description"
//        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
//    }
//}
//
//// MARK: - Comics
//struct Comics: Codable {
//    let available: Int
//    let collectionURI: String
//    let items: [ComicsItem]
//    let returned: Int
//}
//
//// MARK: - ComicsItem
//struct ComicsItem: Codable {
//    let resourceURI: String
//    let name: String
//}
//
//// MARK: - Stories
//struct Stories: Codable {
//    let available: Int
//    let collectionURI: String
//    let items: [StoriesItem]
//    let returned: Int
//}
//
//// MARK: - StoriesItem
//struct StoriesItem: Codable {
//    let resourceURI: String
//    let name: String
//    let type: ItemType
//}
//
//enum ItemType: String, Codable {
//    case cover = "cover"
//    case empty = ""
//    case interiorStory = "interiorStory"
//}
//
//// MARK: - Thumbnail
//struct Thumbnail: Codable {
//    let path: String
//    let thumbnailExtension: Extension
//
//    enum CodingKeys: String, CodingKey {
//        case path
//        case thumbnailExtension = "extension"
//    }
//}
//
//enum Extension: String, Codable {
//    case gif = "gif"
//    case jpg = "jpg"
//}
//
//// MARK: - URLElement
//struct URLElement: Codable {
//    let type: URLType
//    let url: String
//}
//
//enum URLType: String, Codable {
//    case comiclink = "comiclink"
//    case detail = "detail"
//    case wiki = "wiki"
//}
