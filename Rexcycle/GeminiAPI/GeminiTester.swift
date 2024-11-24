//
//  GeminiTester.swift
//  expologHackGeminiPOC
//
//  Created by Yago Souza Ramos on 11/23/24.
//

import SwiftUI
import GoogleGenerativeAI
struct GeminiTester: View {
    @State private var prompt: String = ""
    @State private var response: String = ""

    var body: some View {
        TextField("Prompt", text: $prompt)
        Button("Generate") {
            Task {
                await response = generateSimpleResponse(prompt: prompt)
            }
        }
        Text("\(response)")
    }
}

#Preview {
    GeminiTester()
}
