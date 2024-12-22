//
//  DetailedView.swift
//  Omnia
//
//  Created by Prathamesh Bhuravane on 14/12/24.
//

import SwiftUI

struct DetailedView: View {
    @State var carSpecsSelected: CarSpecs = .AWD
    @ObservedObject var appstate : AppState
    var callBack : (Vehicle)->Void?
//    @State var myVehicle : Vehicle
    
    var body: some View {
        HStack(alignment:.top){
            
            backButton {
                appstate.screen = .HomePage
            }
            VStack{
                VStack(alignment: .center){
                    CompanyLogo
                    CarLogoHorizontal(size: CGSize(width: 177, height: 177), islogoTitle: false)
                        .padding(.top,24)
                    Spacer()
                        .frame(height: 32)
                }
                
                .padding(.top,24)
                HStack(spacing: 100){
                    carSpecs
                    VStack{
                        Image(appstate.myVehicle.imageName)
                            .resizable()
                            .scaledToFit()
                        Text(appstate.myVehicle.imageName)
                            .font(.largeTitle)
                    }
                    
                }
                .frame(height: 220)
                
                Spacer()
                    .frame(height: 32)
                CarList(
                    callBack: { vehicle,index  in
                        appstate.myVehicle = vehicle
                        appstate.selectedModelIndex = index
                    })
                
                
            }
            .frame(width: 1280,height: 720)
            .glassBackgroundEffect()
        }
    }
    
    
    var carSpecs: some View{
        
        VStack{
            HStack(spacing: 20){
                VStack{
                    Text("AWD")
                        .padding(.vertical,10)
                        .padding(.horizontal,15)
                        .background(carSpecsSelected == .AWD ? Color.gray : Color.clear)
                        .glassBackgroundEffect()
                        .onTapGesture {
                            carSpecsSelected = .AWD
                        }
                    Spacer()
                    Text("Plaid")
                        .padding(.vertical,10)
                        .padding(.horizontal,15)
                        .background(carSpecsSelected == .Plaid ? Color.gray : Color.clear)
                        .glassBackgroundEffect()
                        .onTapGesture {
                            carSpecsSelected = .Plaid
                        }
                }
                
                VStack(alignment:.leading){
                    HStack{
                        Text("Price")
                            .fontWeight(.bold)
                        Spacer()
                        Text("$75.90")
                            .fontWeight(.bold)
                    }
                    Spacer()
                    HStack{
                        Text("Top Speed")
                            .fontWeight(.bold)
                        Spacer()
                        Text("130 mph")
                            .fontWeight(.bold)
                    }
                    Spacer()
                    HStack{
                        Text("Range")
                            .fontWeight(.bold)
                        Spacer()
                        Text("402 mi")
                            .fontWeight(.bold)
                    }
                }
                
            }
            .frame(height: 78)
            .padding(.horizontal,32)
            
            Spacer()
                .frame(height: 32)
            experienceview
            
            
        }
        .frame(width: 377,height: 218)
        .glassBackgroundEffect()
        
    }
    
    
    var experienceview: some View{
        Button {
            print("appstate.myVehicle",appstate.myVehicle)
            callBack(appstate.myVehicle)
        }
        label: {
            HStack{
                Image("3D_Symbol")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                Text("Experience Now")
                
            }
            
            
        }
        .background(Color.blue) // Background color of the button
        .cornerRadius(.infinity) // Rounded corners
        .foregroundColor(.white)
    }
    
    
}

#Preview {
    DetailedView(appstate: AppState(), callBack:{_ in })
}
