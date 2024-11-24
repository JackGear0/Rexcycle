//
//  ChatMessageView.swift
//  expologHackGeminiPOC
//
//  Created by Yago Souza Ramos on 11/23/24.
//

import SwiftUI

struct ChatMessageView: View {
    @State private var messageImage: Image = Image(systemName: "paperclip")
    @State var message: ChatMessage
    @State private var color = Color.blue
    @State private var colorText = Color.blue
    @State private var colorField = Color.blue
    @State private var colorCircle: Color = .blue
    @State private var orientation = LayoutDirection.rightToLeft
    @State private var alignment: HorizontalAlignment = .center
    @State private var textAlignment: TextAlignment = .leading
    @State private var containerSize: CGFloat = 150
    @Binding var isLoading: Bool
    let isFromUser: Bool
    var body: some View {
        Group {
            ZStack {
                VStack(alignment: alignment) {
                    HStack {
                        ZStack {
                            Circle()
                                .foregroundStyle(colorCircle)
                            messageImage
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                        }
                        .frame(width: 60, height: 60)
                        
                        VStack(alignment: .leading) {
                            Text("\(isFromUser ? "You" : "Rexcycle")")
                                .font(.headline)
                            Text("\(message.timestamp.formatted( date: .omitted, time: .shortened))")
                        }
                        
                        .foregroundStyle(.darkGreen)
                        Spacer()
                    }
                    HStack {
                        HStack {
                            Text("\(message.text)")
                                .multilineTextAlignment(!isFromUser ? .leading : .trailing)
                                .lineLimit(nil)
                                .font(.headline)
                                .foregroundColor(colorText)
                        }
                        .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 20))
                        .background {
                            UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 20, bottomTrailingRadius: 20,topTrailingRadius: 20)
                                .foregroundColor(colorField)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 120))
                        Spacer()
                    }
                    
                }.environment(\.layoutDirection, orientation)
            }
        }
        .onAppear {
            if isFromUser {
                colorCircle = .babyGreen
                orientation = .rightToLeft
                alignment = .leading
                messageImage = Image(systemName: "person.crop.circle.fill")
                colorText = .darkGreen
                colorField = .babyGreen
            } else {
                colorCircle = .lightGray
                orientation = .leftToRight
                alignment = .trailing
                messageImage = Image("RexyPaw")
                colorText = .black
                colorField = .lightGray

            }
        }
        .frame(minHeight: 100)
    }
}
    
#Preview {
    ChatMessageView(message: .init(text: "a!", sender: "i", timestamp: .now), isLoading: .constant(false), isFromUser: true)
    ChatMessageView(message: .init(text: "a!", sender: "i", timestamp: .now), isLoading: .constant(false), isFromUser: false)
}
