//
//  ViewModel.swift
//  Expolog_hackathon
//
//  Created by Layza Maria Rodrigues Carneiro on 23/11/24.
//

import Foundation
import SwiftUI

class MaterialViewModel: ObservableObject {
    @Published var selectedObject: String = "Garrafa"
    @Published var selectedMaterial: String = ""
    @Published var selectedQuantity: Double = 0
    @Published var co2Emitted: String = "0"
    @Published var credits: Double = 0
    @Published var resultMessage: String = ""

    let materialIDs: [String: [String: String]] = [
        "Garrafa": [
            "Vidro": "ba7fdbab-582b-41ab-9541-f9edde7f3341",
            "Plástico": "aafd5e42-1125-4789-b3c0-10fd287d30df",
            "Metal": "98436949-4dfb-41f9-a1da-76746bb0e5ea"
        ],
        "Embalagem": [
            "Papelão": "5b9483e6-037c-4f2b-9de7-20c18f66461c",
            "Plástico": "0bd13fed-71c9-4f1c-a655-f3c767f95415"
        ],
        "Sacola": [
            "Plástico": "070909a1-d031-4cd4-8465-2406eb8fa273"
        ],
        "Latinha": [
            "Metal": "98436949-4dfb-41f9-a1da-76746bb0e5ea"
        ],
        "Papel": [
            "Papel": "afa65c77-c405-4216-8df8-027ed59edb8c"
        ]
    ]

    func calculateCarbonFootprint() {
        guard let materialID = materialIDs[selectedObject]?[selectedMaterial] else {
            DispatchQueue.main.async {
                self.resultMessage = "Material não encontrado para o objeto selecionado."
            }
            return
        }
        
        let urlString = "https://api.climatiq.io/estimate"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.resultMessage = "URL inválida"
            }
            return
        }

        let bodyData = """
        {
            "emission_factor": {
                "id": "\(materialID)"
            },
            "parameters": {
                "money": 100,
                "money_unit": "brl"
            }
        }
        """
        .data(using: .utf8)!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer 4SAC6RVEP57Y39JBZ6SXBMH1F0", forHTTPHeaderField: "Authorization")
        request.httpBody = bodyData

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.resultMessage = "Erro: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.resultMessage = "Nenhum dado recebido"
                }
                return
            }

            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                    print(jsonObject)
                    if let co2e = jsonObject["co2e"] as? Double {
                        DispatchQueue.main.async {
                            print(co2e)
                            self.co2Emitted = String(co2e * self.selectedQuantity)
                            self.credits = self.convertToCredits(co2e * self.selectedQuantity)
                            self.resultMessage = "CO2: \(self.co2Emitted) kg = \(self.credits) créditos"
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.resultMessage = "Resposta inválida"
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.resultMessage = "Formato de resposta inválido"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.resultMessage = "Erro ao processar a resposta"
                }
            }

        }
        .resume()
    }

    private func convertToCredits(_ co2Emitted: Double) -> Double {
        return co2Emitted * 0.001
    }
}
