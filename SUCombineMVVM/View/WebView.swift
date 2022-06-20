//
//  WebView.swift
//  SUCombineMVVM
//
//  Created by Mauricio Zarate on 19/06/22.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var url: URL
    
    func makeUIView(context: Context) -> some UIView {
        let view = WKWebView()
        view.load(URLRequest(url: url))
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("working")
    }
   
}
