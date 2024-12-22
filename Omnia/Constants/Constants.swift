//
//  Constants.swift
//  Omnia
//
//  Created by Prathamesh Bhuravane on 14/12/24.
//

import Foundation

enum Constants{
    
    static let vehicles: [Vehicle] = [
        Vehicle(name: "Robotaxi", imageName: "RoboTaxi_Vision_Pro"),
        Vehicle(name: "Cybertruck", imageName: "Cybertruck_Apple_Vision"),
        Vehicle(name: "Model Y", imageName: "Tesla_Model_Y_Apple_Vision_Pro"),
        Vehicle(name: "Model S", imageName: "Tesla_Model_S_Vision_Pro"),
        Vehicle(name: "Model 3", imageName: "Tesla_Model_3_Vision_Pro"),
        Vehicle(name: "Model X", imageName: "Tesla_Model_X_Apple_Vision_Pro"),
        Vehicle(name: "Seat", imageName: "Seat"),
    ]
    
}


enum CarSpecs{
    case AWD
    case Plaid
}

enum screen{
    case HomePage
    case DetailedView
    case immersiveDetailView
}
