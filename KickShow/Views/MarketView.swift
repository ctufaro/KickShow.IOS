//
//  MarketView.swift
//  KickShow
//
//  Created by Christopher Tufaro on 5/28/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct MarketView: View {
    var body: some View {
        ItemsView()
    }
}

struct ItemsView: View {
    var body: some View {
        WaterfallGrid(sneakerData, id: \.self) { sneaker in
            CardView(itemImage: sneaker.image, itemTxt: "$50")
        }.gridStyle(
            spacing: 4
        )
    }
}

struct CardView: View {
    var itemImage:Image
    var itemTxt:String
    var body: some View {
        ZStack {
            itemImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                //.frame(height: 200)
            VStack {
                Spacer()
                Button(action: {
                    //self.authSettings.loggedIn = true
                }) {
                    Text(itemTxt)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(width:70)
                    
                }
                .padding(10)
                .background(Color.white)
                .cornerRadius(.infinity)
            }.frame(height:185)
            
        }
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView()
        //CardView(itemImage:Image("avatar-chris"), itemTxt: "$80")
    }
}
