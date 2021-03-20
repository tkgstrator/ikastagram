//
//  UserView.swift
//  ikastagram
//
//  Created by Devonly on 3/18/21.
//

import SwiftUI

struct UserView: View {
    @AppStorage("uid") var uid: String?
    @AppStorage("name") var name: String = ""
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    @EnvironmentObject var auth: FirebaseAuthStateObserver
    
    var body: some View {
        Form {
            HStack {
                Text("USER_ID")
                Spacer()
                Text(uid ?? "-")
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            HStack {
                Text("USER_ID")
                Spacer()
                TextField("Username", text: $name, onCommit: {})
                    .multilineTextAlignment(.trailing)
            }
            Toggle(isOn: $isFirstLaunch, label: { Text("TOGGLE_LOGIN") })
            NavigationLink(
                destination: ChatView(),
                label: {
                    Text("TITLE_IKASTAGRAM")
                })
        }
        .navigationTitle("TITLE_USER")
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
