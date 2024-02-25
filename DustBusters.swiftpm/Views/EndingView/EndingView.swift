//
//  SwiftUIView.swift
//
//
//  Created by user on 2/25/24.
//

import SwiftUI

struct EndingView: View {
    @Binding var path: NavigationPath
    
    @State private var isShowingFirstBox: Bool = false
    @State private var isShowingSecondBox: Bool = false
    @State private var isShowingThirdBox: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            CheckBoxView(boxMessage: "message1")
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            withAnimation(.easeInOut) {
                                isShowingSecondBox = true
                                
                            }
                        }
                )
            
                .padding()
                .opacity(isShowingFirstBox ? 1 : 0)
            
            Spacer()
            
            CheckBoxView(boxMessage: "message2")
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            withAnimation(.easeInOut) {
                                isShowingThirdBox = true
                            }
                        }
                )
                .padding()
                .opacity(isShowingSecondBox ? 1 : 0)
            
            Spacer()
            
            CheckBoxView(boxMessage: "message2")
                .padding()
                .opacity(isShowingThirdBox ? 1 : 0)
            
            Spacer()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeInOut) {
                    isShowingFirstBox = true
                }
            }
        }
        .background {
                CityLineView(
                    neighborhoodColor: .blue,
                    middleLineColor: .indigo,
                    skylineColor: .black
                )
        }
        .toolbar {
            ToolbarItem {
                Button {
                    path = NavigationPath.init()
                } label: {
                    Text("Next")
                }
            }
        }
    }
}

struct CheckBoxView : View {
    @State private var isChecked: Bool = false
    let boxMessage: String
    
    var body: some View {
        HStack {
            Text(boxMessage)
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            Image(systemName: isChecked ? "checkmark.square":"square")
                .font(.system(size: 100))
                .padding()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
        }
        .background {
            RoundedRectangle(cornerRadius: 20)
                .stroke(style: StrokeStyle(lineWidth: 2))
                .fill(.blue)
        }
        .onTapGesture {
            isChecked = true
        }
    }
}

struct EndingView_Preview: PreviewProvider {
    @State static var path: NavigationPath = .init()
    static var previews: some View {
        EndingView(path: $path)
    }
}
