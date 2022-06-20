//
//  HerosHomeViewModel.swift
//  SUCombineMVVM
//
//  Created by Mauricio Zarate on 17/06/22.
//

import Foundation
import Combine
import CryptoKit

class HerosHomeViewModel: ObservableObject {
    
    @Published var searching = ""
   
    var searchCancel: AnyCancellable? = nil
    @Published var fetchHero: [Heroes]?  = nil
    @Published var fetchedComic: [Comic]? = []
    @Published var offset: Int = 0
    
    
    init() {
        searchCancel = $searching
            .removeDuplicates()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == ""{
                    self.fetchHero = nil
                }else {
                    self.searchHero()
                    print(str)
                }
            })
    }
    
    func searchHero(){
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(priKey)\(pubKey)")
        let originalQuery = searching.replacingOccurrences(of: " ", with: "%20")
        let url  = "https://gateway.marvel.com/v1/public/characters?nameStartsWith=\(originalQuery)&ts=\(ts)&apikey=\(pubKey)&hash=\(hash)"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { datas, ress, errors in
            if let errors = errors {
                print(errors.localizedDescription)
                return
            }
            guard let apiData = datas else {
                print("no data")
                return
            }
            do{
                let heroes = try JSONDecoder().decode(ApiResult.self, from: apiData)
                DispatchQueue.main.async {
                    if self.fetchHero == nil {
                        self.fetchHero = heroes.data.results
                    }
                }
                
            }catch{
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func MD5(data: String) -> String{
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        
        return hash.map{
            String(format: "%02hhx", $0)
        }
        .joined()
    }
    
    func searchComics(){
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(priKey)\(pubKey)")
        let url  = "https://gateway.marvel.com/v1/public/comics?limit=20&offset=\(offset)&ts=\(ts)&apikey=\(pubKey)&hash=\(hash)"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { datas, ress, errors in
            
            if let errors = errors {
                print(errors.localizedDescription)
                return
            }
            
            guard let apiData = datas else {
                print("no data")
                return
            }
            
            do{
                let comics = try JSONDecoder().decode(ApiComicResult.self, from: apiData)
                DispatchQueue.main.async {
                    self.fetchedComic = comics.data.results
                    print(self.fetchedComic)
                }
                
            }catch{
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
}
