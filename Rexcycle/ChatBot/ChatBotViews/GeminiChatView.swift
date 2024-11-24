//
//  GeminiChatView.swift
//  expologHackGeminiPOC
//
//  Created by Yago Souza Ramos on 11/23/24.
//

import SwiftUI

struct GeminiChatView: View {
    @Binding  var chatModel: ChatModel
    @State private var currentMessage: String = ""
    @State private var currentGeminiMessage: String = ""
    @State private var isLoading: Bool = false
    var body: some View {
        ZStack {
            Color.lightWhite
                .ignoresSafeArea()
            VStack {
                ScrollView {
                    ForEach(chatModel.messages, id: \.self) { message in
                        ChatMessageView(message: message, isLoading: $isLoading, isFromUser: message.sender == "Gemini" ? false : true)
                    }
                    .scrollTargetLayout()
                }
                .contentMargins(0, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
                .defaultScrollAnchor(.bottom)
                HStack {
                    Group {
                        ZStack {
                            RoundedRectangle(cornerRadius: 180)
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .foregroundStyle(.babyGreen)
                            HStack {
                                TextField("Pergunte ao Rexy", text: $currentMessage)
                                    .foregroundStyle(.darkGreen)
                                    .padding(.horizontal)
                                Button {
                                    Task {
                                        chatModel.messages.append(ChatMessage(text: currentMessage, sender: "User", timestamp: .now))
                                        isLoading = true
                                        currentGeminiMessage = "..."
                                        chatModel.messages.append(ChatMessage(text: currentGeminiMessage, sender: "Gemini", timestamp: .now))
                                        var response: String = ""
                                        await response = generateChatResponse(prompt: currentMessage, history: chatModel)
                                        
                                        if response.last == "\n" {
                                            response.removeLast()
                                        }
                                        currentMessage = ""
                                        let textAndContext = response.components(separatedBy: "|")
                                        
                                        chatModel.context = textAndContext.last ?? ""
                                        isLoading = false
                                        chatModel.messages.removeLast()
                                        chatModel.messages.append(ChatMessage(text: textAndContext.first ?? "", sender: "Gemini", timestamp: .now))
                                    }
                                    
                                } label: {
                                    ZStack {
                                        Color.darkGreen.clipShape(.circle)
                                            .frame(width: 40, height: 40)
                                            .padding()
                                        Image("RexyPawWhite")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                    }
                                    
                                }
                            }
                        }
                    }
                    .padding(.vertical, 30)
                }
                .disabled(isLoading)
                
            }.padding(.horizontal)
        }
    }
}

//
//#Preview {
//    GeminiChatView(chatModel: ChatModel(messages: [], context: ""))
//}
