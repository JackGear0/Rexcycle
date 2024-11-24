//
//  HomeVIew.swift
//  Rexcycle
//
//  Created by Leo Leo on 23/11/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.dismiss) var dismiss
    @State var userAuth: User
    @State var isLoading: Bool = true
    @State var vouchers: [Voucher] = []
    var empresa = ["Amazon", "Guaraná", "Coca-cola", "Uber", "Dell"]
    @State private var showingSheet = false
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            if !userAuth.is_enterprise {
                ScrollView {
                    HStack(){
                        Text("Olá, \(userAuth.name)")
                            .fontWeight(.bold)
                            .font(.system(size: 34))
                            .padding()
                            .foregroundColor(.darkGreen)
                            .frame(alignment: .leading)
                        Spacer()
                    }
                    ZStack{
                        VStack{
                            HStack{
                                VStack{
                                    Text("Você possui:")
                                        .foregroundStyle(.lightBrown)
                                        .fontWeight(.bold)
                                }
                                .padding(.top)
                                VStack{
                                    HStack{
                                        Image(.coins)
                                            .font(.system(size: 56))
                                        VStack{
                                            Text(String(format: "%.2f", userAuth.credit))
                                                .font(.system(size: 28))
                                                .foregroundColor(.white)
                                            Text("créditos")
                                                .font(.system(size: 14))
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                //                                .frame(width: 193, height: 80)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.brown)
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
                        .padding(.vertical, 0)
                        .padding(.horizontal, 16)
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
                    if !isLoading {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(vouchers) { voucher in
                                    HStack {
                                        Circle()
                                            .frame(height: 52)
                                            .foregroundStyle(.darkGreen)
                                        VStack(alignment: .leading){
                                            Text("\(voucher.title)")
                                                .font(.system(size: 20))
                                                .bold()
                                                .foregroundColor(.darkGreen)
                                            Text("\(voucher.description)")
                                                .font(.system(size: 18))
                                                .foregroundColor(.darkGreen)
                                            HStack{
                                                Image(systemName: "dollarsign.circle.fill")
                                                    .font(.system(size: 15))
                                                Text("Custo: \(String(format: "%.2f", voucher.purchased_credit))  créditos")
                                                    .font(.system(size: 13))
                                            }
                                            .foregroundColor(.lightBrown)
                                        }
                                    }
                                    .padding(.trailing, 40)
                                    .background(Image(.cupom))
                                    .frame(width: 328, height: 106)
                                    .onTapGesture {
                                        showingSheet = true
                                    }
                                    .sheet(isPresented: $showingSheet) {
                                        RedeemVoucherView(voucherCode: voucher.id)
                                    }
                                }
                            }
                        }
                        .frame(width: 350)
                        .scrollClipDisabled()
                    }
                }
                .scrollDisabled(true)
                
            } else {
                ScrollView {
                    HStack(){
                        Text("Olá, \(userAuth.name)")
                            .fontWeight(.bold)
                            .font(.system(size: 34))
                            .padding()
                            .foregroundColor(.darkGreen)
                            .frame(alignment: .leading)
                        Spacer()
                    }
                    ZStack{
                        VStack{
                            HStack{
                                VStack{
                                    Text("Você possui:")
                                        .foregroundStyle(.lightBrown)
                                        .fontWeight(.bold)
                                }
                                .padding(.top)
                                VStack{
                                    HStack{
                                        Image(.coins)
                                            .font(.system(size: 56))
                                        VStack{
                                            Text(String(format: "%.2f", userAuth.credit))
                                                .font(.system(size: 28))
                                                .foregroundColor(.white)
                                            Text("créditos")
                                                .font(.system(size: 14))
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                //                                .frame(width: 193, height: 80)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.brown)
                                .cornerRadius(20)
                                .padding(.top)
                            }
                            NavigationLink(destination: VoucherRegisterView()) {
                                HStack{
                                    Image(systemName: "dollarsign.circle.fill")
                                        .font(.system(size: 61))
                                        .foregroundColor(.white)
                                    VStack(alignment: .leading){
                                        Text("Cadastrar Cupom")
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                            .bold()
                                        Text("Oferte descontos em troca de créditos de carbono")
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
                        Text("Cupons ativos")
                            .bold()
                            .font(.system(size: 34))
                            .padding()
                            .foregroundColor(.darkGreen)
                        Spacer()
                    }
                    if !isLoading {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(vouchers) { voucher in
                                    HStack {
                                        Circle()
                                            .frame(height: 52)
                                            .foregroundStyle(.darkGreen)
                                        VStack(alignment: .leading){
                                            Text("\(voucher.title)")
                                                .font(.system(size: 20))
                                                .bold()
                                                .foregroundColor(.darkGreen)
                                            Text("\(voucher.description)")
                                                .font(.system(size: 18))
                                                .foregroundColor(.darkGreen)
                                            HStack{
                                                Image(systemName: "dollarsign.circle.fill")
                                                    .font(.system(size: 15))
                                                Text("Custo: \(String(format: "%.2f", voucher.purchased_credit))  créditos")
                                                    .font(.system(size: 13))
                                            }
                                            .foregroundColor(.lightBrown)
                                        }
                                    }
                                    .padding(.trailing, 40)
                                    .background(Image(.cupom))
                                    .frame(width: 328, height: 106)
                                }
                            }
                        }
                        .frame(width: 350)
                        .scrollClipDisabled()
                    }
                }
                .scrollDisabled(true)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                do {
                    vouchers = try await API.getVouchers()
                    isLoading = false
                    print("Login realizado com sucesso!")
                } catch {
                    print("Erro ao fazer login: \(error)")
                }
            }
        }
    }
}

#Preview {
    HomeView(userAuth: User(username: "p", name: "pedro", credit: 21, is_enterprise: false))
}
