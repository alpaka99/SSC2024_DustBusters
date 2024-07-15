//
//  File.swift
//
//
//  Created by user on 2/18/24.
//

import Foundation
import SwiftUI


struct SizeCompareView: View {
    @Binding var path: NavigationPath
    @State private var offset: CGFloat = CGFloat.zero
    @State private var isShowingFirstModal: Bool = true
    @State private var firstTrigger: Bool = true
    @State private var isShowingSecondModal: Bool = false
    @State private var secondTrigger: Bool = false
    
    private var scaleAmount: CGFloat {
        get {
            switch offset {
            case let x where ...(-145) ~= x:
                return pow(10, 145 / 50)
            case let x where ...0 ~= x:
                return pow(10, -(self.offset / 50))
            default:
                return CGFloat.one
            }
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 50) {
                ForEach(Constants.scalableObjects, id: \.self) { item in
                    Image(item.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: item.initialSize)
                        .opacity(item.opacity)
                        .padding(20)
                        .offset(x: 0.2)
                        .scaleEffect(scaleAmount)
                        .allowsHitTesting((item.imageName == Constants.twodustsImageName))
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded {
                                    if item.imageName == Constants.twodustsImageName {
                                        withAnimation {
                                            self.isShowingSecondModal = true
                                        }
                                    }
                                }
                        )
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width)
            .background {
                GeometryReader { proxy in
                    let offset: CGFloat = proxy.frame(in: .named("ScrollView")).origin.y
                    Color.clear.preference(
                        key: ScrollOffsetKey.self,
                        value: offset
                    )
                }
            }
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                self.offset = value
            }
            .onChange(of: scaleAmount) { _ in
                let soundTrigger = scaleAmount.truncatingRemainder(dividingBy: 10)
                if soundTrigger > 9 {
                    AudioManager.shared.playSound(.dragSound)
                }
            }
        }
        
        .scrollDisabled(isShowingFirstModal)
        .modalView(
            isShowingModal: $isShowingFirstModal,
            trigger: $firstTrigger,
            modalColor: .constant(Color.appColor()),
            messages: ["Micro dusts are dusts that is smaller than 10µm", "It is ultra small that it can only be seen using special micro scopes", "To see how small micro dust is, scroll on this screen and find micro dusts.", "And once you find it, tap on it!"],
            tapBackgroundToDismiss: true
        )
        .modalView(
            isShowingModal: $isShowingSecondModal,
            trigger: $secondTrigger,
            modalColor: .constant(Color.appColor()),
            messages: ["You found micro dusts!","Micro dusts are only 1/400000 or smaller then radius of world's smallest apple!", "This small size is the reason micro dusts cause problems.", "We can't let them just float on air and cause problems, can we?","Let's bust some dust starting from the one's near you!"],
            tapBackgroundToDismiss: false
        )
        .coordinateSpace(name: "ScrollView")
        .background{
            LinearGradient(
                colors: [.white, Color.appColor()],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
        .onChange(of: firstTrigger) { _ in
            isShowingFirstModal = false
        }
        .onChange(of: secondTrigger) { _ in
            path.append(Constants.NavigationValue.microDustEffectView)
        }
        .toolbar {
            ToolbarItem {
                Button {
                    isShowingFirstModal = true
                } label: {
                    Image(systemName: "questionmark.circle")
                        .font(.largeTitle)
                }
            }
        }
        .navigationTitle(String(format: "Scale: x%.0f", self.scaleAmount))
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat  = CGFloat.zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
