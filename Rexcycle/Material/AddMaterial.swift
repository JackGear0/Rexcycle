//
//  Material.swift
//  Rexcycle
//
//  Created by Leo Leo on 23/11/24.
//

import SwiftUI

struct AddMaterial: View {
    @StateObject private var viewModel = MaterialViewModel()
    @State private var selectedUnit: String = "kg"
    
    var body: some View {
        VStack{
            Text("1.Escolha a categoria")
                .bold()
                .font(.system(size: 25))
                .padding()
                .foregroundColor(.darkGreen)
            List {
                Picker("Objeto", selection: $viewModel.selectedObject) {
                    Text("Garrafa").tag("Garrafa")
                    Text("Embalagem").tag("Embalagem")
                    Text("Sacola").tag("Sacola")
                    Text("Latinha").tag("Latinha")
                    Text("Papel").tag("Papel")
                }
                .pickerStyle(MenuPickerStyle())
                .listRowSeparator(.hidden)
                .tint(.darkGreen)
                
                Picker("Material", selection: $viewModel.selectedMaterial) {
                    ForEach(materialOptions(for: viewModel.selectedObject), id: \.self) { material in
                        Text(material).tag(material)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .tint(.darkGreen)
                .onAppear {
                    if let firstMaterial = materialOptions(for: viewModel.selectedObject).first {
                        viewModel.selectedMaterial = firstMaterial
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .frame(height: 150)
            Image(.card2)
            
            Text("2.Insira a quantidade")
                .bold()
                .font(.system(size: 25))
                .padding()
                .foregroundColor(.darkGreen)
            
            HStack {
                Text("Quantidade (kg):")
                    .font(.headline)
                
                Picker("Quantidade", selection: $viewModel.selectedQuantity) {
                    ForEach(0..<101, id: \.self) { value in
                        Text("\(Double(value), specifier: "%.0f")").tag(Double(value))
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .tint(.darkGreen)
                .frame(width: 100)
            }
            .padding()
        }
        .navigationTitle("Cadastrar Coleta")
    }
    
    func materialOptions(for object: String) -> [String] {
        switch object {
        case "Garrafa":
            return ["Vidro", "Plástico", "Metal"]
        case "Embalagem":
            return ["Papelão", "Plástico"]
        case "Sacola":
            return ["Plástico"]
        case "Latinha":
            return ["Metal"]
        case "Papel":
            return ["Papel"]
        default:
            return []
        }
    }
}


#Preview {
    AddMaterial()
}
