//
//  Material.swift
//  Rexcycle
//
//  Created by Leo Leo on 23/11/24.
//

import SwiftUI

struct AddMaterial: View {
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
                Picker("Material",
                       selection: $auxMaterial) {
                    ForEach(materialList,
                            id: \.self) {
                        Text($0)
                    }
                }
                       .listRowSeparator(.hidden)
                Picker("Objeto",
                       selection: $auxObject) {
                    ForEach(objectList,
                            id: \.self) {
                        Text($0)
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
        }
        .navigationTitle("Cadastrar Coleta")
    }
}


#Preview {
    AddMaterial()
}
