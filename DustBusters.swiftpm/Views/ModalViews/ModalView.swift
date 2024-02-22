//
//  ModalView.swift
//  DustBusters
//
//  Created by user on 2/13/24.
//

import Foundation
import SwiftUI

struct ModalView: View {
    let borderColor: Color = .white
    let borderWidth: CGFloat = 20
    let modalText: [String]
    @State private var textNumber: Int = 0
    
    var body: some View {
        Group {
            Rectangle()
                .frame(width: 400, height: 400)
                .blendMode(.destinationOut)
                .overlay {
                    Text(modalText[textNumber])
                }
                .overlay {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            
                            Button {
                                // 추후에 ModalViewReducer로 분리
                                if textNumber > 0 {
                                    textNumber -= 1
                                }
                            } label: {
                                Text("Back")
                            }
                            
                            Button {
                                if textNumber < modalText.count - 1 {
                                    textNumber += 1
                                }
                            } label: {
                                Text("Next")
                            }
                        }
                    }
                    .padding(borderWidth)
                }
        }
        .border(borderColor, width: borderWidth)
    }
}


struct ModalTestView: View {
    var body: some View {
        Group {
            Color.yellow
                .overlay {
                    ModalView(modalText: [])
                }
        }
        .compositingGroup()
    }
}

#Preview {
    ModalTestView()
}
