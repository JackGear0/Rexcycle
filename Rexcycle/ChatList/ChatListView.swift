//
//  ChatListView.swift
//  Rexcycle
//
//  Created by Pedro Catunda on 24/11/24.
//


import SwiftUI

struct Chat: Identifiable {
    let id = UUID()
    var chatModel: ChatModel
}

var chatStartString: String = """
Olá, eu sou o Rexy, seu assistente de redução de gasto de carbono inteligente, estou aqui para te ajudar a reduzir o seu gasto de carbono e salvar o planeta grama a grama
"""
var chatPreview: ChatMessage = ChatMessage(text: chatStartString, sender: "Gemini", timestamp: .now)

struct ChatListView: View {
    @State var chats: [Chat] = [Chat(chatModel: ChatModel(messages: [chatPreview], context: "Pergunte Ao Rexinho"))]
    @State var selectedChat: Chat? = nil
    var body: some View {
        NavigationStack {
            VStack {
                List($chats) { $chat in
                    NavigationLink {
                        GeminiChatView(chatModel: $chat.chatModel)
                    } label: {
                        HStack {
                            Image(systemName: "message.fill")
                                .foregroundColor(.green)
                            VStack(alignment: .leading) {
                                Text(chat.chatModel.context == "" ? chatStartString : chat.chatModel.context)
                                    .font(.headline)
                                Text("\(chat.chatModel.messages.last?.timestamp == nil ? "Agora" : chat.chatModel.messages.last?.timestamp.formatted(.dateTime) ?? "Erro ao Adquirir Tempo")")
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    
                        
                    }
                .navigationTitle("Chat List")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            
                            // Ação ao clicar no botão de adicionar
                        } label: {
                            Button {
                                let newChat = Chat(chatModel: ChatModel(messages: [ChatMessage(text: "Rexy", sender: "Gemini", timestamp: .now)], context: chatStartString))
                                chats.append(newChat)
                            } label: {
                                Image(systemName: "plus.bubble")
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                }
            }
            .background(.babyGreen)
        }
    }
}

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy - HH:mm" // Specify the desired format
    return formatter.string(from: date)
}

#Preview {
    ChatListView()
}
