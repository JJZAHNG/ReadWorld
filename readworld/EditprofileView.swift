import SwiftUI

struct EditProfileView: View {
    @State private var username: String = "John Doe"
    @State private var receiveNotifications: Bool = true
    @State private var darkMode: Bool = false
    @Environment(\.colorScheme) var colorScheme  // 获取当前的颜色模式
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false // 用于保存用户偏好的深色模式设置
    
    @AppStorage("userNickname") var nickname: String = ""
    @State private var email: String  // Email will be initialized dynamically

    // Initialize email using the nickname when the view is first loaded
    init() {
        _email = State(initialValue: "\(UserDefaults.standard.string(forKey: "userNickname")?.lowercased() ?? "john.doe")@gmail.com")
    }
    
    var body: some View {
        Form {
            // 个人信息部分
            Section(header: Text("Personal Information")
                        .font(.system(size: 24, weight: .bold))  // 设置字体大小和加粗
                        .foregroundColor(.black)  // 设为黑色
                        .textCase(nil)
                        .padding(.bottom,40)
                        
            ) {
                TextField("Name", text: $nickname)
                    .textContentType(.name)
                
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
            }
        }
//        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}

