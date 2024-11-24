////
////  LoginView.swift
////  Rexcycle
////
////  Created by Leo Leo on 23/11/24.
////
//
//import SwiftUI
//struct LoginView: View {
//    @State var username: String = ""
//    @State var password: String = ""
//    @State private var isPasswordVisible: Bool = false
////    @State private var token: String?
////    @State private var authUser: User?
//
////    let baseURL: URL
//
//    var body: some View {
//        NavigationView {
//            GeometryReader { geometry in
//                ZStack {
//                    Color.background
//                        .edgesIgnoringSafeArea(.all)
//                    VStack {
//                        ZStack{
//                            Image(systemName: "circle")
//                                .resizable()
//                                .frame(width: 220, height: 220)
//                            Text("Rexcycle")
//                                .fontWeight(.bold)
//                                .font(.system(size: 34))
//                                .padding()
//                                .foregroundColor(Color.blue)
//                        }
//                        Text("Log In")
//                            .fontWeight(.bold)
//                            .font(.system(size: 24))
//                            .padding()
//                            .foregroundColor(Color.blue)
//                        VStack(alignment: .center) {
//                            HStack {
//                                Text("Digite o seu nome de usuário")
//                                    .font(.system(size: 15, weight: .medium))
//                                    .foregroundColor(.gray)
//                                Spacer()
//                            }
//                            .frame(width: 300, alignment: .leading)
//                            .padding(.top, 10)
//                            .frame(width: 330, alignment: .leading)
//                            TextField("Nome de usuário", text: Binding(
//                                get: { username ?? "" },
//                                set: { username = $0 }
//                            ))
//                            .padding(15)
//                            .autocapitalization(.none)
//                            .frame(width: 330, height: 50)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.gray, lineWidth: 2)
//                                    .frame(width: 330, height: 50)
//                            )
//                            HStack {
//                                Text("Crie uma senha")
//                                    .font(.system(size: 15, weight: .medium))
//                                    .foregroundColor(.gray)
//                                Spacer()
//                            }
//                            .padding(.top, 10)
//                            .frame(width: 330, alignment: .leading)
//                            ZStack(alignment: .trailing) {
//                                if isPasswordVisible {
//                                    TextField("Senha", text: Binding(
//                                        get: { password ?? "" },
//                                        set: { password = $0 }
//                                    ))
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .stroke(Color.gray, lineWidth: 2)
//                                            .frame(width: 330, height: 50)
//                                    )
//                                    .autocapitalization(.none)
//                                } else {
//                                    SecureField("Senha", text: Binding(
//                                        get: { password },
//                                        set: { password = $0 }
//                                    ))
//                                    .padding(15)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .stroke(Color.gray, lineWidth: 2)
//                                            .frame(width: 330, height: 50)
//                                    )
//                                }
//                                Button(action: {
//                                    isPasswordVisible.toggle()
//                                }) {
//                                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
//                                        .foregroundColor(.gray)
//                                }
//                                .padding(.trailing, 10)
//                            }
//                            .frame(width: 300)
//                            Spacer().frame(height: 30)
//                            NavigationLink(destination: HomeView()) {
//                                HStack{
//                                    Text("ENTRAR")
//                                        .font(.system(size: 20))
//                                        .foregroundColor(.white)
//                                    Image(systemName: "door.right.hand.open")
//                                        .font(.system(size: 26))
//                                        .foregroundColor(.white)
//                                }
//                                .frame(minWidth: 330)
//                                .bold()
//                                .padding()
//                                .background(.darkGreen)
//                                .cornerRadius(50)
//                            }
//                        }
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                    .cornerRadius(15) // Adiciona bordas arredondadas se desejar
//                    .padding()
//                }
//                .onTapGesture {
//                    hideKeyboard()
//                }
//                .frame(width: geometry.size.width, height: geometry.size.height)
//            }
//        }
//    }
//    private func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//
////    func doLogin() {
////        Task {
////            do {
////                token = try await login(on: baseURL, username: username, password: password)
////                print("logado:", token)
////                authUser = try await me(on: baseURL, with: token!)
////            } catch {
////                print("Erro ao logar")
////            }
////        }
////    }
//}
//
//#Preview {
//    LoginView()
//}
