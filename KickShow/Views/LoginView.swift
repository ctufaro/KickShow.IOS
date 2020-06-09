//
//  LoginView.swift
//  KickShow
//
//  Created by Christopher Tufaro on 6/2/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authSettings: AuthSettings
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Image("black-background")
                .resizable()
                .frame(width: geometry.size.width, height: geometry.size.height)
                
                VStack {
                    Image("logo-white")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width/1.7)
                    Spacer()
                }.offset(y:80)

                VStack{
                    Spacer()
                    
                    TextBoxView(email:self.$email, width: geometry.size.width, placeTxt: "Email", isSecure: false)
                    
                    TextBoxView(email:self.$password, width: geometry.size.width, placeTxt: "Password", isSecure: true)
                    
                    Button(action: {
                        self.authSettings.loggedIn = true
                    }) {
                        Text("Sign In")
                            .padding()
                            .foregroundColor(Color.white)
                    }
                    .background(Capsule()
                    .stroke(lineWidth: 2)
                    .frame(width:geometry.size.width/1.6)
                    .foregroundColor(Color.white))
                    .padding(30)
                    
                    Spacer()
                    
                    Text("Need an account?")
                    .foregroundColor(Color.white)
                        .padding(40)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct TextBoxView: View {
    @Binding var email:String
    var width:CGFloat
    var placeTxt:String
    var isSecure:Bool
    
    var body: some View {
        FloatingLabelTextField(self.$email, placeholder: placeTxt, editingChanged: { (isChanged) in
            
        }) {
            
        }
        .isSecureTextEntry(isSecure)
        .lineColor(.white)
        .titleColor(.white)
        .selectedLineColor(.white)
        .selectedTextColor(.white)
        .selectedTitleColor(.white)
        .textColor(.white)
        .placeholderColor(.white)
        .frame(width: width/1.5, height: 70)

    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
