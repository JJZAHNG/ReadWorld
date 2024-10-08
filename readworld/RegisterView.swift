import SwiftUI

struct RegisterView: View {
    @State private var nickname: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var registrationSuccess: Bool = false
    @Environment(\.presentationMode) var presentationMode // 用于控制视图返回
    
    var body: some View {
        VStack {
            Text("Create Account")
                .font(.system(size: 28, weight: .bold))
                .padding(.top, 60)
            
            Spacer()
            
            // 昵称输入框
            TextField("Nickname", text: $nickname)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .padding(.horizontal, 40)
                .padding(.top, 20)
            
            // 手机号码输入框
            TextField("Phone Number", text: $phoneNumber)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .keyboardType(.phonePad)
                .padding(.horizontal, 40)
                .padding(.top, 10)
            
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
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            .padding(.horizontal, 40)
            .padding(.top, 10)
            
            // 注册按钮
            Button(action: {
                saveUserData(nickname: nickname, phoneNumber: phoneNumber, password: password)
                registrationSuccess = true
                
                // 模拟延迟1秒后返回上一个页面
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    presentationMode.wrappedValue.dismiss() // 返回到之前的页面
                }
                
            }) {
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.top, 30)
            }
            
            // 注册成功提示
            if registrationSuccess {
                Text("Registration Successful")
                    .foregroundColor(.green)
                    .padding(.top, 20)
            }
            
            Spacer()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    // 保存用户数据
    func saveUserData(nickname: String, phoneNumber: String, password: String) {
        UserDefaults.standard.set(nickname, forKey: "userNickname")
        UserDefaults.standard.set(phoneNumber, forKey: "userPhoneNumber")
        UserDefaults.standard.set(password, forKey: "userPassword")
        print("User data saved: \(nickname), \(phoneNumber), \(password)")
    }
}
