import SwiftUI

import SwiftUI

struct ProfileView: View {
    @AppStorage("userNickname") var savedNickname: String = ""  // 使用 AppStorage 来保存昵称
    
    var body: some View {
        VStack {
            // 顶部的用户信息部分
            VStack {
                // 用户头像
                Image("avatar1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .clipShape(Circle())
                    .padding(.trailing)
                    .shadow(radius: 1)
                
                // 用户姓名和角色描述
                Text(savedNickname)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                Text("Reading Enthusiast")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 40)
            .background(Color.blue)
            .foregroundColor(.white)
            
            // 成就部分
            VStack(alignment: .leading) {
                Text("Achievement")
                    .font(.headline)
                    .padding(.leading)
                    .padding(.bottom, 10)
                
                HStack {
                    AchievementCard(imageName: "crown.fill", title: "Top Reader", color: .yellow)
                    AchievementCard(imageName: "trophy.fill", title: "BK Master", color: .yellow)
                    AchievementCard(imageName: "moon.fill", title: "Night Owl", color: .yellow)
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
            .padding(.top, 20)
            
            // 功能选项部分
            VStack(alignment: .leading, spacing: 20) {
                // 用NavigationLink包裹 "Edit Profile"
                NavigationLink(destination: EditProfileView()) {
                    ProfileOptionView(iconName: "pencil", title: "Profile")
                }
                
                // 用NavigationLink包裹 "Reading History"
                NavigationLink(destination: ReadhistoryView()) {
                    ProfileOptionView(iconName: "book.fill", title: "Reading History")
                }
                
                // 用NavigationLink包裹 "Settings"
                NavigationLink(destination: SettingView()) {
                    ProfileOptionView(iconName: "gearshape.fill", title: "Settings")
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}


// 成就卡片组件
struct AchievementCard: View {
    var imageName: String
    var title: String
    var color: Color
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
        .frame(width: 100, height: 100)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

// 功能选项组件
struct ProfileOptionView: View {
    var iconName: String
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.gray)
                .frame(width: 24, height: 24)
            
            Text(title)
                .font(.headline)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .padding(.bottom, 10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct ProfileViewWithTabBar: View {
    var body: some View {
        NavigationView {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                BookStoreView()
                    .tabItem {
                        Image(systemName: "book.fill")
                        Text("Bookstore")
                    }
                
                BookshelfView()
                    .tabItem {
                        Image(systemName: "books.vertical.fill")
                        Text("Bookshelf")
                    }
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
            .accentColor(.blue)
        } // 设置选中时的颜色
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViewWithTabBar()
    }
}

