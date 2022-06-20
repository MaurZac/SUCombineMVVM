//
//  ListViewModel.swift
//  SUCombineMVVM
//
//  Created by Mauricio Zarate on 13/06/22.
//

import Foundation
import SwiftUI
import Combine

class ListViewModel: ObservableObject {
    
    init() {
        ObtainData()
    }
    
    @Published var story = [Heroes] () {
        didSet {
            didChange.send(self)
        }
    }
    let didChange = PassthroughSubject<ListViewModel, Never>()
    
    func ObtainData(){
        NetworkManager().getData {
            self.story = $0
        }
    }
}
