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
        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
        let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
        let jsonPrompt = String(data: prettyJsonData, encoding: .utf8)!
        let contexto = """
Você é um chat de uma app.
Seu nome: Rexy
Nome do app: Rexcycle
Função: Um gerenciador de créditos de carbono
Empresas podem criar Cupons, que são como "Missões"
Usuários podem pegar esses cupons e fazer as missões, vendendo o seu crédito para a empresa e ganhando descontos ou vouchers na empresa para isso

Você está em um chat, não prolongue suas mensagens mais do que o necessário, tente se manter a respostas curtas
Responda a pergunta: 
{
\(prompt)
}
O contexto da sua conversa é (Em formato JSon):
{
\(jsonPrompt)
}
Baseado nessas, responda a pergunta feita anteriormente: 
{
\(prompt)
}
"""
        print(contexto)
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
