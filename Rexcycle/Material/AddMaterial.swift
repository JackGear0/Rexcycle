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
    
    @State private var auxMaterial: String = ""
    @State private var auxObject: String = ""
    
    private let materialList = [ //This is the List of values we'll use
        "Garrafa um",
        "Garrafa dois",
        "Garrafa tres"
    ]
    
    private let objectList = [ //This is the List of values we'll use
        "Vidro 1",
        "Vidro 2",
        "Vidro 3"
    ]
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
                HStack{
                    Image(systemName: "dollarsign.circle.fill")
                        .foregroundColor(.lightBrown)
                    Text("+130 cred.")
                        .font(.body)
                        .foregroundColor(.lightBrown)
                }
                .padding(.horizontal)
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.white)
                    Text("Adicionar Item")
                        .foregroundColor(.white)
                }
                .padding(.leading)
                .padding()
                .bold()
                .foregroundStyle(.red)
                .background {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundStyle(.darkGreen)
                        .padding(.vertical, 5)
                }
            }
            .overlay {
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke(.lightBrown, lineWidth: 2)
                    .padding(.vertical, 5)
            }
            HStack(spacing: 20) {
                ForEach(0..<10) { _ in
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 21.26, height: 21.26)
                        .foregroundColor(.babyGreen)
                        .padding(.vertical)
                        
                }
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
