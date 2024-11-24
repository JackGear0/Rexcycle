//
//  GeminiChatView.swift
//  expologHackGeminiPOC
//
//  Created by Yago Souza Ramos on 11/23/24.
//

import SwiftUI

struct GeminiChatView: View {
    @State private var chatModel: ChatModel = ChatModel(messages: [], context: "")
    @State private var currentMessage: String = ""
    @State private var currentGeminiMessage: String = ""
    @State private var isLoading: Bool = false
    var body: some View {
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
                TextField("Digite", text: $currentMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button {
                    Task {
                        chatModel.messages.append(ChatMessage(text: currentMessage, sender: "User"))
                        isLoading = true
                        currentGeminiMessage = "..."
                        chatModel.messages.append(ChatMessage(text: currentGeminiMessage, sender: "Gemini"))
                        var response: String = ""
                        await response = generateChatResponse(prompt: currentMessage, history: chatModel)
                        
                        response = response.replacingOccurrences(of: "\n", with: "")
                        isLoading = false
                        chatModel.messages.removeLast()
                        chatModel.messages.append(ChatMessage(text: response, sender: "Gemini"))
                    }
                    
                } label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 30)
        }
        .disabled(isLoading)
    }
}


#Preview {
    GeminiChatView()
}
