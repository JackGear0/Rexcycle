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
    @State var isEnterprise: Bool = false
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().isTranslucent = false
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if !isLoggedIn {
                    VStack(spacing: 60) {
                        Button(action: {
                            Task {
                                do {
                                    try await API.login(username: "Pedro", password: "123456")
                                    isEnterprise = false
                                    isLoggedIn = true
                                    print("Login realizado com sucesso!")
                                } catch {
                                    print("Erro ao fazer login: \(error)")
                                }
                            }
                        }) {
                            Text("Login como consumidor")
                                .font(.title)
                                .foregroundStyle(.black)
                                .padding()
                                .background(.babyGreen)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            Task {
                                do {
                                    try await API.login(username: "Apple", password: "123456")
                                    isEnterprise = true
                                    isLoggedIn = true
                                    print("Login realizado com sucesso!")
                                } catch {
                                    print("Erro ao fazer login: \(error)")
                                }
                            }
                        }) {
                            Text("Login como empresa")
                                .font(.title)
                                .foregroundStyle(.black)
                                .padding()
                                .background(.babyGreen)
                                .cornerRadius(8)
                        }
                    }
                } else {
                    TabView {
                        HomeView(isEnterprise: isEnterprise)
                            .tabItem {
                                Image(systemName: "leaf.fill")
                                Text("Home")
                            }
                        
                        ChatListView()
                        //GeminiChatView()
                            .tabItem {
                                Image(systemName: "message.fill")
                                Text("Chat")
                            }
                    }
                }
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
