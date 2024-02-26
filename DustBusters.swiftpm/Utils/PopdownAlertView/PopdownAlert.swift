//
//  File.swift
//  
//
//  Created by user on 2/25/24.
//

import Foundation
import SwiftUI

extension View {
    func popdownAlert(
        isPresented: Binding<Bool>,
        message: Binding<String>
    ) -> some View {
        modifier(PopdownAlert(
            isPresented: isPresented,
            message: message
        ))
    }
}

struct PopdownAlert: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var message: String
    
    init(isPresented: Binding<Bool>, message: Binding<String>) {
        self._isPresented = isPresented
        self._message = message
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if isPresented {
                    Text(message)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(
                            width: 600,
                            height: 150
                        )
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(maxWidth: .infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 20, x: 10, y: 20)
                        }
                        .opacity(isPresented ? 1 : 0)
                        .transition(.move(edge: .top))
                        .padding()
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isPresented = false
                            }
                        }
                }
            }
    }
}
