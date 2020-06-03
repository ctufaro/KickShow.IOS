//
//  ContentView.swift
//  KickShow
//
//  Created by Christopher Tufaro on 6/3/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var isLoggedIn:Bool = false
    var body: some View {
        if(isLoggedIn){
            return AnyView(HomeView())
        } else {
            return AnyView(LoginView())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
