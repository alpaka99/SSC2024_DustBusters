//
//  File.swift
//
//
//  Created by user on 2/20/24.
//

import Foundation
import SwiftUI

struct MicroDustEffectView: View {
    @Binding var path: NavigationPath
    
    @State private var size: CGFloat = 0
    @State private var touchPosition: CGPoint = .zero
    @State private var isTextTouched: Bool = false
    @State private var offset: CGSize = .zero
    @State private var isEyeTapped: Bool = false
    @State private var isNoseTapped: Bool = false
    @State private var isLungTapped: Bool = false
    @State private var isSkinRashTapped: Bool = false
    @State private var isIntestineTapped: Bool = false
    @State private var isVeinTapped: Bool = false
    @State private var isEverythingTapped: Bool = false
    @State private var tappedCounter: Int = 0
    @State private var isPopdownAlertPresent: Bool = false
    @State private var message: String = ""
    @State private var isImageTouchEnabled: Bool = true
    
    @State private var isShowingFirstModal: Bool = true
    @State private var firstTrigger: Bool = false
    
    @State private var isShowingSecondModal: Bool = false
    @State private var secondTrigger: Bool = false
    
    var isPortrait: Bool = UIDevice.current.orientation.isPortrait
    
    private var eyesOffset: CGPoint {
//        if !isPortrait {
//            return CGPoint(x: -360, y: 0)
//        } else {
            return CGPoint(x: 0, y: -360)
//        }
    }
    
    private var skinOffset: CGPoint {
//        if !isPortrait {
//            return CGPoint(x: -80, y: -140)
//        } else {
            return CGPoint(x: -140, y: -80)
//        }
    }
    
    private var noseOffset: CGPoint {
//        if !isPortrait {
//            return CGPoint(x: -330, y: 0)
//        } else {
            return CGPoint(x: 0, y: -330)
//        }
    }
    
    private var lungOffset: CGPoint {
//        if !isPortrait {
//            return CGPoint(x: -160, y: 0)
//        } else {
            return CGPoint(x: 0, y: -160)
//        }
    }
    
    private var veinOffset: CGPoint {
//        if !isPortrait {
//            return CGPoint(x: 150, y: 50)
//        } else {
            return CGPoint(x: 50, y: 150)
//        }
    }
    
    private var intestineOffset: CGPoint {
//        if !isPortrait {
//            return CGPoint(x: -40, y: 0)
//        } else {
            return CGPoint(x: 0, y: -40)
//        }
    }
    
    private var smileyFaceOffset: CGPoint {
//        if !isPortrait {
//            return CGPoint(x: -350, y: 0)
//        } else {
            return CGPoint(x: 0, y: -350)
//        }
    }
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                VStack {
                    Image("human2")
                        .frame(
                            width: proxy.size.width,
                            height: proxy.size.height
                        )
                        .background {
                            switch tappedCounter {
                            case 0:
                                LinearGradient(colors: [.purple, .red]
                                               , startPoint: .bottom, endPoint: .top)
//                                Color.red
                            case 1:
                                Color.brown
                            case 2:
                                Color.orange
                            case 3:
                                Color.yellow
                            case 4:
                                Color.green
                            case 5:
                                Color.blue
                            case 6:
                                Color.purple
                            default:
                                Color.blue
                            }
                        }
                        .overlay { // tappable images
                            if isEverythingTapped {
                                Image("smileyFace")
                                    .offset(
                                        x: smileyFaceOffset.x,
                                        y: smileyFaceOffset.y
                                    )
                            } else {
                                // eye
                                Image("eyes")
                                    .foregroundStyle(Color.white)
                                    .offset(
                                        x: eyesOffset.x,
                                        y: eyesOffset.y
                                    )
                                    .opacity(isEyeTapped ? 0 : 1)
                                    .onTapGesture {
                                        // when tapped eye
                                        //                                    print("eye tapped")
                                        self.showPopdownAlert(.eyes)
                                    }
                                    .allowsHitTesting(isImageTouchEnabled)
                                
                                // skin
                                Image("skinRash")
                                    .font(.footnote)
                                    .foregroundStyle(Color.white)
                                    .offset(
                                        x: skinOffset.x,
                                        y: skinOffset.y
                                    )
                                    .opacity(isSkinRashTapped ? 0 : 1)
                                    .onTapGesture {
                                        // when tapped skin
//                                        print("skinRash tapped")
                                        self.showPopdownAlert(.skinRash)
                                    }
                                    .allowsHitTesting(isImageTouchEnabled)
                                
                                // respiratory - nose
                                Image("nose")
                                    .font(.footnote)
                                    .foregroundStyle(Color.white)
                                    .offset(
                                        x: noseOffset.x,
                                        y: noseOffset.y
                                    )
                                    .opacity(isNoseTapped ? 0 : 1)
                                    .onTapGesture {
                                        // when tapped nose
//                                        print("nose tapped")
                                        self.showPopdownAlert(.nose)
                                    }
                                    .allowsHitTesting(isImageTouchEnabled)
                                
                                // respiratory - lung
                                Image("lung")
                                    .font(.footnote)
                                    .foregroundStyle(Color.white)
                                    .offset(
                                        x: lungOffset.x,
                                        y: lungOffset.y
                                    )
                                    .opacity(isLungTapped ? 0 : 1)
                                    .onTapGesture {
                                        // when tapped lung
//                                        print("lung tapped")
                                        self.showPopdownAlert(.lung)
                                    }
                                    .allowsHitTesting(isImageTouchEnabled)
                                
                                // vein
                                Image("vein")
                                    .font(.footnote)
                                    .foregroundStyle(Color.white)
                                    .offset(
                                        x: veinOffset.x,
                                        y: veinOffset.y
                                    )
                                    .opacity(isVeinTapped ? 0 : 1)
                                    .onTapGesture {
                                        // when tapped vein
//                                        print("vein tapped")
                                        showPopdownAlert(.vein)
                                    }
                                    .allowsHitTesting(isImageTouchEnabled)
                                
                                // cancer
                                Image("intestine")
                                    .font(.footnote)
                                    .foregroundStyle(Color.white)
                                    .offset(
                                        x: intestineOffset.x,
                                        y: intestineOffset.y
                                    )
                                    .opacity(isIntestineTapped ? 0 : 1)
                                    .onTapGesture {
                                        // when tapped intestine
//                                        print("Intestine tapped")
                                        self.showPopdownAlert(.intestine)
                                    }
                                    .allowsHitTesting(isImageTouchEnabled)
                            }
                        }
                }
                .magnificationEffect(
                    $offset,
                    1.5,
                    0,
                    size
                )
                
                HeartBeatsView(counter: $tappedCounter,
                               startPosition: CGPoint(
                                x: proxy.size.width * 0.7,
                                y: proxy.size.height * 0.1
                               ))
            }
        }
        .ignoresSafeArea()
        .popdownAlert(
            isPresented: $isPopdownAlertPresent,
            message: $message
        )

        .modalView(
            isShowingModal: $isShowingFirstModal,
            trigger: $firstTrigger,
            modalColor: .constant(Color.appColor()),
            messages: ["Micro dust floats on air.", "And while they are floating, they can enter our body and make us sick", "Because they are so small and light, they get into deepest part of our body", "Examine each part of our body with magnifying glass", "When magnified, tap on the symptoms to cure this person!"],
            tapBackgroundToDismiss: true
        )
        .modalView(
            isShowingModal: $isShowingSecondModal,
            trigger: $secondTrigger,
            modalColor: .constant(Color.appColor()),
            messages: ["Great job on healing this person!", "Like you saw, all this and more sickness can be caused by micro dusts.", "It is important to reduce micro dusts in air we breath!", "But how?"],
            tapBackgroundToDismiss: true
        )
        .onChange(of: firstTrigger) { _ in
            isShowingFirstModal = false
        }
        .onChange(of: tappedCounter) { _ in
            if tappedCounter >= 6 {
                self.checkEverythingTapped()
            }
        }
        .onChange(of: isPopdownAlertPresent) { _ in
            self.isImageTouchEnabled = !isPopdownAlertPresent
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if isEverythingTapped {
                        isShowingSecondModal = true
                    } else {
                        isShowingFirstModal = true
                    }
                } label: {
                    Image(systemName: "questionmark.circle")
                        .font(.largeTitle)
                }
            }
        }
    }
    
    private func checkEverythingTapped() {
        if isEyeTapped && isNoseTapped && isLungTapped && isSkinRashTapped && isIntestineTapped && isVeinTapped {
            withAnimation {
                self.isEverythingTapped = true
                self.isShowingSecondModal = true
            }
        }
    }
    
    private func showPopdownAlert(_ bodyPart: BodyPart) {
        self.setPopdownAlertMessage(bodyPart)
        self.bodyImageTapped(bodyPart)
        
        withAnimation(.easeInOut(duration: 0.5)) {
            self.isPopdownAlertPresent = true
        }
    }
    
    private func bodyImageTapped(_ bodyPart: BodyPart) {
        switch bodyPart {
        case .eyes:
            withAnimation {
                self.isEyeTapped = true
            }
        case .nose:
            withAnimation {
                self.isNoseTapped = true
            }
        case .lung:
            withAnimation {
                self.isLungTapped = true
            }
        case .skinRash:
            withAnimation {
                self.isSkinRashTapped = true
            }
        case .intestine:
            withAnimation {
                self.isIntestineTapped = true
            }
        case .vein:
            withAnimation {
                self.isVeinTapped = true
            }
        }
        
        withAnimation {
            self.tappedCounter += 1
        }
    }
    
    private func setPopdownAlertMessage(_ bodyPart: BodyPart) {
        withAnimation {
            switch bodyPart {
            case .eyes:
                self.message = "Eyes Message"
            case .nose:
                self.message = "Nose Message"
            case .lung:
                self.message = "Lung Message"
            case .skinRash:
                self.message = "SkinRash Message"
            case .intestine:
                self.message = "intestine Message"
            case .vein:
                self.message = "Vein Message"
            }
        }
    }
    
    enum BodyPart {
        case eyes, nose, lung, skinRash, intestine, vein
    }
}


struct MagnificationEffectHelper<Content: View>: View {
    @Binding private var offset: CGSize
    @State private var lastStoredOffset: CGSize = .zero
    
    var scale: CGFloat
    var size: CGFloat
    var tint: Color = .black
    var content: Content
    
    init(offset: Binding<CGSize>, scale: CGFloat, rotation: CGFloat, size: CGFloat, tint: Color, content: @escaping () -> Content) {
        self._offset = offset
        self.scale = scale
        self.size = size
        self.tint = tint
        self.content = content()
    }
    
    var body: some View {
        content
        //            .reverseMask {
        //                let newCircleSize: CGFloat = 150.0 + size
        //                Circle()
        //                    .frame(width: newCircleSize, height: newCircleSize)
        //                    .offset(offset)
        //            }
            .overlay {
                GeometryReader {
                    let newCircleSize: CGFloat = 150.0 + size
                    let size: CGSize = $0.size
                    
                    Circle()
                        .fill(.clear)
                        .frame(
                            width: newCircleSize,
                            height: newCircleSize
                        )
                        .overlay(alignment: .topLeading) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .scaleEffect(
                                    1.4,
                                    anchor: .topLeading
                                )
                                .offset(
                                    x: -9,
                                    y: -9
                                )
                                .foregroundColor(Color.white)
                        }
                        .offset(offset)
                        .frame(width: size.width, height: size.height)
                    
                    content
                        .offset(x: -offset.width, y: -offset.height)
                        .frame(width: newCircleSize, height: newCircleSize)
                        .scaleEffect(1 + scale)
                        .clipShape(Circle())
                        .offset(offset)
                        .frame(width: size.width, height: size.height)
                }
            }
            .contentShape(Rectangle())
            .gesture (
                DragGesture()
                    .onChanged({ value in
                        offset = CGSize(
                            width: value.translation.width + lastStoredOffset.width,
                            height: value.translation.height + lastStoredOffset.height
                        )
                    })
                    .onEnded({ value in
                        lastStoredOffset = offset
                    })
            )
    }
}


struct MicroDustEffect_Preview: PreviewProvider {
    @State static var path: NavigationPath = .init()
    static var previews: some View {
        MicroDustEffectView(path: $path)
    }
}
