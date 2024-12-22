//
//  HomePage.swift
//  Omnia
//
//  Created by Prathamesh Bhuravane on 14/12/24.
//

import SwiftUI

struct HomePage: View {
    @ObservedObject var appstate : AppState
    var body: some View {
        VStack{
            VStack(alignment: .center){
                CompanyLogo
                CarLogoVertical(size: CGSize(width: 177, height: 177), islogoTitle: true)
                    .padding(.top,32)
                Spacer()
                    .frame(height: 64)
                CarList(
                    callBack: {vehicle,index  in
                        appstate.screen = .DetailedView
                        appstate.myVehicle = vehicle
                        appstate.selectedModelIndex = index
                    })
                
            }
            .padding(.top,24)
            Spacer()
            
        }
        .frame(width: 1280,height: 720)
        .glassBackgroundEffect()
        
    }
}
