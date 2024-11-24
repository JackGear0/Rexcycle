//
//  ChatModel.swift
//  expologHackGeminiPOC
//
//  Created by Yago Souza Ramos on 11/23/24.
//
import Foundation

struct ChatModel: Hashable, Codable {
    var messages: [ChatMessage]
    var context: String
}

struct ChatMessage: Hashable, Codable {
    var text: String
    let sender: String
    let timestamp: Date
}
