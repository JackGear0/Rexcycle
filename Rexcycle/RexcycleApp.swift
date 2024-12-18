//
//  RexcycleApp.swift
//  Rexcycle
//
//  Created by Leo Leo on 23/11/24.
//

import SwiftUI

@main
struct RexcycleApp: App {
    
    @State var isLoggedIn: Bool = false
    @State var userAuth: User?
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().isTranslucent = false
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ZStack{
                    Color.babyGreen
                    if !isLoggedIn {
                        VStack(spacing: 20) {
                            Image(.icon)
                                .font(.system(size: 50))
                                .padding(.bottom, 30)
                            Button(action: {
                                Task {
                                    do {
                                        try await API.login(username: "Pedro", password: "123456")
                                        userAuth = try await API.me()
                                        isLoggedIn = true
                                        print("Login realizado com sucesso!")
                                    } catch {
                                        print("Erro ao fazer login: \(error)")
                                    }
                                }
                            })
                            {
                                Text("Login como transportadora")
                                    .font(.title)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .background(.darkGreen)
                                    .cornerRadius(8)
                            }
                            
                            Button(action: {
                                Task {
                                    do {
                                        try await API.login(username: "Apple", password: "123456")
                                        userAuth = try await API.me()
                                        isLoggedIn = true
                                        print("Login realizado com sucesso!")
                                    } catch {
                                        print("Erro ao fazer login: \(error)")
                                    }
                                }
                            }) {
                                Text("Login como empresa")
                                    .font(.title)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .background(.darkGreen)
                                    .cornerRadius(8)
                            }
                        }
                    } else {
                        TabView {
                            HomeView(userAuth: userAuth!)
                                .tabItem {
                                    Image(systemName: "leaf.fill")
                                    Text("Home")
                                }
                            
                            ChatListView()
                                .tabItem {
                                    Image(systemName: "message.fill")
                                    Text("Chat")
                                }
                        }
                    }
                }
                .ignoresSafeArea()
            }
            .accentColor(.darkGreen)
            .onAppear {
                if UserDefaults.standard.string(forKey: "token") != nil {
                    Task {
                        do {
                            try await API.logout()
                            print("Logout realizado com sucesso!")
                        } catch {
                            print("Erro ao fazer login: \(error)")
                        }
                    }
                }
            }
        }
    }
}
