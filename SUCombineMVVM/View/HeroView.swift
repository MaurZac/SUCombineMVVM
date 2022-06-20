//
//  HeroView.swift
//  SUCombineMVVM
//
//  Created by Mauricio Zarate on 17/06/22.
//

import SwiftUI
import Combine



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
                            Text(data.name)
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
        HStack{
            
        }
    }
}
