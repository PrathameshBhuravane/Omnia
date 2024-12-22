//
//  OmniaApp.swift
//  Omnia
//
//  Created by Prathamesh Bhuravane on 14/12/24.
//

import SwiftUI

@main
struct OmniaApp: App {

    @StateObject var appstate = AppState()
    var body: some Scene {
        WindowGroup(id: "content") {
            MainView(appstate: appstate)
                .task {
                    appstate.reset()
                    await appstate.loadAllModels()
                }
        }
        .windowResizability(.contentSize)
        .windowStyle(.plain)
        .defaultWindowPlacement { content, context in
            return WindowPlacement(.utilityPanel)
        }
        
        WindowGroup(id: "custom"){
            CustomizationView(appState: appstate, activeId: .constant(0))
            
        }
        .defaultWindowPlacement { content, context in
            return WindowPlacement(.trailing(context.windows.first(where: { $0.id == "content" })!))
        }
        .windowResizability(.contentSize)
        .windowStyle(.plain)
        
        
        ImmersiveSpace(id: "CarView") {
            CarView(appstate: appstate)
                .onAppear{
                    appstate.isChange = true
                }
        }
        .defaultWindowPlacement { content, context in
            return WindowPlacement(.leading(context.windows.first(where: { $0.id == "content" })!))
        }
    }
}
