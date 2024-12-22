//
//  ReusableViews.swift
//  Omnia
//
//  Created by Prathamesh Bhuravane on 14/12/24.
//

import SwiftUI

@MainActor
var CompanyLogo:some View {
    
    HStack(alignment: .center){
        Image("CompanyLogo")
            .resizable()
            .frame(width:94,height: 44)
        Spacer()
    }
    .padding(.leading,32)
    //        .background(Color.red)
}

@MainActor
func CarLogoHorizontal(size: CGSize, islogoTitle:Bool) ->some View {
    
    VStack{
        Image("tesla_logo_horizontal")
            .resizable()
            .frame(width:216,height: 67.5)
        Spacer()
            .frame(height: 30)
    }
    
    
    .frame(width: size.width)
    // .frame(width: 177)
}


@MainActor
func CarLogoVertical(size: CGSize, islogoTitle:Bool) ->some View {
    
    VStack{
        Image("tesla_logo_vertical")
            .resizable()
            .frame(width:116,height: 148)
        Spacer()
            .frame(height: 30)
        Text("Welcome to the Tesla Virtual Showroom")
            .multilineTextAlignment(.center)
    }
    
    
    .frame(width: size.width)
    // .frame(width: 177)
}

func backButton(completion: @escaping () -> Void) -> some View {
    Button {
        completion()
    } label: {
        Image(systemName: "chevron.backward")
    }
    .padding(20)
}


struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Adds a subtle scaling effect when pressed
            .background(configuration.isPressed ? Color.gray.opacity(0.3) : Color.clear) // Highlight effect
            .cornerRadius(20) // Matches the shape of VehicleView
    }
}
