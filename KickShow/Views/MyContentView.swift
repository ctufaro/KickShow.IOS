//
//  MyContentView.swift
//  KickShow
//
//  Created by Christopher Tufaro on 5/8/20.
//  Copyright © 2020 Personal. All rights reserved.
//
import SwiftUI
import Combine

struct Course: Decodable, Identifiable {
    let id: Int32
    let postTitle, postImage, userName, postMotion: String
}
class NetworkManager: ObservableObject {
    var didChange = PassthroughSubject<NetworkManager, Never>()
    
    @Published var courses = [Course]() {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        guard let url = URL(string: "https://kickshowapi.azurewebsites.net/api/userpost") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            
            let courses = try! JSONDecoder().decode([Course].self, from: data)
            DispatchQueue.main.async {
                self.courses = courses
            }
            print("completed fetching json")
            
        }.resume()
    }
}
struct MyContentView : View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List (networkManager.courses) { course in
                NavigationLink(destination: MyPlayerView(myVidUrl: course.postMotion)){
                    CourseRowView(course: course)
                }
                
            }.navigationBarTitle(Text("Gallery"))
        }
    }
}

struct CourseRowView: View {
    let course: Course
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ImageViewWidget(imageUrl:course.postImage)
            }
            
            VStack(alignment: .leading) {
                Image("avatar-chris")
                    .resizable()
                    .frame(width: 50.0, height: 50.0)
                    .clipShape(Circle())
                
                Text(course.userName)
                    .foregroundColor(.white)
                
                HStack {
                    Text(course.postTitle)
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

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    
    @Published var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(imageUrl: String) {
        // fetch image data and then call didChange
        guard let url = URL(string: imageUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.data = data
            }
            
        }.resume()
    }
}
struct ImageViewWidget: View {
    
    @ObservedObject var imageLoader: ImageLoader
    
    init(imageUrl: String) {
        imageLoader = ImageLoader(imageUrl: imageUrl)
    }
    
    var body: some View {
        Image(uiImage: (imageLoader.data.count == 0) ? UIImage(named: "spin")! : UIImage(data: imageLoader.data)!)
            .resizable()
            .aspectRatio(1,contentMode: .fit)
            .cornerRadius(10)
    }
    
    func resizeImage(image:UIImage) -> UIImage{
        let width = image.size.width
        let height = image.size.height
        UIGraphicsBeginImageContext(CGSize(width:width, height: height))
        image.draw(in:CGRect(x:0, y:0, width:width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

#if DEBUG
struct MyContentView_Previews : PreviewProvider {
    static var previews: some View {
        MyContentView()
    }
}
#endif

