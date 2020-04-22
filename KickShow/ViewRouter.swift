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
    
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentView: String = "home" {
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
}
