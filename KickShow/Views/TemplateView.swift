//
//  TemplateView.swift
//  KickShow
//
//  Created by Christopher Tufaro on 4/9/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import SwiftUI

struct TemplateView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TemplateView_Previews: PreviewProvider {
    @State static var text = ""
    @State static var fontName = "Courier"
    @State static var fontSize = CGFloat(100.0)
    static var previews: some View {
        TextView(text:$text,fontName:$fontName,fontSize: $fontSize)
        .edgesIgnoringSafeArea(.top)
    }
}
