//File: ContentView.swift


import SwiftUI

struct ContentView: View {
        
    @ObservedObject var viewRouter = ViewRouter()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if self.viewRouter.currentView == "home" {
                    //LogoView(width: geometry.size.width)
                    //SneakerListView()
                    MyContentView()
                } else if self.viewRouter.currentView == "profile" {
                    //LogoView(width: geometry.size.width)
                    Spacer()
                    ProfileView()
                } else if self.viewRouter.currentView == "camera" {
                    CameraView(viewRouter: self.viewRouter)
                        .transition(.scale)
                }
                if self.viewRouter.currentView != "camera" {
                    Spacer()
                    ZStack {
                        HStack {
                            ToolbarButton(viewRouter: self.viewRouter, title: "home", icon: "house")
                                .frame(width: geometry.size.width/3, height: 75)
                            
                            CircleButton(viewRouter: self.viewRouter, title: "camera", icon: "camera.circle.fill")
                                .offset(y: -geometry.size.height/10/2)
                            
                            ToolbarButton(viewRouter: self.viewRouter, title: "profile", icon: "person.fill")
                                .frame(width: geometry.size.width/3, height: 75)
                            
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/10)
                        .background(Color.white.shadow(radius: 2))
                    }                    
                }
            }
        }
        //.edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
                .frame(width: 75, height: 75)
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 75)
                .foregroundColor(.blue)
                .onTapGesture {
                    self.viewRouter.currentView = self.title
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
