//
//  CarView.swift
//  Omnia
//
//  Created by Prathamesh Bhuravane on 14/12/24.
//

import SwiftUI
import RealityKit

struct CarView: View {
    @State var initialPosition: SIMD3<Float>? = nil
    @State var initialScale: SIMD3<Float>? = nil
    @ObservedObject var appstate: AppState
    @State var prevRotation : simd_quatf?
    var body: some View {
        
        
        RealityView { content  in
            print()
            let rootEntity = Entity()
            rootEntity.position = .init(0, 0, 0)
            rootEntity.name = "rootEntity"
            content.add(rootEntity)
        }
        update: {update  in
//            if appstate.isAllModelsLoaded, let firstEntity = update.entities.first {
//                Task {
//                    
////                    appstate.loadFirstModelFunc()
//                    appstate.addChangeCar(rootEntity: firstEntity, index: 1)// appstate.addfirst(rootEntity: firstEntity)
//                    for child in firstEntity.children{
//                        print("firstEntity.children.first?.name :",child.name)
//                    }
//                }
//            }
            
            if appstate.isAllModelsLoaded && appstate.isChange {
                if let firstEntity = update.entities.first {
                    Task{
                        appstate.isChangeFunc()
                        appstate.addChangeCar(rootEntity: firstEntity, index: appstate.selectedModelIndex)
                        
                    }
                }
            }
            
        }
        .gesture(translationGesture)
        .gesture(rotationGesture)
    }
    
    
    
    var translationGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                let rootEntity = value.entity
                if initialPosition == nil {
                    initialPosition = rootEntity.position
                }
                let movement = value.convert(value.translation3D, from: .global, to: .scene)
                rootEntity.position = (initialPosition ?? .zero) + movement.grounded
            }
            .onEnded { _ in
                initialPosition = nil
            }
    }
    
    var scaleGesture: some Gesture {
        MagnifyGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                let rootEntity = value.entity
                if initialScale == nil {
                    initialScale = rootEntity.scale
                }
                let scaleRate: Float = 1.0
                rootEntity.scale = (initialScale ?? .init(repeating: scaleRate)) * Float(value.gestureValue.magnification)
            }
            .onEnded { _ in
                initialScale = nil
            }
    }
    
    
    var rotationGesture: some Gesture{
        RotateGesture3D(constrainedToAxis: .y)
            .onChanged({ value in
                let object = appstate.selectedModel
                
                let rotation = Float(value.rotation.eulerAngles(order: .xyz).angles.y)//Float(value.rotation.angle.radians)
                print(value.rotation.angle.degrees,"<<<<- Degrees \(value.rotation.eulerAngles(order: .xyz).angles.y) radians ->>>>",value.rotation.angle.radians)
                object?.orientation = (prevRotation ?? simd_quatf(angle: 0, axis: [0,0,0]))  * simd_quatf(angle: rotation, axis: [0,1,0])
                
            })
        
            .onEnded({ value in
                prevRotation =  appstate.selectedModel?.transform.rotation
            })
    }
    
}
