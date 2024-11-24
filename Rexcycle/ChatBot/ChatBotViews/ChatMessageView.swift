//
//  ChatMessageView.swift
//  expologHackGeminiPOC
//
//  Created by Yago Souza Ramos on 11/23/24.
//

import SwiftUI

struct ChatMessageView: View {
    @State private var messageImage: String = ""
    @State var message: ChatMessage
    @State private var color = Color.blue
    @State private var orientation = LayoutDirection.rightToLeft
    @State private var alignment: HorizontalAlignment = .center
    @State private var textAlignment: TextAlignment = .leading
    @Binding var isLoading: Bool
    let isFromUser: Bool
    var body: some View {
        Group {
            ZStack {
                VStack(alignment: alignment) {
                    HStack {
                        Image(systemName: isFromUser ? "person.crop.circle.fill" : "person.crop.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        Spacer()
                    }
                    HStack {
                        HStack {
                            Text("\(message.text)")
                                .multilineTextAlignment(.trailing)
                                .lineLimit(nil)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                        }
                        .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
                        .background {
                            UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 20, bottomTrailingRadius: 20,topTrailingRadius: 20)
                                .foregroundColor(color)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 120))
                        Spacer()
                    }
                    
                }.environment(\.layoutDirection, orientation)
            }
        }
        .onAppear {
            if isFromUser {
                color = .green.opacity(0.8)
                orientation = .rightToLeft
                alignment = .leading
            } else {
                color = .black .opacity(0.5)
                orientation = .leftToRight
                alignment = .trailing
            }
        }
        .frame(maxHeight: 200)
    }
}
    
#Preview {
    ChatMessageView(message: .init(text: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!", sender: "i"), isLoading: .constant(false), isFromUser: true)
    ChatMessageView(message: .init(text: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!", sender: "i"), isLoading: .constant(false), isFromUser: false)
}
