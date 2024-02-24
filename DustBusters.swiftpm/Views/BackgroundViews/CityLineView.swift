//
//  SwiftUIView.swift
//
//
//  Created by user on 2/22/24.
//

import SwiftUI

struct CityLineView: View {
    @State var neighborhoodColor: Color
    @State var middleLineColor: Color
    @State var skylineColor: Color
    
    
    var body: some View {
        NeighborhoodView(buildingColor: neighborhoodColor)
            .background {
                MiddleLineView(buildingColor: middleLineColor)
            }
            .background {
                SkyLineView(buildingColor: skylineColor)
            }
    }
}




