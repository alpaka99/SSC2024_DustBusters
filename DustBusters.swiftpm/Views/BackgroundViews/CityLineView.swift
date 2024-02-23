//
//  SwiftUIView.swift
//
//
//  Created by user on 2/22/24.
//

import SwiftUI

struct CityLineView: View {
    var body: some View {
        NeighborhoodView(buildingColor: .brown)
            .background {
                SkyLineView(buildingColor: .blue)
            }
    }
}




