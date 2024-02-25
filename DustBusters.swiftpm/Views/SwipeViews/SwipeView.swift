//
//  SwiftUIView.swift
//  
//
//  Created by user on 2/22/24.
//

import SwiftUI

struct SwipeView: View {
    @State var isFinished: Bool = false
    @State private var m: Int = 0
    
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
        .overlay(alignment: .top) {
            if isFinished {
                Text("What do you see?")
                    .font(.system(size: 100))
                    .foregroundStyle(Color.white)
                    .padding()
                    .onAppear {
                        
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
                                
                                if points.count % 80 == 0 {
                                    HapticManager.shared?.createHaptic(.rigidTwice, false)
                                }
                            }
                        }
                        .onEnded { value in
                            if points.count > 400 {
                                withAnimation {
                                    isFinished = true
                                }
                            }
                        }
                )
        }
        .onChange(of: isFinished) { _ in
            if isFinished == false && points.isEmpty == false {
                withAnimation(.easeInOut(duration: 5)) {
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
    static var previews: some View {
        SwipeView()
    }
}


