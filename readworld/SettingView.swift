import SwiftUI

struct SettingView: View {
    @AppStorage("receiveNotifications") private var receiveNotifications: Bool = true
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @Environment(\.colorScheme) var colorScheme  // To get current color scheme
    
    var body: some View {
        Form {
            // 偏好设置部分
            Section(header: Text("Preferences")
                                .font(.system(size: 24, weight: .bold))  // 设置字体大小和加粗
                                .foregroundColor(.black)  // 设为黑色
                                .textCase(nil)
                                .padding(.bottom,40)) {
                Toggle(isOn: $receiveNotifications) {
                    Text("Receive Notifications")
                }
                
                // Dark Mode 切换按钮
                Toggle(isOn: $isDarkMode) {
                    Text("Dark Mode")
                }
                .onChange(of: isDarkMode) { newValue in
                    // 响应模式切换
                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = newValue ? .dark : .light
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
