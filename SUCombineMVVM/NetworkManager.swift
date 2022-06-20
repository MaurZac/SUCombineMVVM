//
//  NetworkManager.swift
//  SUCombineMVVM
//
//  Created by Mauricio Zarate on 11/06/22.
//

import Foundation

class NetworkManager {
    func getData(results: @escaping([Heroes]) -> ()){
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/characters?ts=1&apikey=b3b79de52c419f57f37617227ab3aa6b&hash=332269d91dc1592db05da096f3d282fe")  else {
            fatalError("URL Incorrect or not available")
        }
        URLSession.shared.dataTask(with: url){ datas, responses, error in
        guard let data = datas, error == nil, let response = responses as? HTTPURLResponse else {
            return
          }
            if response.statusCode == 200 {
                do {
                    let res = try JSONDecoder().decode([Heroes].self, from: data)
                    results(res)
                }catch let error {
                    print("error: \(error.localizedDescription)")
                }
            }else{
                print("nodata")
            }
        }.resume()
   }
}
