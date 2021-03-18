//
//  ChatView.swift
//  ikastagram
//
//  Created by Devonly on 3/18/21.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var main: MessageViewModel
    
    var body: some View {
        List {
            ForEach(main.messages) { message in
                HStack {
                    Text(message.message)
                    Spacer()
                }
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
