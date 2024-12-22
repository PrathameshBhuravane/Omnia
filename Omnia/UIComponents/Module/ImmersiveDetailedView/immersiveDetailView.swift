//
//  immersiveDetailView.swift
//  Omnia
//
//  Created by Prathamesh Bhuravane on 14/12/24.
//

import SwiftUI

struct immersiveDetailView: View {
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    var callBack : (Vehicle,Int)->Void?
    @ObservedObject var appstate: AppState
    @State var carSpecsSelected: CarSpecs = .AWD
    var body: some View {
        HStack(alignment:.top){
            
            backButton {
                dismissWindows()
                appstate.screen = .DetailedView
            }
            VStack{
                HStack{
                    CompanyLogo
                }
                CarLogoHorizontal(size: CGSize(width: 216, height: 67), islogoTitle: false)
                Text(appstate.myVehicle.name)
                    .font(.largeTitle)
                carSpecs
                CarList{vehicle, index in
                    print(vehicle)
                    print(index)
                    appstate.myVehicle = vehicle
                    appstate.selectedModelIndex = index
                    callBack(vehicle, index)
                }
            }
            
            .frame(width: 466,height: 712)
            .glassBackgroundEffect()
        }
        .onAppear {
            Task {
                await openImmersiveSpace(id: "CarView")
            }
        }
        .task {
            openWindow(id: "custom")
        }
        .onDisappear{
            dismissWindows()
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
            
            
            
        }
        .frame(width: 377,height: 218)
        .glassBackgroundEffect()
        
    }
    
    func dismissWindows(){
        Task {
            dismissWindow(id: "custom")
            await dismissImmersiveSpace()
        }
    }
    
}

#Preview {
    //    immersiveDetailView()
}
