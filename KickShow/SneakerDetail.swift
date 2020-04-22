//
//  SneakerDetail.swift
//  KickShow
//
//  Created by Christopher Tufaro on 3/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import SwiftUI

struct SneakerDetail: View {
    var sneaker: Sneaker
    
    var body: some View {
        Text(sneaker.name)
    }
}

struct SneakerDetail_Previews: PreviewProvider {
    static var previews: some View {
        SneakerDetail(sneaker: sneakerData[0])
    }
}
