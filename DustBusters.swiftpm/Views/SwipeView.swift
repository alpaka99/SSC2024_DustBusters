//
//  SwiftUIView.swift
//  
//
//  Created by user on 2/22/24.
//

import SwiftUI

struct SwipeView: View {
    @State var isFinished: Bool = false
    var body: some View {
        VStack {
            ScratchView(
                cursorSize: 50,
                isFinished: $isFinished
            ) {
                // body content
                VStack {
                    Image("coffeebean")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    Text("You've won")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.gray)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } overlayView: {
                // overlay content
                Image("water")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.black.ignoresSafeArea()
        }
        .overlay(alignment: .top) {
            HStack(spacing: 15) {
                Button {
                    
                } label: {
                    Image(systemName: "scribble.variable")
                        .font(.title2)
                        .foregroundColor(Color.white)
                }
                Text("Scratch Card")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                Button {
                    isFinished = false
                } label: {
                    Image("twodusts")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 55, height: 55)
                        .clipShape(Circle())
                }
            }
            .padding()
        }
    }
}


struct ScratchView<Content: View, OverlayView: View>: View {
    
    var content: Content
    var overlayView: OverlayView
    var cursorSize: CGFloat
    @Binding var isFinished: Bool
    
    init(cursorSize: CGFloat, isFinished: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder overlayView: @escaping () -> OverlayView
    ) {
        self.cursorSize = cursorSize
        self._isFinished = isFinished
        self.content = content()
        self.overlayView = overlayView()
    }
    
    @State private var startingPoint: CGPoint = .zero
    @State private var points: [CGPoint] = []
    
    // for gesture update
    @GestureState private var gestureLocation: CGPoint = .zero
    
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
                            }
                        }
                        .onEnded { value in
                            print(points.count)
                            if points.count > 200 {
                                withAnimation {
                                    isFinished = true
                                }
                            }
                        }
                )
        }
        .frame(width: 300, height: 300)
        .cornerRadius(20)
        .onChange(of: isFinished) { _ in
            if isFinished == false && points.isEmpty == false {
                withAnimation(.easeInOut) {
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


