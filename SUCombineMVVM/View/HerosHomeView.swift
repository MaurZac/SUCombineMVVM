//
//  HerosHomeView.swift
//  SUCombineMVVM
//
//  Created by Mauricio Zarate on 17/06/22.
//

import SwiftUI

struct HerosHomeView: View {
    //@ObservedObject var model = ListViewModel()
    @StateObject var homeData = HerosHomeViewModel()
    
    var body: some View {
        TabView{
            HeroView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Heros")
                }
                .environmentObject(homeData)
            Text("Comics")
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Comics")
                }
        }
    }
}

struct HerosHomeView_Previews: PreviewProvider {
    static var previews: some View {
        HerosHomeView()
    }
}
