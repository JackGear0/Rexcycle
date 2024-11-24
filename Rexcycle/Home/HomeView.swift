//
//  HomeVIew.swift
//  Rexcycle
//
//  Created by Leo Leo on 23/11/24.
//

import SwiftUI

struct HomeView: View {
    
    var empresa = ["Amazon", "Guaraná", "Coca-cola", "Uber", "Dell"]
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                HStack(spacing: 116){
                    Text("Ola, Fulane")
                        .fontWeight(.bold)
                        .font(.system(size: 34))
                        .padding()
                        .foregroundColor(.darkGreen)
                        .frame(alignment: .leading)
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.darkGreen)
                }
                ZStack{
                    VStack{
                        HStack{
                            VStack{
                                Text("Você possui:")
                                    .foregroundStyle(.lightBrown)
                                HStack{
                                    Image(.coins)
                                        .font(.system(size: 56))
                                    VStack{
                                        Text("100")
                                            .font(.system(size: 28))
                                            .foregroundColor(.white)
                                        Text("créditos")
                                            .font(.system(size: 14))
                                            .foregroundColor(.white)
                                    }
                                }
                                .frame(width: 124, height: 55)
                                .background(.brown)
                                .cornerRadius(20)
                            }
                            .padding(.top)
                            VStack{
                                Text("Créditos Acumulados")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                Text("1000")
                                    .font(.system(size: 34))
                                    .foregroundColor(.white)
                                Text("créditos")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 193, height: 80)
                            .background(.lightBrown)
                            .cornerRadius(20)
                            .padding(.top)
                        }
                        NavigationLink(destination: AddMaterial()) {
                            HStack{
                                Image(systemName: "trash.circle.fill")
                                    .font(.system(size: 61))
                                    .foregroundColor(.white)
                                VStack(alignment: .leading){
                                    Text("Cadastrar Coleta")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .bold()
                                    Text("Transforme lixo reciclável em cupons de desconto")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            .frame(maxWidth: 323, maxHeight: 91)
                            .background(.darkGreen)
                            .cornerRadius(14)
                            .padding(.bottom)
                        }
                    }
                }
                .frame(width: 353, height: 213)
                .background(.white)
                .cornerRadius(20)
                
                HStack{
                    Text("Cupons para você")
                        .bold()
                        .font(.system(size: 34))
                        .padding()
                        .foregroundColor(.darkGreen)
                    Spacer()
                }
                HStack {
                    ForEach(0..<5) { i in
                        VStack {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 63, height: 63)
                                .foregroundColor(.lightWhite)
                            Text(empresa[i])
                                .foregroundStyle(.darkGreen)
                        }
                    }
                }
                ScrollView(.horizontal){
                    HStack{
                        Image(.cupom)
                        Image(.cupom)
                    }
                }
                .frame(width: 350)
                .scrollClipDisabled()
            }
            .scrollDisabled(true)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}
