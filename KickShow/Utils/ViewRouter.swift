//
//  ViewRouter.swift
//  NavigateInSwiftUIComplete
//
//  Created by Andreas Schultz on 19.07.19.
//  Copyright © 2019 Andreas Schultz. All rights reserved.
//
import Foundation
import Combine
import SwiftUI

class ViewRouter: ObservableObject {
    
    //@Published var showToolBar : Bool = false{
        //didSet{
            //print("Show toolbar?: \(showToolBar)")
        //}
    //}
    
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentView: String = "home" {
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
    
    var showToolBar : Bool = true{
        didSet{
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
    
    
    
    func toggleView(){
        showToolBar = !showToolBar
    }
}
