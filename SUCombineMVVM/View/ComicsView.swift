//
//  ComicsView.swift
//  SUCombineMVVM
//
//  Created by Mauricio Zarate on 20/06/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicsView: View {
    @EnvironmentObject var homeData: HerosHomeViewModel
    var body: some View {
        NavigationView{
            ScrollView(.vertical,showsIndicators: false,
                       content: {
                if let comic = homeData.fetchedComic{
                    if comic.isEmpty {
                        ProgressView()
                            .padding(.top, 30)
                    }else{
                        VStack(spacing: 15){
                            ForEach(comic){comic in
                                ComicRowView(hero: comic)
                            }
                            if homeData.offset == homeData.fetchedComic.count{
                                ProgressView()
                                    .onAppear(perform: {
                                        print("loading new data")
                                        homeData.searchComics()
                                    })
                            }else{
                                GeometryReader{ reader -> Color in
                                    let minY = reader.frame(in: .global).minY
                                    let height = UIScreen.main.bounds.height / 1.3
                                    
                                    if !homeData.fetchedComic.isEmpty && minY < height {
                                        print("last")
                                        DispatchQueue.main.async {
                                            homeData.offset = homeData.fetchedComic.count
                                        }
                                    }
                                    return Color.clear
                                }
                                .frame(width: 20, height: 20)
                            }
                        }
                        .padding(.bottom)
                    }
                
                }
    
            })
                .navigationTitle("Comic's Section")
                .onAppear(perform: {
                    if homeData.fetchedComic.isEmpty{
                        homeData.searchComics()
                    }
                })
        }
    }
}

struct ComicsView_Previews: PreviewProvider {
    static var previews: some View {
        ComicsView()
    }
}


struct ComicRowView: View {
    var hero: Comic
    var body: some View{
        HStack(alignment: .top, spacing: 15){
            WebImage(url: extractImage(data: hero.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text(hero.title)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(hero.description ?? "")
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
