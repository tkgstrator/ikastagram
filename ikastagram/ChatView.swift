//
//  ChatView.swift
//  ikastagram
//
//  Created by Devonly on 3/18/21.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var main: MessageViewModel
    @State var message: String = ""
    @AppStorage("uid") var uid: String = ""
    @AppStorage("name") var name: String = ""
    private let dateFormatter = ISO8601DateFormatter()
    
    init() {
        dateFormatter.timeZone = TimeZone.current
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(main.messages) { message in
                    VStack(alignment: .leading, spacing: 5) {
                        if uid == message.uid {
                            HStack {
                                Text(message.uid)
                                    .foregroundColor(.blue)
                                Text(dateFormatter.string(from: message.date))
                            }
                            .font(.system(size: 11, design: .monospaced))
                        } else {
                            HStack {
                                Text(message.uid)
                                    .foregroundColor(.secondary)
                                Text(dateFormatter.string(from: message.date))
                            }
                            .font(.system(size: 11, design: .monospaced))
                        }
                        Text(message.message)
                    }
                }
            }
            TextField("Message", text: $message, onCommit: {
                if !message.isEmpty {
                    main.send(message: message, user: name, uid: uid)
                }
                message = ""
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
