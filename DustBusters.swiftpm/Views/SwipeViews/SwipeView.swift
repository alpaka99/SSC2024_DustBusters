//
//  SwiftUIView.swift
//  
//
//  Created by user on 2/22/24.
//

import Combine
import SwiftUI

struct SwipeView: View {
    @Binding var path: NavigationPath
    
    @State var isFinished: Bool = false
//    @State private var isShowingBottomMessage: Bool = false
    @State private var topMessageIndex: Int = 0
    @State private var nextViewCounter: Int = 0
    @State private var isShowingFirstModal: Bool = true
    @State private var firstTrigger: Bool = true
    @State private var isShowingToolbarItem: Bool = true
    
    let topMessages: [String] = ["What was under dusty screen? Nothing?", "Look carefully", "There is...", "You!"]
    @State private var timer = Timer.publish(every: 3, on: .main, in: .default).autoconnect()
    
    
    var body: some View {
        VStack {
            ScratchView(
                cursorSize: 75,
                isFinished: $isFinished
            ) {
                // body content
                Color.black
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
            } overlayView: {
                Color.brown
                    .overlay {
                        Image("dustOverlay")
                            .resizable()
                            .opacity(0.5)
                            .scaledToFill()
                    }
            }
            .modalView(
                isShowingModal: $isShowingFirstModal,
                trigger: $firstTrigger,
                modalColor: .constant(Color.appColor()),
                messages: ["Key to reduce micro dusts is here.", "Under this layer of micro dusts.", "Swipe off micro dusts to discover the key!"],
                tapBackgroundToDismiss: true
            )
            .onChange(of: firstTrigger) { _ in
                withAnimation {
                    isShowingFirstModal = false
                }
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            if isShowingFirstModal == false {
                if isFinished {
                    VStack {
                        Text(topMessages[topMessageIndex])
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                            .padding()
                            .onAppear {
                                withAnimation {
                                    self.isShowingToolbarItem = false
                                }
                                self.timer = timer.upstream.autoconnect()
                            }
                        
                        Spacer()
                        
                        if topMessageIndex >= topMessages.count - 1 {
                            Text("You are the Key to reduce micro dusts from air!")
                                .font(.system(size: 50))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.white)
                                .padding()
                        }
                    }
                } else {
                    HStack(spacing: 20) {
                        Text("Swipe micro dusts off!")
                            .font(.system(size: 50))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                        
                        
                        Image(systemName: "scribble.variable")
                            .font(.system(size: 100))
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    .onAppear {
                        timer.upstream.connect().cancel()
                    }
                }
            }
        }
        .onReceive(timer) { _ in
            if topMessageIndex < topMessages.count - 1 {
                withAnimation(.easeOut) {
                    topMessageIndex += 1
                }
            } else {
                nextViewCounter += 1
            }
        }
        .onChange(of: nextViewCounter) { _ in
            if nextViewCounter >= 2 {
                path.append(Constants.NavigationValue.endingView)
            }
        }
        .toolbar {
            if isShowingToolbarItem {
                ToolbarItem {
                    Button {
                        isShowingFirstModal = true
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .font(.largeTitle)
                    }
                }
            }
        }
    }
    
}


struct ScratchView<Content: View, OverlayView: View>: View {
    @Binding var isFinished: Bool
    @State private var startingPoint: CGPoint = .zero
    @State private var points: [CGPoint] = []
    // for gesture update
    @GestureState private var gestureLocation: CGPoint = .zero
    
    var content: Content
    var overlayView: OverlayView
    var cursorSize: CGFloat
    
    init(
        cursorSize: CGFloat,
        isFinished: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder overlayView: @escaping () -> OverlayView
    ) {
        self.cursorSize = cursorSize
        self._isFinished = isFinished
        self.content = content()
        self.overlayView = overlayView()
    }
    
    
    
    var body: some View {
        ZStack {
            overlayView
                .opacity(isFinished ? 0 : 1)
            
            content
                .mask {
                    ZStack {
                        if isFinished {
                            Rectangle()
                        } else {
                            ScratchMask(
                                points: points,
                                startingPoint: startingPoint
                            )
                            .stroke(style: StrokeStyle(
                                lineWidth: cursorSize,
                                lineCap: .round,
                                lineJoin: .round
                            ))
                        }
                    }
                }
                .animation(.easeInOut)
                .gesture(
                    DragGesture()
                        .updating($gestureLocation) { value, out, _ in
                            out = value.location
                            
                            DispatchQueue.main.async {
                                if startingPoint == .zero {
                                    startingPoint = value.location
                                }
                                points.append(value.location)
                                
                                if points.count % 40 == 0 {
                                    AudioManager.shared.playSound(.swipeSound)
                                }
                            }
                        }
                        .onEnded { value in
                            if points.count > 400 {
                                withAnimation(.easeInOut(duration: 2)) {
                                    isFinished = true
                                }
                            }
                        }
                )
        }
        .onChange(of: isFinished) { _ in
            if isFinished == false && points.isEmpty == false {
                withAnimation(.easeInOut(duration: 2)) {
                    resetView()
                }
            }
        }
    }
    
    func resetView() {
        points.removeAll()
        startingPoint = .zero
    }
}


struct ScratchMask: Shape {
    var points: [CGPoint]
    var startingPoint: CGPoint
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: startingPoint)
            path.addLines(points)
        }
    }
}


struct SwipeView_Preview: PreviewProvider {
    @State static var path: NavigationPath = .init()
    static var previews: some View {
        SwipeView(path: $path)
    }
}


