import SwiftUI

struct LoginView: View {
    @State private var identifier: String = ""  // 允许输入昵称或手机号
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var loginSuccess: Bool = false
    @State private var loginFailed: Bool = false
    @State private var isLoggedIn: Bool = false  // 用于控制跳转
    @AppStorage("userNickname") var savedNickname: String = ""  // 使用 AppStorage 来保存昵称
    
    var body: some View {
        NavigationView {
            VStack {
                // 标题 Logo
                Text("READWORLD")
                    .font(.system(size: 36, weight: .bold))
                    .padding(.top, 60)
                
                Spacer()
                
                // 用户名或手机号输入框
                TextField("Nickname or Phone Number", text: $identifier)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 40)
                    .padding(.top, 20)
                
                // 密码输入框
                HStack {
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: self.isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 40)
                .padding(.top, 10)
                
                // 登录按钮
                NavigationLink(destination: HomeViewWithTabBar()
                    .navigationBarBackButtonHidden(true), isActive: $isLoggedIn) {
                    EmptyView()  // 用于触发跳转的空视图
                }
                
                Button(action: {
                    if verifyUserData(identifier: identifier, password: password) {
                        loginSuccess = true
                        loginFailed = false
                        
                        // 保存用户的昵称
                        if let nickname = getNickname(for: identifier) {
                            savedNickname = nickname
                        }
                        
                        isLoggedIn = true  // 登录成功后跳转
                    } else {
                        loginFailed = true
                        loginSuccess = false
                    }
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.top, 30)
                }
                
                // 登录反馈
                if loginSuccess {
                    Text("Login Successful")
                        .foregroundColor(.green)
                        .padding(.top, 20)
                }
                
                if loginFailed {
                    Text("Login Failed: Incorrect Nickname, Phone Number or Password")
                        .foregroundColor(.red)
                        .padding(.top, 20)
                }
                
                Spacer()
                
                // 注册提示
                HStack {
                    Text("Don’t have an account?")
                        .foregroundColor(.gray)
                    NavigationLink(destination: RegisterView()) {
                        Text("Register")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 40)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
    
    // 从 identifier 获取昵称
    func getNickname(for identifier: String) -> String? {
        let savedNickname = UserDefaults.standard.string(forKey: "userNickname")
        let savedPhoneNumber = UserDefaults.standard.string(forKey: "userPhoneNumber")
        
        if identifier == savedNickname || identifier == savedPhoneNumber {
            return savedNickname
        } else {
            return nil
        }
    }
    
    // 验证用户数据（通过昵称或手机号）
    func verifyUserData(identifier: String, password: String) -> Bool {
        let savedNickname = UserDefaults.standard.string(forKey: "userNickname")
        let savedPhoneNumber = UserDefaults.standard.string(forKey: "userPhoneNumber")
        let savedPassword = UserDefaults.standard.string(forKey: "userPassword")
        
        // 验证：输入的 identifier 是否匹配已保存的昵称或手机号，同时验证密码
        if (identifier == savedNickname || identifier == savedPhoneNumber), password == savedPassword {
            return true
        } else {
            return false
        }
    }
}

#Preview {
    LoginView()
}
