//
//  RedeemVoucherView.swift
//  Rexcycle
//
//  Created by Leo Leo on 24/11/24.
//

import SwiftUI

struct RedeemVoucherView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var isPurchased = false
    @State var voucherCode: UUID
    
    var body: some View {
        VStack {
            if(!isPurchased) {
                Text("Deseja mesmo resgatar esse cupom?")
                    .font(.system(size: 22))
                HStack(spacing: 70){
                    Text("Sim")
                        .foregroundStyle(.darkGreen)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(.babyGreen)
                        .cornerRadius(10)
                        .onTapGesture {
                            isPurchased = true
                        }
                    
                    Text("Não")
                        .foregroundStyle(.black)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(.red)
                        .cornerRadius(10)
                        .onTapGesture {
                            dismiss()
                        }
                }
            } else {
                Text("Cupom:")
                Text(voucherCode.uuidString)
            }
        }
    }
}

#Preview {
    RedeemVoucherView(voucherCode: UUID())
}
