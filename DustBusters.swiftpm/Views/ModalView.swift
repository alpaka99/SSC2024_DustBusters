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
    let modalText: [String] = ["Hi I'm Lets", "This is Modal View"]
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
                                // 추후에 ModalViewReducer로 분리
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
                    ModalView()
                }
        }
        .compositingGroup()
    }
}

extension CGSize {
    static func + (lhs: Self, rhs: Self) -> Self {
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}

#Preview {
    ModalTestView()
}
