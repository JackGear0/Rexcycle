//
//  VoucherRegisterView.swift
//  Rexcycle
//
//  Created by Pedro Catunda on 24/11/24.
//

import SwiftUI

struct VoucherRegisterView: View {
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var purchasedCreditText: String = "1"
    @State private var purchasedCredit: Double = 1
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Título")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.darkGreen)
                
                TextField("Ex: 10% de desconto", text: $title)
                    .padding()
                    .background(.babyGreen)
                    .cornerRadius(8)
                
                Text("Descrição")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.darkGreen)
                
                TextField("Ex: em produtos variados", text: $description)
                    .padding()
                    .background(.babyGreen)
                    .cornerRadius(8)
                
                Text("Custo (em créditos)")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.darkGreen)
                
                TextField("Ex: 1, 2, 0.05", text: $purchasedCreditText)
                    .keyboardType(.numberPad)
                    .onChange(of: purchasedCreditText) { newValue in
                        let filtered = newValue.filter { "0123456789.".contains($0) }
                        let hasMultipleDots = filtered.filter { $0 == "." }.count > 1
                        
                        if !hasMultipleDots {
                            purchasedCreditText = filtered
                        } else {
                            purchasedCreditText = String(filtered.dropLast())
                        }
                        
                        purchasedCredit = Double(purchasedCreditText) ?? 1
                    }
                    .padding()
                    .background(.babyGreen)
                    .cornerRadius(8)
                
                Button(action: {
                    Task {
                        do {
                            try await API.createVoucher(title: title, description: description, purchasedCredit: purchasedCredit)
                            print("Post criado com sucesso!")
                        } catch {
                            print("Erro ao criar post: \(error)")
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: "dollarsign.circle.fill")
                            .font(.title2)
                        Text("Ativar Cupom")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(.darkGreen)
                    .cornerRadius(8)
                    .offset(y: 16)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Cadastrar Cupom")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
    

#Preview {
    VoucherRegisterView()
}
