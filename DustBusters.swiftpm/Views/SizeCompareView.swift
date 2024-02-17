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
            if self.offset > 0 {
                return 0
            } else {
                return -(self.offset / 100)
            }
        }
    }
    
    let items: [String] = ["Basket ball", "Apple",  "Hair", "MicroDust", "Dummy"]
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 500) {
                ForEach(self.items, id: \.self) { item in
                    Text(String(describing: item))
                        .frame(maxWidth: 400)
                        .padding(20)
                        .scaleEffect(scaleAmount)
                }
            }
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
    }
}


struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat  = CGFloat.zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

//struct DetectScrollPosition: View {
//    @State private var scrollPosition: CGPoint = .zero
//    
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack {
//                    ForEach((1...50), id: \.self) { row in
//                        Text("Row \(row)")
//                            .frame(height: 30)
//                            .id(row)
//                    }
//                }
//                .background(GeometryReader { geometry in
//                    Color.clear
//                        .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
//                })
//                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
//                    self.scrollPosition = value
//                }
//            }
//            .coordinateSpace(name: "scroll")
//            .navigationTitle("Scroll offset: \(scrollPosition.y)")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
