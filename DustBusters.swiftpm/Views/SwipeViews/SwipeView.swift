//
//  SwiftUIView.swift
//  
//
//  Created by user on 2/22/24.
//

import SwiftUI

struct SwipeView: View {
    @Binding var path: NavigationPath
    
    @State var isFinished: Bool = false
    @State private var isShowingBottomMessage: Bool = false
    
    let dustParticle: Circle = Circle()
    
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
                        Image("dustOverlay2")
                            .resizable()
                            .opacity(0.5)
                            .scaledToFill()
                    }
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            if isFinished {
                VStack {
                    Text("What do you see? Nothing?")
                        .font(.system(size: 100))
                        .foregroundStyle(Color.white)
                        .padding()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                withAnimation(.easeInOut(duration: 2)) {
                                    isShowingBottomMessage = true
                                }
                            }
                        }
                    
                    Spacer()
                    
                    if isShowingBottomMessage {
                        Text("There is you!\nYou are the Key to reduce microdust from air")
                            .font(.system(size: 100))
                            .foregroundStyle(Color.white)
                            .padding()
                    }
                }
            } else {
                HStack(spacing: 20) {
                    Text("Swipe of dust!")
                        .font(.system(size: 100))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "scribble.variable")
                            .font(.system(size: 100))
                            .foregroundColor(Color.white)
                    }
                    
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    path.append(Constants.NavigationValue.endingView)
                } label: {
                    Text("Next")
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
                                
                                if points.count % 10 == 0 {
                                    HapticManager.shared?.createHaptic(.swipe, false)
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


