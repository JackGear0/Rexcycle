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
        "um",
        "dois",
        "tres"
    ]
    
    private let objectList = [ //This is the List of values we'll use
        "1",
        "2",
        "3"
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
        }
        .navigationTitle("Cadastrar Coleta")
    }
}


#Preview {
    AddMaterial()
}
