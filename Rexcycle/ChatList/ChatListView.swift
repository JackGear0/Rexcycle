//
//  ChatListView.swift
//  Rexcycle
//
//  Created by Pedro Catunda on 24/11/24.
//


import SwiftUI

struct Chat: Identifiable {
    let id = UUID()
    let title: String
    let date: String
}

struct ChatListView: View {
    let chats: [Chat] = [
        Chat(title: "Dúvidas sobre emissão de carbono", date: "23/09/2024 - 19:00"),
        Chat(title: "Cálculo da emissão de carbono", date: "21/09/2024 - 19:00"),
        Chat(title: "Dúvidas sobre emissão de carbono", date: "19/09/2024 - 19:00"),
        Chat(title: "Energias sustentáveis", date: "17/09/2024 - 19:00")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                List(chats) { chat in
                    HStack {
                        Image(systemName: "message.fill")
                            .foregroundColor(.green)
                        VStack(alignment: .leading) {
                            Text(chat.title)
                                .font(.headline)
                            Text(chat.date)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Chat List")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // Ação ao clicar no botão de adicionar
                        }) {
                            Image(systemName: "plus.bubble")
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
            .background(.babyGreen)
        }
    }
}

#Preview {
    ChatListView()
}
