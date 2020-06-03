//File: ContentView.swift


import SwiftUI

struct HomeView: View {
        
    @ObservedObject var viewRouter = ViewRouter()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if self.viewRouter.currentView == "home" {
                    ZStack {
                        GalleryView(viewRouter: self.viewRouter)
                        VStack {
                            LogoView(width:geometry.size.width)
                            Spacer()
                        }
                    }
                } else if self.viewRouter.currentView == "profile" {
                    Spacer()
                    ProfileView()
                } else if self.viewRouter.currentView == "hot" {
                    Spacer()
                    HotView()
                } else if self.viewRouter.currentView == "market" {
                    Spacer()
                    MarketView()
                } else if self.viewRouter.currentView == "camera" {
                    CameraView(viewRouter: self.viewRouter)
                        .transition(.scale)
                }
                if self.viewRouter.showToolBar {
                    BottomNAVBar(viewRouter: self.viewRouter, width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
        //.statusBar(hidden: true)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct ToolbarButton: View {
    @ObservedObject var viewRouter = ViewRouter()
    let title: String
    let icon: String
    var body: some View {
        Image(systemName: icon)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .padding(20)
        .foregroundColor(self.viewRouter.currentView == title ? .black : .gray)
        .onTapGesture {
            self.viewRouter.currentView = self.title
        }
    }
}

struct CircleButton: View {
    @ObservedObject var viewRouter = ViewRouter()
    let title: String
    let icon: String
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color.white)
                .frame(width: 65, height: 65)
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 65, height: 65)
                .foregroundColor(.blue)
                .onTapGesture {
                    self.viewRouter.currentView = self.title
                    self.viewRouter.showToolBar = false //this is the camera
                }
            }
        }
    }

struct LogoView: View {
    let width: CGFloat
    var body: some View{
        HStack{
            Image("logo-black")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width:self.width/3)
        }
    }
}

struct BottomNAVBar : View{
    @ObservedObject var viewRouter:ViewRouter
    var width:CGFloat
    var height:CGFloat
    var body: some View{
        VStack {
            Spacer()
            HStack {
                ToolbarButton(viewRouter: self.viewRouter, title: "home", icon: "house")
                    .frame(width: self.width/5.5, height: 75)
                
                ToolbarButton(viewRouter: self.viewRouter, title: "profile", icon: "person.fill")
                    .frame(width: self.width/5.5, height: 75)
                
                CircleButton(viewRouter: self.viewRouter, title: "camera", icon: "camera.circle.fill")
                    .offset(y: -self.height/10/2)
                
                ToolbarButton(viewRouter: self.viewRouter, title: "hot", icon: "flame.fill")
                    .frame(width: self.width/5.5, height: 75)
                
                ToolbarButton(viewRouter: self.viewRouter, title: "market", icon: "dollarsign.circle")
                    .frame(width: self.width/5.5, height: 75)
                
            }
            .frame(width: self.width, height: self.height/10)
            .background(Color.white.shadow(radius: 2))
        }
    }
}
