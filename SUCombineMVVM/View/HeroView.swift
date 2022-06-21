//
//  HeroView.swift
//  SUCombineMVVM
//
//  Created by Mauricio Zarate on 17/06/22.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI


struct HeroView: View {
    @EnvironmentObject var homeData: HerosHomeViewModel
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 15){
                    HStack(spacing: 10){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search Hero", text: $homeData.searching)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                }
                .padding()
                if let heroes = homeData.fetchHero{
                    if heroes.isEmpty {
                        Text("No Results")
                            .padding(.top,20)
                    }else{
                        ForEach(heroes){ data in
                            HeroRowView(hero: data)
                        }
                    }
                }else {
                    if homeData.searching != ""{
                        ProgressView()
                            .padding(.top,20)
                    }
                    
                }
            })
                .navigationTitle("Marvel's Hero")
            
        }
    }
}

struct HeroView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HeroRowView: View {
    var hero: Heroes
    var body: some View{
        HStack(alignment: .top, spacing: 15){
            WebImage(url: extractImage(data: hero.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text(hero.name)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(hero.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: 10){
                    ForEach(hero.urls,id: \.self){ data in
                        NavigationLink(
                            destination: WebView(url: extractURL(data: data))
                                .navigationTitle(extractURLType(data: data)),
                                       label: {
                                           Text(extractURLType(data: data))
                            })
                    }
                }
            })
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
        
    }
    
    func extractImage(data: [String: String]) -> URL {
        let path = data["path"] ?? ""
        let ext  = data["extension"] ?? ""
        return URL(string: "\(path).\(ext)")!
    }
    
    func extractURL(data: [String: String]) -> URL{
        let url = data["url"] ?? ""
        return URL(string: url)!
    }
    func extractURLType(data: [String: String]) -> String {
        let type = data["type"] ?? ""
        return type.capitalized
    }
}
