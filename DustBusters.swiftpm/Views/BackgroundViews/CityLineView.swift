//
//  SwiftUIView.swift
//
//
//  Created by user on 2/22/24.
//

import SwiftUI

struct CityLineView: View {
//    @State var neighborhoodColor: Color
//    @State var middleLineColor: Color
//    @State var skylineColor: Color
    @Binding var color: Color
    
    @State var neighborhoodViewOpacity: Double = 1
    @State var middlelineOpacity: Double = 0.5
    @State var skylineOpacity: Double = 0.2
    
    
    var body: some View {
        NeighborhoodView(buildingColor: $color)
            .opacity(neighborhoodViewOpacity)
            .background {
                MiddleLineView(buildingColor: $color)
                    .opacity(middlelineOpacity)
            }
            .background {
                SkyLineView(buildingColor: $color)
                    .opacity(skylineOpacity)
            }
            .background {
                color
                    .opacity(0.1)
            }
    }
}




