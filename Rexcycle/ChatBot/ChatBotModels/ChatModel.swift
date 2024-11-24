//
//  ChatModel.swift
//  expologHackGeminiPOC
//
//  Created by Yago Souza Ramos on 11/23/24.
//

struct ChatModel: Hashable, Codable {
    var messages: [ChatMessage]
    let context: String
}

struct ChatMessage: Hashable, Codable {
    var text: String
    let sender: String
}