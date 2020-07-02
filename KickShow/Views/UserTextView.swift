//
//  UserTextView.swift
//  KickShow
//
//  Created by Christopher Tufaro on 7/2/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import SwiftUI

struct UserTextView: View {
    @Binding var text: String
    @Binding var fontName: String
    @Binding var fontSize: CGFloat
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(text)
                .font(.custom(fontName, size: fontSize))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                .gesture(self.drag)
            Spacer()
        }
    }
}

struct UserTextView_Previews: PreviewProvider {
    @State static var text = "Hi there"
    @State static var fontName = "Courier"
    @State static var fontSize: CGFloat = 50.0
    
    static var previews: some View {
        UserTextView(text: self.$text, fontName: self.$fontName, fontSize: self.$fontSize)
    }
}
