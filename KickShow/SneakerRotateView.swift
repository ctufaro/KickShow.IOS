//
//  SneakerRotateView.swift
//  KickShow
//
//  Created by Christopher Tufaro on 4/9/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import SwiftUI
import Foundation
import AVFoundation
import UIKit
import Photos
import ImageIO
import MobileCoreServices

struct SneakerRotateView: View {
    var shots: Array<UIImage>!
    @Binding var showPreview: Bool
    @State var duration = 0.5
    let close: () -> Void
    private let fpsToSkip : Int = 4
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                ImageAnimated(imageSize: CGSize(width: reader.size.width, height: reader.size.height+20), images: self.shots, duration: self.$duration)
                //.frame(width: reader.size.width, height: reader.size.height)
                    .edgesIgnoringSafeArea(.top)
                Controls(showPreview: self.$showPreview, duration: self.$duration, close: self.close, save:{self.saveAsVideo()})
            }.onAppear{
                print("Sneaker Rotate View")
                print(self.shots.count)
            }
        }
    }
    
    func saveAsVideo() {
        generateVideoUrl(complete: { (fileURL:URL) in
            self.saveVideo(url: fileURL, complete: {saved in
                print("animation video save complete")
                print("Saved: \(saved)")
                print("FileURL: \(fileURL)")
                RestAPI.UploadVideo(fileURL:fileURL, prevImage:self.shots[0])
            })
        })

        /*let options = NWImageSequencerOptions(outputSize: CGSize(width: shots[0].size.width,height: shots[0].size.height), secondsPerImage: 2.5)

        NWImageSequencer.createLocalMovieWithImages(images: self.shots, options: options,
                    onSuccess: { (movieUrl) -> Void in
                        print("movie successfully created at \(movieUrl)")
                        NWImageSequencer.saveMovieAtUrl(url: movieUrl, toAlbumNamed: "Example",
                            onSaveSuccess: { (asset) -> Void in
                                 print("Sucessfully saved video asset: \(asset)")
                            },
                            onError: { (error) -> Void in
                                 print("Error saving video: \(error)")
                            })
                    },
                    onError: { (error) -> Void in
                        print("error occured creating movie \(error)")
                    },
                    onProgress: { (progress) -> Void in
                        print("progress creating movie reported at \(progress)")
                    })
         */
    }
    
    func generateVideoUrl(complete: @escaping(_:URL)->()) {
        let settings = ImagesToVideoUtils.videoSettings(codec: AVVideoCodecType.jpeg.rawValue, width: (shots[0].cgImage?.width)!, height: (shots[0].cgImage?.height)!)
        let movieMaker = ImagesToVideoUtils(videoSettings: settings)
        //Override fps
        movieMaker.frameTime = CMTimeMake(value: 1, timescale: Int32(60 / (1 + self.fpsToSkip)))
        movieMaker.createMovieFrom(images: shots) { (fileURL:URL) in
            complete(fileURL)
        }
    }

    func saveVideo(url: URL, complete:@escaping(_:Bool)->()) {
        let library = PHPhotoLibrary.shared()
        library.performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
        }, completionHandler: {success, error in
            if success {
                print("VideoService: Video file have been saved successfully")
            } else {
                print("\n\nVideoService:  Error: failed to save video file.")
                print(error ?? "unknown")
            }
            complete(success)
        })
    }
}

struct SneakerRotateView_Previews: PreviewProvider {
    @State static var value = false
    @State static var duration = 0.0
    static var previews: some View {
        Group {
            Controls(showPreview: $value, duration: $duration, close: {}, save:{print("saved")}).previewDevice("iPhone 11")
            //Controls(showPreview: $value, duration: $duration, close: {}).previewDevice("iPhone 7")
            //Controls(showPreview: $value, duration: $duration, close: {}).previewDevice("iPhone SE")
        }
    }
}

struct ImageAnimated: UIViewRepresentable {
    let imageSize: CGSize
    let images: [UIImage]
    @Binding var duration: Double
    
    func makeUIView(context: Self.Context) -> UIImageView {
        //let containerView = UIView(frame: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))

        let animationImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))

        animationImageView.clipsToBounds = true
        animationImageView.autoresizesSubviews = true
        animationImageView.contentMode = UIView.ContentMode.scaleAspectFill
        animationImageView.image = UIImage.animatedImage(with: images, duration: duration)
        animationImageView.tag = 0xDEADBEEF
        //containerView.addSubview(animationImageView)
        return animationImageView
    }

    func updateUIView(_ uiView: UIImageView, context: UIViewRepresentableContext<ImageAnimated>) {
        uiView.image = UIImage.animatedImage(with: images, duration: duration)
        //print("Duration: \(duration)")
    }

}

struct Controls: View {
    @Binding var showPreview: Bool
    @Binding var duration: Double
    let close: () -> Void
    let save: () -> Void
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "trash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(10)
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        self.showPreview = false
                        self.close()
                }
                Spacer()
                Button(action: {
                    //print(self.duration)
                    self.save()
                    self.showPreview = false
                    self.close()
                }) {
                    Text("Post")
                }.padding()
            }
            Spacer()
            Slider(value: $duration, in:0.1...1, step: 0.1).padding()
        }
    }
}
