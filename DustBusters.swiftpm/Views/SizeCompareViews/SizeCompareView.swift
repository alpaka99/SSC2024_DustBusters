//
//  File.swift
//
//
//  Created by user on 2/18/24.
//

import Foundation
import SwiftUI


struct SizeCompareView: View {
    @StateObject var sizeCompareViewReducer: SizeCompareViewReducer
    @State private var offset: CGFloat = CGFloat.zero
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
        }
        .coordinateSpace(name: "ScrollView")
        .background(Color.brown)
    }
}


struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat  = CGFloat.zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
