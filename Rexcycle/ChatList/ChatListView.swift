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

struct ChatListView: View {
    @State var chats: [Chat] = [Chat(chatModel: ChatModel(messages: [], context: ""))]
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
                                Text(chat.chatModel.context)
                                    .font(.headline)
                                Text("")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
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
                                let newChat = Chat(chatModel: ChatModel(messages: [], context: ""))
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
