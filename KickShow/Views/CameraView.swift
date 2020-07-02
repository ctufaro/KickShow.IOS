//
//  AVCameraView.swift
//
//  Created by Christopher Tufaro on 3/28/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import SwiftUI

struct CameraView: View {
    
    @ObservedObject var viewRouter = ViewRouter()
    @ObservedObject private var avFoundationVM = AVFoundationVM()
    @State private var count = 0
    @State private var showPreview = false
    
    var body: some View {
        GeometryReader { reader in
            VStack{
                ZStack {
                    if self.showPreview == false {
                        CALayerView(caLayer: self.avFoundationVM.previewLayer).edgesIgnoringSafeArea(.top)
                        
                        //PrevFrame(image: self.avFoundationVM.shots, index: self.$count, width: reader.size.width, height: reader.size.height)
                        
                        Counter(count: self.count)
                        
                        CameraControls(goHome:{self.viewRouter.currentView = "home"}, avFoundationVM: self.avFoundationVM, showPreview: self.$showPreview, count: self.$count)
                    } else {
                        ShowPreviewView(shots:self.avFoundationVM.shots, showPreview:self.$showPreview, close:{
                            self.avFoundationVM.shots = []
                            self.count = 0
                            self.avFoundationVM.image = nil
                        })
                    }
                }.onAppear {
                        self.avFoundationVM.startSession()
                }.onDisappear {
                        self.avFoundationVM.endSession()
                }
            }
        }
    }
}

struct PrevFrame: View {
    var image: [UIImage]?
    //var index: Int
    //@Binding var showPreview: Bool
    @Binding var index: Int
    var width : CGFloat
    var height : CGFloat
    var body: some View {
        VStack {
            if image!.count > 0 {
            Image(uiImage: image![image!.count-1])
                .resizable()
                //.aspectRatio(1, contentMode: .fit)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                .opacity(index > 0 ? 0.1 : 0)
            }
        }.edgesIgnoringSafeArea(.top)
    }
}


struct Counter: View {
    var count: Int
    var body: some View {
        Text(String(self.count))
        .font(.system(size:300))
        .opacity(self.count > 0 ? 0.1 : 0)
        .foregroundColor(.white)
        //.animation(.easeInOut(duration:0.5))
        .transition(.asymmetric(insertion: .opacity, removal: .scale))
    }
}

struct CameraControls: View {
    let goHome: () -> Void
    let avFoundationVM : AVFoundationVM
    @Binding var showPreview: Bool
    @Binding var count: Int
    
    var body: some View{
        VStack {
            HStack {
                Image(systemName: "xmark.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(10)
                .frame(width: 55, height: 55)
                .onTapGesture {
                    self.goHome()
                }
                ZStack {
                    Text("Snap each frame with the button below")
                        .font(.callout)
                        .padding(8)
                        .foregroundColor(.white)
                }.background(Color.black)
                .opacity(0.5)
                //.cornerRadius(10.0)
                //.padding(6)
                Spacer()
            }
            Spacer()
            HStack {
                if self.avFoundationVM.image !== nil {
                    Image(uiImage: self.avFoundationVM.image!)
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 70,height:70)
                } else {
                    Image(systemName:"square")
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 70,height:70)
                    .opacity(0)
                }
                Spacer()
                Button(action: {
                    self.avFoundationVM.takePhoto()
                    self.count+=1
                }) {
                    Image(systemName: "camera.circle.fill")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 70, height: 70)
                }
                Spacer()
                Button(action:{
                    if(self.count > 0){
                        self.showPreview = true
                    }
                }) {
                    //Image("spin")
                    Text("Stitch")
                    .padding(10)
                    .frame(width: 80)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .font(.body)
                }.opacity(self.count > 0 ? 1:0)
            }.padding(10)
        }.padding(.bottom, 10.0)
    }
}

struct CameraView_Previews: PreviewProvider {
    @State static var showPreview = false
    @State static var count = 0
    static var previews: some View {
        Group{
            CameraControls(goHome:{}, avFoundationVM: AVFoundationVM(), showPreview: $showPreview, count: $count).previewDevice("iPhone 11")
            CameraControls(goHome:{}, avFoundationVM: AVFoundationVM(), showPreview: $showPreview, count: $count).previewDevice("iPhone 7")
            CameraControls(goHome:{}, avFoundationVM: AVFoundationVM(), showPreview: $showPreview, count: $count).previewDevice("iPhone SE")
        }
    }
}


