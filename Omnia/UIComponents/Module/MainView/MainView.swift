//
//  MainView.swift
//  Omnia
//
//  Created by Prathamesh Bhuravane on 14/12/24.
//

import SwiftUI
import RealityFoundation

struct MainView: View {
    /// The environment value to get the instance of the `OpenImmersiveSpaceAction` instance.
    @ObservedObject var appstate : AppState
    
    var body: some View {
        ZStack{
            
            if appstate.screen == .HomePage{
                HomePage(appstate: appstate)
            }
            
            if appstate.screen  == .DetailedView{
                DetailedView(appstate: appstate, callBack: { vehicle in
                    appstate.screen = .immersiveDetailView
                    appstate.selectedModelName = vehicle.imageName
                })
                
            }
            
            if appstate.screen  == .immersiveDetailView{
                //            CustomizationView(appState: appstate, activeId: .constant(0))
                immersiveDetailView(callBack: { vehicle, int in
                    appstate.isChange = true
                    appstate.selectedModelName = vehicle.name
                    appstate.selectedModelIndex = int
                }, appstate: appstate)
            }
        }
        .onAppear(){
            print("appsate screen: \(appstate.screen)")
        }
    }
}

#Preview(windowStyle: .automatic) {
    MainView(appstate: AppState())
}
