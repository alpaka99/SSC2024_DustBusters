//
//  ModalView.swift
//  DustBusters
//
//  Created by user on 2/13/24.
//

import Foundation
import SwiftUI

extension View {
    func modalView(
        isShowingModal: Binding<Bool>,
        trigger: Binding<Bool>,
        modalColor: Binding<Color>,
        messages: [String],
        tapBackgroundToDismiss: Bool
    ) -> some View {
        modifier(ModalViewModifier(
            isShowingModal: isShowingModal,
            trigger: trigger,
            modalColor: modalColor,
            messages: messages,
            tapBackgroundToDismiss: tapBackgroundToDismiss
        ))
    }
}

struct ModalViewModifier: ViewModifier {
    @Binding var isShowingModal: Bool
    @Binding var trigger: Bool
    @Binding var modalColor: Color
    @State private var messageIndex: Int = 0
    let messages: [String]
    let tapBackgroundToDismiss: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isShowingModal {
                    Color.black
                        .opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            if tapBackgroundToDismiss == true {
                                withAnimation {
                                    isShowingModal = false
                                }
                            }
                        }
                }
            }
            .overlay(alignment: .center) {
                if isShowingModal {
                    Text(messages[messageIndex])
                        .font(.largeTitle)
                        .padding()
                        .frame(maxWidth: 500)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(LinearGradient(colors: [.white, modalColor], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 500, height: 500)
                                .shadow(radius: 10, x: 20, y: 20)
                                .overlay(alignment: .bottomTrailing) {
                                    Button { // Next button
                                        if self.messageIndex < self.messages.count - 1 {
                                            self.messageIndex += 1
                                        } else {
                                            trigger.toggle()
                                        }
                                    } label: {
                                        Text("Next ▶")
                                    }
                                    .padding()
                                }
                                .overlay(alignment: .bottom) {
                                    Text("\(self.messageIndex + 1) / \(self.messages.count)")
                                        .padding()
                                }
                                .overlay(alignment: .bottomLeading) { // Previous button
                                    if messageIndex > 0 {
                                        Button {
                                            if self.messageIndex > 0 {
                                                self.messageIndex -= 1
                                            }
                                        } label: {
                                            Text("◀ Previous")
                                        }
                                        .padding()
                                    }
                                }
                        }
                    
                }
                
            }
    }
}


struct ModalTestView: View {
    @State private var isShowingModal: Bool = false
    @State private var trigger: Bool = false
    @State private var modalColor: Color = .orange
    
    var body: some View {
        VStack {
            Color.blue
                .onTapGesture {
                    withAnimation {
                        isShowingModal = true
                    }
                }
                .onChange(of: trigger) { _ in
                    print("triggered")
                }
        }
        .modalView(
            isShowingModal: $isShowingModal,
            trigger: $trigger,
            modalColor: $modalColor,
            messages: ["First", "Second", "third", "Fourth", "Fifth"],
            tapBackgroundToDismiss: true
        )
    }
}

struct ModalTestview_Preview: PreviewProvider {
    static var previews: some View {
        ModalTestView()
    }
}
