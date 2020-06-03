//
//  SneakerRowView.swift
//  KickShow
//
//  Created by Christopher Tufaro on 3/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import SwiftUI

struct SneakerRowView: View {
    var sneaker: Sneaker
    
    var body: some View {
        ZStack {
            sneaker.image
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            VStack(alignment: .leading) {
                Image("avatar-chris")
                    .resizable()
                    .frame(width: 50.0, height: 50.0)
                    .clipShape(Circle())
                
                Text("@ctufaro")
                    .foregroundColor(.white)
                    
                HStack {
                    Text(sneaker.name)
                        .foregroundColor(.white)
                        .font(.title)
                    Spacer()
                }
                Spacer()
            }
            .padding()
            
        }
    }
}

struct SneakerRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SneakerRowView(sneaker: sneakerData[0])
            SneakerRowView(sneaker: sneakerData[1])
        }
        .previewLayout(.fixed(width: 500, height: 500))
    }
}
