//
//  VehicleView.swift
//  Omnia
//
//  Created by Prathamesh Bhuravane on 14/12/24.
//

import SwiftUI
import Foundation

struct VehicleView: View {
    let vehicle: Vehicle
    
    var body: some View {
        VStack {
            Image(vehicle.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 115)
            
                .cornerRadius(12)
            Text(vehicle.name)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.1))
                .cornerRadius(12)
                .padding(.top, 8)
        }
        .frame(width: 180, height: 180)
        .cornerRadius(20)
        
    }
}
