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
        ZStack {
            VStack(alignment: .leading) {
                Text("1. Escolha a categoria")
                    .font(.title2)
                    .bold()
                
                HStack {
                    Text("Material")
                        .font(.title3)
                        .foregroundStyle(.accent)
                    
                    Spacer()
                    
                    Picker("Material", selection: $viewModel.selectedMaterial) {
                        ForEach(materialOptions(for: viewModel.selectedObject), id: \.self) { material in
                            Text(material).tag(material)
                                .font(.title2)
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
                
                Text("2. Insira a quantidade")
                    .font(.title2)
                    .bold()
                
                HStack {
                    Button {
                        viewModel.selectedQuantity += 1.0
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.babyGreen)
                                .frame(width: 24, height: 24)
                            Image(systemName: "plus")
                        }
                    }
                    
                    Text("\(Int(viewModel.selectedQuantity))")
                        .font(.title2)
                        .foregroundStyle(.accent)
                        .frame(width: 37, height: 28)
                    
                    Button {
                        viewModel.selectedQuantity -= 1.0
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.babyGreen)
                                .frame(width: 24, height: 24)
                            Image(systemName: "minus")
                        }
                    }
                    
                    Spacer()
                    
                    Text("Kg")
                        .font(.title3)
                        .foregroundStyle(.accent)
                }
                .padding(.horizontal, 5)
                
                ZStack {
                    Button {
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 232, height: 44)
                                .foregroundStyle(.darkGreen)
                                .cornerRadius(21)
                                .padding(.trailing, 120)
                            
                            HStack {
                                ZStack {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 24, height: 24)
                                    Image(systemName: "plus")
                                        .foregroundStyle(.darkGreen)
                                }
                                Text("Adicionar Item")
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                            }
                            .padding(.trailing, 120)
                        }
                    }
                    
                    Rectangle()
                        .frame(width: 353, height: 44)
                        .foregroundStyle(.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 21)
                                .stroke(Color.lightBrown, lineWidth: 1)
                        )
                    
                    HStack {
                        Spacer()
                        Image(systemName: "dollarsign.circle.fill")
                            .foregroundColor(.lightBrown)
                        HStack(spacing: 3) {
                            Text("+\(Int(viewModel.credits))")
                                .fontWeight(.bold)
                                .font(.body)
                            Text("créd.")
                                .font(.caption)
                        }
                        .foregroundColor(.lightBrown)
                    }
                    .padding()
                }
                .padding(.top, 10)
                
                HStack(spacing: 18) {
                    ForEach(0..<10) { _ in
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 21.26, height: 21.26)
                            .foregroundColor(.babyGreen)
                            .padding(.vertical)
                        
                    }
                }
                .padding(.vertical, 10)
                
                Text("Resumo")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.darkGreen)
                    .padding(.horizontal, 144)
                    .padding(.vertical, 10)
                
                HStack {
                    // adicionados
                }
                
                Divider()
                    .frame(height: 1)
                    .background(Color.darkGreen)
                    .padding(.top, 30)
                
                HStack {
                    Text("0 Item")
                        .foregroundStyle(.darkGreen)
                    Text("0 Kg")
                        .foregroundStyle(.darkGreen)
                    
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(Int(viewModel.credits))")
                        Text("créditos")
                    }
                    .foregroundStyle(.lightBrown)
                }
                .fontWeight(.semibold)
                
                Button {
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 232, height: 44)
                            .foregroundColor(.lightBrown)
                            .cornerRadius(21)
                        
                        HStack(alignment: .center) {
                            Image(systemName: "dollarsign.circle.fill")
                                .foregroundColor(.white)
                            
                            Text("Resgatar Créditos")
                                .foregroundStyle(.white)
                                .font(.body)
                                .fontWeight(.bold)
                        }
                        
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal, 70)
                
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
