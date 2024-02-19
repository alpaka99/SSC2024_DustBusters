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
//                        .onChange(of: scaleAmount) { _ in
//                            print("\(item.imageName): \(scaleAmount) x \(item.initialSize) = \(scaleAmount * item.initialSize) / offset: \(offset)")
//                            if item.imageName == Constants.basketBallImageName {
//                                print(String(repeating: "=", count: 40))
//                            }
//                        }
                        .onTapGesture {
                            print(item.imageName)
                        }
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

extension CGFloat {
    static let one: Self = 1
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
