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
    @State var items: [MaterialID] = []
    @State var totalWeight: Int = 0
    
    @State private var showConfirmationPopup = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("1. Escolha a categoria")
                        .font(.title2)
                        .bold()
                    
                    HStack {
                        Text("Material")
                            .font(.title3)
                            .foregroundStyle(.accent)
                        
                        Spacer()
                
                        Picker("Material", selection: $viewModel.selectedMaterial) {
                            ForEach(viewModel.materialIDs.keys.sorted(), id: \.self) { material in
                                Text(material).tag(material)
                                    .font(.title2)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .tint(.darkGreen)
                        .onAppear {
                            if viewModel.selectedMaterial.isEmpty, let firstMaterial = viewModel.materialIDs.keys.first {
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
                                if viewModel.selectedQuantity > 1.0 {
                                    viewModel.selectedQuantity -= 1.0
                                }
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
                            addItem()
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
                                Text("+")
                                    .fontWeight(.bold)
                                    .font(.body)
                                Text(String(format: "%.2f", viewModel.credits))
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
                        .padding(.vertical, 5)
                    
                    VStack(alignment: .leading, spacing: 8) {
                       
                    }
                    .padding(.bottom, 10)
                    
                    ForEach($items) { $index in
                        HStack {
                            Text(index.material)
                                .padding(.trailing, 10)
                            Text("\(index.weight, specifier: "%.0f") kg")
                                .foregroundStyle(.black)
                            
                            Spacer()
//                            Text()
                        }
                    }
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color.darkGreen)
                        .padding(.top, 30)
                    
                    HStack {
                        Text("\(items.count) Item")
                            .foregroundStyle(.darkGreen)
                        Text("\(totalWeight) Kg")
                            .foregroundStyle(.darkGreen)
                        
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("\(viewModel.credits)")
                            Text("créditos")
                        }
                        .foregroundStyle(.lightBrown)
                    }
                    .fontWeight(.semibold)
                    
                    Button {
                        Task {
                            do {
                                try await API.updateCredits(credits: viewModel.credits)
                                showConfirmationPopup = true
                                print("Créditos atualizados com sucesso!")
                            } catch {
                                print("Erro ao atualizar créditos: \(error)")
                            }
                        }
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
        .alert("Créditos resgatados com sucesso!", isPresented: $showConfirmationPopup) {
            Button("OK") {
                dismiss()
            }
        }
    }
    
    func addItem() {
        let new = MaterialID(material: viewModel.selectedMaterial, weight: viewModel.selectedQuantity)
        items.append(new)
        totalWeight += Int(viewModel.selectedQuantity)
        viewModel.calculateCarbonFootprint()
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
