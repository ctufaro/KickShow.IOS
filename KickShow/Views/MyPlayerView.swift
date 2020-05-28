//
//  PlayerView.swift
//  KickShow
//
//  Created by Christopher Tufaro on 5/13/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import SwiftUI
import UIKit
import AVFoundation

struct MyPlayerView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var viewRouter:ViewRouter
    var myVidUrl: String
    var body: some View {
        ZStack {
            PlayerView(vidUrl: myVidUrl)
                .statusBar(hidden: true)
                .edgesIgnoringSafeArea(.all)
                .onAppear(){
                    self.viewRouter.toggleView()
            }
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "heart.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 55, height: 55)
                        .foregroundColor(.white)
                        .padding()
                    Image(systemName: "hand.thumbsup")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 55, height: 55)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "arrowshape.turn.up.left.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 35, height: 35)
            .foregroundColor(.white)
            
        })
    }
}

struct MyPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MyPlayerView(viewRouter:ViewRouter(), myVidUrl: "https://tufarostorage.blob.core.windows.net/kickspins/display.mp4")
        //Text("Fix this")
    }
}

struct PlayerView: UIViewRepresentable {
    let vidUrl:String
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }
    
    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(vidUrl: vidUrl)
    }
}

class PlayerUIView: UIView {
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: NSObject?
    
    init(vidUrl:String) {
        super.init(frame: .zero)
        let url = URL(string: vidUrl)!
        let playerItem = AVPlayerItem(url: url)
        let player = AVQueuePlayer(items: [playerItem])
        let affineTransform = CGAffineTransform(rotationAngle: (.pi*90)/180.0)
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        playerLayer.setAffineTransform(affineTransform)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        player.play()
        playerLayer.player = player
        layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
}
