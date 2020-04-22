//
//  SneakerListView.swift
//  KickShow
//
//  Created by Christopher Tufaro on 3/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import SwiftUI

struct SneakerListView: View {
    var body: some View {
        NavigationView {
            List(sneakerData) { sneaker in
                ZStack {
                    NavigationLink(destination: SneakerDetail(sneaker: sneaker)) {
                        SneakerRowView(sneaker: sneaker)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitle("Gallery", displayMode: .inline)
        }
        //.padding(.top)
    }
}


struct SneakerListView_Previews: PreviewProvider {
    static var previews: some View {
        SneakerListView()
    }
}

