//
//  GeminiTest.swift
//  expologHackGeminiPOC
//
//  Created by Yago Souza Ramos on 11/23/24.
//

import SwiftUI
import GoogleGenerativeAI
func generateSimpleResponse(prompt: String) async -> String {
    @State var apiKey: String = APIKey.default
    do {
        let model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: apiKey)
        
        print(prompt)
        let response = try await model.generateContent(prompt)
        if let text = response.text {
            
            return text
        } else {
            
            return "Não conchegue" //Retornar o erro
        }
    } catch {
        print("Erro ao gerar conteúdo: \(error)")
        return "IA sobrecarregada, tente novamente mais tarde"
    }
}

func generateChatResponse(prompt: String, history: ChatModel) async -> String {
    @State var apiKey: String = APIKey.default
    do {
        let model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: apiKey)
        print(prompt)
        let jsonData = try JSONEncoder().encode(history)
        let historyString = String(data: jsonData, encoding: .utf8)!
        print(historyString)
        let contexto = "Você está em um chat, não prolongue suas mensagens, o contexto da sua conversa é: \n \(historyString) \n. Baseado nessas, responda a essa pergunta: \(prompt)"
        let response = try await model.generateContent("\(contexto)")
        if let text = response.text {
            return text
        } else {
            return "Não conchegue" //Retornar o erro
        }
    } catch {
        print("Erro ao gerar conteúdo: \(error)")
        return "IA sobrecarregada, tente novamente mais tarde"
    }
}
