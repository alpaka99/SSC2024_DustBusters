//
//  File.swift
//  
//
//  Created by user on 2/20/24.
//

import Foundation
import SwiftUI

struct MicroDustEffectView: View {
    var body: some View {
        Image("basketball")
            .magnificationEffect(2, 0)
    }
}


extension View {
    @ViewBuilder
    func magnificationEffect(_ scale: CGFloat, _ rotation: CGFloat, _ size: CGFloat = 0, _ tint: Color = .black) -> some View {
        MagnificationEffectHelper(scale: scale, rotation: rotation, size: size, tint: tint) {
            return self
        }
    }
}


fileprivate struct MagnificationEffectHelper<Content: View>: View {
    
    var scale: CGFloat
    var rotation: CGFloat
    var size: CGFloat
    var tint: Color = .black
    
    var content: Content
    
    init(scale: CGFloat, rotation: CGFloat, size: CGFloat, tint: Color, content: @escaping () -> Content) {
        self.scale = scale
        self.rotation = rotation
        self.size = size
        self.tint = tint
        self.content = content()
    }
    
    @State private var offset: CGSize = .zero
    @State private var lastStoredOffset: CGSize = .zero
    
    var body: some View {
        content
            .reverseMask {
                let newCircleSize: CGFloat = 150.0 + size
                Circle()
                    .frame(width: newCircleSize, height: newCircleSize)
                    .offset(offset)
            }
            .overlay {
                GeometryReader {
                    let newCircleSize: CGFloat = 150.0 + size
                    let size: CGSize = $0.size
                    
                    content
                        .offset(x: -offset.width, y: -offset.height)
                        .frame(width: newCircleSize, height: newCircleSize)
                        .scaleEffect(scale)
                        .clipShape(Circle())
                        .offset(offset)
                        .frame(width: size.width, height: size.height)
                    
                    
                    Circle()
                        .fill(.clear)
                        .frame(width: newCircleSize, height: newCircleSize)
                        .overlay(alignment: .topLeading) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .scaleEffect(1.4, anchor: .topLeading)
                                .offset(x: -10, y: -5)
                        }
                        .rotationEffect(.init(degrees: rotation * 360.0))
                        .offset(offset)
                        .frame(width: size.width, height: size.height)
                }
            }
            .contentShape(Rectangle())
            .gesture (
                DragGesture()
                    .onChanged({ value in
                        offset = CGSize(width: value.translation.width + lastStoredOffset.width, height: value.translation.height + lastStoredOffset.height)
                    })
                    .onEnded({ value in
                        lastStoredOffset = value.translation
                    })
            )
    }
}


extension View {
    // ReversMask Modifier
    @ViewBuilder
    func reverseMask<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .mask {
                Rectangle()
                    .overlay {
                        content()                            .blendMode(.destinationOut)
                    }
            }
    }
}
