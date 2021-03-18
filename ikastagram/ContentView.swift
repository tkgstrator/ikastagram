//
//  ContentView.swift
//  ikastagram
//
//  Created by Devonly on 3/17/21.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct ContentView: View {
    
    @AppStorage("oauthToken") var oauthToken: String = ""
    @AppStorage("oauthTokenSecret") var oauthTokenSecret: String = ""
    
    var body: some View {
        NavigationView {
            ChatView()
            .navigationTitle("TITLE_IKASTAGRAM")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
