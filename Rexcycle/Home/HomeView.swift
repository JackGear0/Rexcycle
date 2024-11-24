//
//  HomeVIew.swift
//  Rexcycle
//
//  Created by Leo Leo on 23/11/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                HStack{
                    Text("Ola, Fulane")
                        .fontWeight(.bold)
                        .font(.system(size: 34))
                        .padding()
                        .foregroundColor(.darkGreen)
                        .frame(alignment: .leading)
                    Spacer()
                }
                Image(.card)
                //                    .resizable()
                //                    .frame(width: 220, height: 220)
                HStack{
                    Text("Para você")
                        .font(.system(size: 34))
                        .padding()
                        .foregroundColor(.darkGreen)
                    Spacer()
                }
                HStack {
                    ForEach(0..<5) { _ in
                        ZStack {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 63, height: 63)
                                .foregroundColor(.lightWhite)
                            Text("IMG")
                                .foregroundStyle(.darkGreen)
                        }
                    }
                }
                ScrollView(.horizontal){
                    HStack{
                        Image(.cupom)
                            .foregroundColor(.lightWhite)
                        Image(.cupom)
                            .foregroundColor(.lightWhite)
                    }
                }
                .frame(width: 350)
                .scrollClipDisabled()
                HStack{
                    Text("Reciclagem")
                        .font(.system(size: 34))
                        .padding()
                        .foregroundColor(.darkGreen)
                    Spacer()
                }
                Button(action: {}) {
                    HStack{
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 26))
                            .foregroundColor(.white)
                        Text("Cadastrar Coleta")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
                .frame(minWidth: 330)
                .bold()
                .padding()
                .background(.darkGreen)
                .cornerRadius(50)
                Text("Cadastre coletas e acumule créditos para resgatar cupons ")
                    .font(.system(size: 15))
                    .foregroundColor(.darkGreen)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: 257)
                HStack {
                    Text("Locais de Coleta")
                        .font(.system(size: 25))
                        .padding()
                        .foregroundColor(.darkGreen)
                    Spacer()
                }
                Rectangle()
                    .frame(width: 348, height: 110)
                    .cornerRadius(19)
                    .foregroundColor(.white)
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}
