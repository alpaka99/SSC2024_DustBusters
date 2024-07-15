//
//  File.swift
//
//
//  Created by user on 2/23/24.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func magnificationEffect(
        _ offset: Binding<CGSize>,
        _ scale: CGFloat,
        _ rotation: CGFloat,
        _ size: CGFloat = 0,
        _ tint: Color = .black
    ) -> some View {
        MagnificationEffectHelper(
            offset: offset,
            scale: scale,
            rotation: rotation,
            size: size,
            tint: tint
        ) {
            return self
        }
    }
    
    // ReversMask Modifier
    @ViewBuilder
    func reverseMask<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .mask {
                Rectangle()
                    .overlay {
                        content()
                            .blendMode(.destinationOut)
                    }
            }
    }
}
