//
//  SwiftUIView.swift
//
//
//  Created by user on 2/25/24.
//

import SwiftUI

struct EndingView: View {
    @Binding var path: NavigationPath
    
    @State private var isShowingModal: Bool = false
    @State private var trigger: Bool = false
    
    @State private var isShowingFirstBox: Bool = false
    @State private var isFirstBoxTouched: Bool = false
    
    @State private var isShowingSecondBox: Bool = false
    @State private var isSecondBoxTouched: Bool = false
    
    @State private var isShowingThirdBox: Bool = false
    @State private var isThirdBoxTouched: Bool = false
    
    @State private var color: Color = Color.appColor()
    
    let checkbox1: CheckBoxView = CheckBoxView(boxMessage: "message1")
    let checkbox2: CheckBoxView = CheckBoxView(boxMessage: "message2")
    let checkbox3: CheckBoxView = CheckBoxView(boxMessage: "message3")
    
    
    var body: some View {
        VStack {
            Spacer()
            
            checkbox1
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            withAnimation(.easeInOut) {
                                isFirstBoxTouched = true
                                isShowingSecondBox = true
                                Constants.appState = .halfway
                                color = Color.appColor()
                            }
                        }
                )
                .padding()
                .opacity(isShowingFirstBox ? 1 : 0)
                .allowsHitTesting(!isFirstBoxTouched)
            
            Spacer()
            
            checkbox2
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            withAnimation(.easeInOut) {
                                isSecondBoxTouched = true
                                isShowingThirdBox = true
                                Constants.appState = .clear
                                color = Color.appColor()
                            }
                        }
                )
                .padding()
                .opacity(isShowingSecondBox ? 1 : 0)
                .allowsHitTesting(!isSecondBoxTouched)
            
            Spacer()
            
            checkbox3
                .padding()
                .opacity(isShowingThirdBox ? 1 : 0)
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            withAnimation {
                                isThirdBoxTouched = true
                                isShowingModal = true
                            }
                        }
                )
                .allowsHitTesting(!isThirdBoxTouched)
            
            Spacer()
        }
        .modalView(
            isShowingModal: $isShowingModal,
            trigger: $trigger,
            modalColor: .constant(.blue),
            messages: [""],
            tapBackgroundToDismiss: true
        )
        .onChange(of: trigger) { _ in
            path = NavigationPath()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeInOut) {
                    isShowingFirstBox = true
                }
            }
        }
        .background {
                CityLineView(color: $color)
        }
        .toolbar {
            if isFirstBoxTouched && isSecondBoxTouched && isThirdBoxTouched {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingModal = true
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .font(.largeTitle)
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct CheckBoxView : View {
    @State private(set) var isChecked: Bool = false
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
