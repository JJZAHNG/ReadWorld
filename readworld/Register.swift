import SwiftUI

struct RegisterView: View {
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        VStack {
            // 标题
            Text("Create Account")
                .font(.system(size: 28, weight: .bold))
                .padding(.top, 60)
            
            Spacer()
            
            // 手机号码输入框
            TextField("Phone Number", text: $phoneNumber)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .keyboardType(.phonePad)
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
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            .padding(.horizontal, 40)
            .padding(.top, 10)
            
            // 注册按钮
            Button(action: {
                // 注册操作
            }) {
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.top, 30)
            }
            
            Spacer()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
