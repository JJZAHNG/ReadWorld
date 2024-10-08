//
//  Home.swift
//  readworld
//
//  Created by hahadong on 2024/9/17.
//

import SwiftUI

struct Home: View {
    private var username = "John Doe"
    @State private var progress:CGFloat=0.4
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading){
                    Text("Hello!")
                        .font(.system(size: 25))
                        .foregroundColor(.gray)
                    Text(username)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                Image("avatar1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay{
                        Circle().stroke(.white,lineWidth: 4)
                    }
                    .shadow(radius: 7)
            }
            .padding()
            Text("Recommended For You")
                .font(.title2)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack  {
                    Image("book1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .cornerRadius(10)
                        .overlay{
                            Rectangle().stroke(.gray,lineWidth: 1)
                                .cornerRadius(10)
                        }
                    Image("book1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .cornerRadius(10)
                        .overlay{
                            Rectangle().stroke(.gray,lineWidth: 1)
                                .cornerRadius(10)
                        }
                    Image("book1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .cornerRadius(10)
                        .overlay{
                            Rectangle().stroke(.gray,lineWidth: 1)
                                .cornerRadius(10)
                        }
                    Image("book1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .cornerRadius(10)
                        .overlay{
                            Rectangle().stroke(.gray,lineWidth: 1)
                                .cornerRadius(10)
                        }
                }
            }
            .padding()
            Text("Your Progress")
                .font(.title2)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 328, height: 123)
                            .cornerRadius(10)
                        HStack {
                            Image("book1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70)
                                .cornerRadius(10)
                                .overlay{
                                    Rectangle().stroke(.gray,lineWidth: 1)
                                        .cornerRadius(10)
                                }
                            VStack (alignment: .leading){
                                Text("Charlotte's Web")
                                    .font(.title2)
                                ZStack (alignment: .leading){
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.gray.opacity(0.3))
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(LinearGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                                        .frame(width:200*progress )
                                        .mask(RoundedRectangle(cornerRadius: 10))
                                }
                                .frame(width: 200,height: 20)
                                Text("40% completed").foregroundColor(.gray)
                                
                                
                            }
                            .padding()
                        }
                        .padding()
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 328, height: 123)
                            .cornerRadius(10)
                        HStack {
                            Image("book2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70)
                                .cornerRadius(10)
                                .overlay{
                                    Rectangle().stroke(.gray,lineWidth: 1)
                                        .cornerRadius(10)
                                }
                            VStack (alignment: .leading){
                                Text("Charlotte's Web")
                                    .font(.title2)
                                ZStack (alignment: .leading){
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.gray.opacity(0.3))
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(LinearGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                                        .frame(width:200*0.9 )
                                        .mask(RoundedRectangle(cornerRadius: 10))
                                }
                                .frame(width: 200,height: 20)
                                Text("30% completed").foregroundColor(.gray)
                            }
                            .padding()
                        }
                        .padding()
                    }
                }
                
            }
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 107, height: 64)
                        .cornerRadius(10)
                    VStack {
                        Image(systemName: "bookmark.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text("Bookmarks")
                    }
                    .padding()
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 107, height: 64)
                        .cornerRadius(10)
                    VStack {
                        Image(systemName: "person.badge.clock.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text("Reading Time")
                    }
                    .padding()
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 107, height: 64)
                        .cornerRadius(10)
                    VStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text("Favorites")
                    }
                    .padding()
                }
            }
            
            Spacer()
            TabView {
                Text("Home View")
                    .opacity(0)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                Text("Favorites View")
                    .opacity(0)
                    .tabItem {
                        Label("Bookstore", systemImage: "books.vertical")
                    }
                Text("Settings View")
                    .opacity(0)
                    .tabItem {
                        Label("Bookshelf", systemImage: "book")
                    }
                Text("Settings View")
                    .opacity(0)
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
            }
            .frame(height: 50)
            
        }
        .background(Color(uiColor: UIColor (red: 0xF6/255, green: 0xF6/255, blue: 0xF6/255, alpha: 1)))
        
        
        
        
    }
    
}

#Preview {
    Home()
}
