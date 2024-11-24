//
//  ChatTextField.swift
//  Rexcycle
//
//  Created by Yago Souza Ramos on 11/24/24.
//

import SwiftUI

struct ChatTextField: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 180)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundStyle(.babyGreen)
            HStack {
                TextField("Pergunte ao Rexy", text: .constant(""))
                    .foregroundStyle(.darkGreen)
                    .padding(.horizontal)
                Button {
                    
                } label: {
                    ZStack {
                        Color.darkGreen.clipShape(.circle)
                            .frame(width: 40, height: 40)
                            .padding()
                        Image("RexyPawWhite")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ChatTextField()
}
