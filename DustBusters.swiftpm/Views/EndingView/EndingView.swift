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
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("By...")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding(50)
            
            Spacer()
            
            CheckBoxView(
                isChecked: $isFirstBoxTouched,
                solution: "Hi-level emission controls and strict management,  which can significantly reduce dusts and hazardous gases.",
                reason: "While CO2 makes up the most of coal-fired power plant emissions, they also contain nitrogen oxides (NOx) and sulfur oxides (SOx) which turns into micro dusts in the atmosphere."
            )
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            withAnimation(.easeInOut) {
//                                isFirstBoxTouched.toggle()
                                isShowingSecondBox = true
                                Constants.appState = .halfway
                                color = Color.appColor()
                            }
                        }
                )
                .padding()
                .opacity(isShowingFirstBox ? 1 : 0)
            
            Spacer()
            
            CheckBoxView(
                isChecked: $isSecondBoxTouched,
                solution: "Driving natural gas or electric vehicle and attaching dust filter to vehicle's gas outlet.",
                reason: "One of the reason old diesel vehicles. Diesel cars emit up to 20 times more ultrafine micro dusts (PM2.5) than gasoline cars. Lots of harmful gases are transforms into micro dusts in the air."
            )
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            withAnimation(.easeInOut) {
//                                isSecondBoxTouched.toggle()
                                isShowingThirdBox = true
                                Constants.appState = .clear
                                color = Color.appColor()
                            }
                        }
                )
                .padding()
                .opacity(isShowingSecondBox ? 1 : 0)
            
            Spacer()
            
            CheckBoxView(
                isChecked: $isThirdBoxTouched,
                solution: "Plant lots of trees that effectively reduce micro dusts.",
                reason: "Trees adsorb and absorb micro dust that is already in the air. A single tree can absorb 2.5T of carbon dioxide and 35.7g of micro dusts per year, while releasing 1.8T of oxygen. "
            )
                .padding()
                .opacity(isShowingThirdBox ? 1 : 0)
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            withAnimation {
//                                isThirdBoxTouched.toggle()
                                isShowingModal = true
                            }
                        }
                )
            
            Spacer()
        }
        .modalView(
            isShowingModal: $isShowingModal,
            trigger: $trigger,
            modalColor: .constant(.blue),
            messages: ["Great job on completing all steps of this app!", "By\n• Knowing what micro dusts are\n• Realizing micro dusts around us\n• Understanding effects of micro dusts\n• And acknoledging how to prevent and reduce micro dusts", "You are now officially a Dust Buster!", "Thank you for returning blue sky in this app. Please continue in reality too.", "For earth, for us."],
            tapBackgroundToDismiss: true
        )
        .onChange(of: trigger) { _ in
            path = NavigationPath()
        }
        .onChange(of: isShowingFirstBox) { _ in
            if isShowingFirstBox {
                AudioManager.shared.playSound(.solutionBell)
            }
        }
        .onChange(of: isShowingSecondBox) { _ in
            if isShowingSecondBox {
                AudioManager.shared.playSound(.solutionBell)
            }
        }
        .onChange(of: isShowingThirdBox) { _ in
            if isShowingThirdBox {
                AudioManager.shared.playSound(.solutionBell)
            }
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
    @Binding var isChecked: Bool
    let solution: String
    let reason: String
    
    var body: some View {
        HStack {
            Text(isChecked ? reason : solution)
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            Image(systemName: isChecked ? "checkmark.square" : "square")
                .font(.system(size: 100))
                .padding()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(radius: 5, x: 5, y: 5)
        }
        .background {
            RoundedRectangle(cornerRadius: 20)
                .stroke(style: StrokeStyle(lineWidth: 2))
                .fill(.blue)
        }
        .onTapGesture {
            isChecked.toggle()
        }
    }
}

struct EndingView_Preview: PreviewProvider {
    @State static var path: NavigationPath = .init()
    static var previews: some View {
        EndingView(path: $path)
    }
}
