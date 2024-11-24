//
//  View.swift
//  Expolog_hackathon
//
//  Created by Layza Maria Rodrigues Carneiro on 23/11/24.
//

import SwiftUI

struct MaterialView: View {
    @StateObject private var viewModel = MaterialViewModel()
    @State private var selectedUnit: String = "kg"

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Quantidade (kg):")
                    .font(.headline)
                
                Picker("Quantidade", selection: $viewModel.selectedQuantity) {
                    ForEach(0..<101, id: \.self) { value in
                        Text("\(Double(value), specifier: "%.1f")").tag(Double(value))  // Quantidade em kg
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 100)

                Text("kg")
                    .font(.headline)
                    .frame(width: 40)
            }
            .padding()

            Button("Calcular Pegada de Carbono") {
                viewModel.calculateCarbonFootprint()
            }
            .padding()

            Text(viewModel.resultMessage)
                .padding()
        }
        .padding()
    }
}
