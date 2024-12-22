//
//  CustomizationView.swift
//  Omnia
//
//  Created by Prathamesh Bhuravane on 14/12/24.
//

import SwiftUI

struct CustomizationView: View {
    @ObservedObject var appState: AppState
    @Binding var activeId: Int?
    @State private var selectedColor: UIColor?
    @State private var selectedView: String = "Exterior" // Tracks selected view (Exterior/Interior)
    
    var body: some View {
        VStack {
            titleView
            ExteriorColorSection
            Spacer()
            optimusAndToggleViewSection
            Spacer()
            accesoriesSection
            Spacer()
        }
        .frame(width: 466, height: 720) // Fixed width and height
        .background(LinearGradient(
            gradient: Gradient(colors: [Color.black.opacity(0.8), Color.gray]),
            startPoint: .top,
            endPoint: .bottom
        ))
        .cornerRadius(20)
        .padding()
    }
    
    
    
    var titleView: some View {
        Text("Customization")
            .font(.extraLargeTitle2)
            .fontWeight(.bold)
            .padding()
    }
    
    var ExteriorColorSection: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Exterior Color Name")
                .font(.title)
            
            // Color selection
            HStack(spacing: 20) {
                ForEach(appState.colors, id: \.self) { color in
                    Circle()
                        .fill(Color(uiColor: color))
                        .frame(width: 64, height: 64)
                        .overlay(
                            Circle()
                                .stroke(selectedColor == color ? Color.gray : Color.clear, lineWidth: 5)
                        )
                        .onTapGesture {
                            selectedColor = color
                            let id = (appState.colors.firstIndex(of: color) ?? 0) + 1
                            appState.changeColor(index: id - 1)
                            activeId = id
                        }
                }
            }
            .padding(.vertical)
        }
    }
    
    var optimusAndToggleViewSection: some View {
        HStack(spacing: 20) {
            optimusButtonView
            // Toggle Buttons for View
            toggleButtonsForViewSection
            
            Spacer()
        }
        .frame(width: 150, height: 150)
    }
    
    var toggleButtonsForViewSection: some View {
        VStack {
            Text("View")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top,3)
            Spacer()
            
            Button(action: {
                selectedView = "Exterior"
            }) {
                
                Text("Exterior")
                    .frame(width: 80, height: 35)
                
            }
            .background(selectedView == "Exterior" ? Color.gray : Color.gray.opacity(0.2))
            .cornerRadius(20)
            
            .buttonBorderShape(.roundedRectangle(radius: 20))
            
            
            Button(action: {
                selectedView = "Interior"
            }) {
                Text("Interior")
                //                            .foregroundColor(.black)
                    .frame(width: 80, height: 35)
                
            }
            .background(selectedView == "Interior" ? Color.gray : Color.gray.opacity(0.2))
            .cornerRadius(20)
            
            .buttonBorderShape(.roundedRectangle(radius: 20))
        }
        
        .padding(.bottom,10)
        .frame(width: 150, height: 150)
        .background(Color.gray.opacity(0.4))
        .cornerRadius(20)
        
        
    }
    var optimusButtonView: some View {
            // Optimus Icon Placeholder
            Button {
                
            } label: {
                VStack {
                    Text("Optimus")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top,3)
                    
                    Spacer()
                    Image("Tesla_Optimus")
                        .resizable()
                        .frame(width: 43, height: 98)
                        .padding(.bottom,10)
                }
                .frame(width: 150, height: 150)
            }
            .frame(width: 150, height: 150)
            .buttonBorderShape(.roundedRectangle(radius: 20))
    }
    
    var accesoriesSection: some View {
        VStack {
            Text("Accessories")
                .font(.title)
                .padding(.bottom, 30)
            
            Button {
                
            } label: {
                Image("Seat")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 104, height: 104)
                    .padding()
                    .cornerRadius(20)
            }
            .frame(width: 150, height: 150)
            .buttonBorderShape(.roundedRectangle(radius: 20))
        }
        .padding(.vertical)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizationView(appState: AppState(), activeId: .constant(0))
    }
}

