//
//  SwiftUIView.swift
//
//
//  Created by user on 2/22/24.
//

import SwiftUI

struct StrokeCityLineView: View {
    @Binding var color: Color
    
    @State var neighborhoodViewOpacity: Double = 1
    @State var middlelineOpacity: Double = 1
    @State var skylineOpacity: Double = 1
    
    
    var body: some View {
        StrokeNeighborhoodView(buildingColor: $color)
            .opacity(neighborhoodViewOpacity)
            .background {
                StrokeMiddleLineView(buildingColor: $color)
                    .opacity(middlelineOpacity)
            }
            .background {
                StrokeSkyLineView(buildingColor: $color)
                    .opacity(skylineOpacity)
            }
    }
}





