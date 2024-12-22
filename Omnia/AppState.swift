//
//  AppState.swift
//  Omnia
//
//  Created by Prathamesh Bhuravane on 14/12/24.
//

import SwiftUI
import Foundation
import RealityFoundation
class AppState: ObservableObject{
    
    var animationPlaybackController: AnimationPlaybackController? = nil
    @Published var selectedModel: ModelEntity?
    @Published var selectedModelName: String?
    @Published var selectedModelIndex: Int = 0
    @Published var isChange = true
    @Published var myVehicle = Vehicle(name: "Robotaxi", imageName: "RoboTaxi_Vision_Pro")
//    @Published var loadFirstModel = false
    @Published private(set) var isAllModelsLoaded: Bool = false
    @Published var screen: screen = .HomePage
    
//    var fileNames = ["Huracan-EVO-RWD-Spyder-opt-22","Tesla_Model_3_Vision_Pro","Cybertruck_Apple_Vision"]
    var models: [ModelEntity] = [] {
        didSet {
            // Update the published property whenever `models` changes
            isAllModelsLoaded = models.count == Constants.vehicles.count
        }
    }
    var colors: [UIColor] = [.white,.gray,.black,.red,.blue]
    var colorsIndex: Int?
    
    @MainActor
    func loadAllModels() async{
        
        for vehicle in Constants.vehicles{
            guard let car = try? await ModelEntity(named: vehicle.imageName) else {
                assertionFailure("Failed to load model: \(vehicle.imageName)")
                return
            }
            models.append(car)
        }
//        loadFirstModel = true
        print("All models loaded",models.count)
        
    }
    @MainActor
    func selectModel( rootEntity: Entity) async{
        
        let fileName: String = "RoboTaxi_Vision_Pro"
        guard let car = try? await ModelEntity(named: fileName) else {
            assertionFailure("Failed to load model: \(fileName)")
            return
        }
        selectedModel = car
        
        for child in rootEntity.children{
            print("firstEntity.children.first?.name :",child.name)
            if child.name == "selectedModel"{
                rootEntity.children[1] = selectedModel!
            }
        }
        
    }
    
    
    @MainActor
    func changeColor(index: Int){
        colorsIndex = index
        for materialIndex in 0..<(selectedModel!.model!.materials.count){
            print("yeah",selectedModel?.model?.materials[materialIndex].name)
            if selectedModel!.model?.materials[materialIndex].name == nil || selectedModel!.model?.materials[materialIndex].name == "carpaint"{
                print("yes red color")
                var material = SimpleMaterial(color: colors[index], isMetallic: true)
                material.metallic =  .float(1.0)// Fully metallic
                material.roughness = .float(0.2) // Slightly shiny
                selectedModel!.model?.materials[materialIndex] = material
            }
        }
    }
    
//    @MainActor
//    func loadFirstModelFunc(){
//        loadFirstModel = false
//        
//    }
    
    @MainActor
    func isChangeFunc(){
        isChange = false
    }
    
    
    @MainActor func addChangeCar(rootEntity: Entity,index: Int){
        guard Constants.vehicles.count == models.count else{
            return
        }
        selectedModel = models[index]
        print( "prechange",selectedModel?.name)
        
        let bounds = selectedModel!.visualBounds(relativeTo: nil)
        let carWidth: Float = (selectedModel!.model?.mesh.bounds.max.x)!
        let carHeight: Float = (selectedModel!.model?.mesh.bounds.max.y)!
        let carDepth: Float = (selectedModel!.model?.mesh.bounds.max.z)!
        let boxShape = ShapeResource.generateBox(
            width: carWidth,
            height: carHeight,
            depth: carDepth
        )
        selectedModel!.components.set(CollisionComponent(shapes: [boxShape]))
        selectedModel!.components.set(InputTargetComponent())
        selectedModel!.position.y -= bounds.min.y
        selectedModel!.position.z += bounds.min.z
        selectedModel!.position.x += bounds.min.x
        
        selectedModel?.name = "selectedModel"
        if (colorsIndex != nil){
            changeColor(index: colorsIndex!)
        } else{
            applyMaterial()
        }
        
        if let index = rootEntity.children.firstIndex(where: { $0.name == "selectedModel" }) {
            rootEntity.children[index] = selectedModel!
        }
        else{
            rootEntity.addChild(selectedModel!)
        }
        
//        if isReplace{
//            for child in rootEntity.children{
//                if child.name == "selectedModel"{
//                    rootEntity.children[0] = selectedModel!
//                }
//                
//            }
        
//        }
//        else{
//            rootEntity.addChild(selectedModel!)
//        }
        selectedModel?.position = [0.5,0,-7]
    }
    
    
    func applyMaterial(){
        for materialIndex in 0..<(selectedModel!.model!.materials.count){
            if var material = selectedModel!.model?.materials[materialIndex] as? PhysicallyBasedMaterial {
                if selectedModel!.model?.materials[materialIndex].name == "carpaint"{
                    material.metallic = PhysicallyBasedMaterial.Metallic(floatLiteral: 1.0) // Fully metallic
                    material.roughness = PhysicallyBasedMaterial.Roughness(floatLiteral: 0.2) // Slightly shiny
                    selectedModel!.model?.materials[materialIndex] = material
                }
            }
        }
    }
    
    func getRandomInt()->Int{
        return Int.random(in: 0...6)
    }
    
    func OpenDoors(rootEntity: Entity){
        if let firstEntity = rootEntity.findEntity(named: "selectedModel"){
            
        }
    }
    
    func reset(){
        animationPlaybackController = nil
        selectedModel = nil
        selectedModelIndex = 0
        selectedModelName = nil
        isChange = true
        colorsIndex = nil
        screen = .HomePage
    }
    
    
}
