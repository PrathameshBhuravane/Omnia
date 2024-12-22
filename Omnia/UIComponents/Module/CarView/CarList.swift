//
//  CarList.swift
//  Omnia
//
//  Created by Prathamesh Bhuravane on 14/12/24.
//

import SwiftUI

struct CarList: View {
    var callBack : (Vehicle,Int)->Void?
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 33) {
                ForEach(Array(Constants.vehicles.enumerated()), id: \.1.id) { index, vehicle in
                    Button(action: {
                        callBack(vehicle,index)
                    }) {
                        VehicleView(vehicle: vehicle)
                    }
                    .frame(width: 180, height: 180)
                    .buttonBorderShape(.roundedRectangle(radius: 20)) // Prevents default button styling
                }
            }
            .padding()
        }
    }
}

#Preview {
    CarList(callBack: {_,_  in })
}
