//
//  ProfileView.swift
//  KickShow
//
//  Created by Christopher Tufaro on 3/9/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct ProfileView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Image("white-background")
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.height/2.2)
                    VStack {
                        VStack {
                            Image("avatar-chris")
                                .resizable()
                                .frame(width: 125.0, height: 125.0)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.white, lineWidth: 4))
                                //.shadow(radius: 10)
                            Text("Chris Tufaro")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .font(.system(size: 25))
                            Text("East Northport NY")
                                .foregroundColor(Color.white)
                        }.offset(y:10)
                        HStack {
                            VStack {
                                Text("Kicks").foregroundColor(Color.white)
                                Text("10").foregroundColor(Color.white)
                            }.padding()
                            Spacer()
                            VStack {
                                Text("Sold").foregroundColor(Color.white)
                                Text("20").foregroundColor(Color.white)
                            }.padding()
                            Spacer()
                            VStack {
                                Text("Followers").foregroundColor(Color.white)
                                Text("30").foregroundColor(Color.white)
                            }.padding()
                        }.offset(y:10)
                    }
                }
                WaterfallView().offset(y:-4)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct WaterfallView: View {
    var body: some View {
        WaterfallGrid(sneakerData, id: \.self) { sneaker in
            sneaker.image
                .resizable()
                .aspectRatio(contentMode: .fit)
        }.gridStyle(
            spacing: 4
        )
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
        //WaterfallView()
    }
}

