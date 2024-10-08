//
//  Authentication.swift
//  readworld
//
//  Created by hahadong on 2024/9/26.
//

import Foundation
import SwiftUI

// 文件路径函数
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

// 保存用户数据到文件
func saveUserData(phoneNumber: String, password: String) {
    let userData = "\(phoneNumber):\(password)"
    let filename = getDocumentsDirectory().appendingPathComponent("UserData.txt")
    
    do {
        try userData.write(to: filename, atomically: true, encoding: .utf8)
        print("用户数据已保存")
    } catch {
        print("无法保存数据：\(error.localizedDescription)")
    }
}

// 验证用户数据
func verifyUserData(phoneNumber: String, password: String) -> Bool {
    let filename = getDocumentsDirectory().appendingPathComponent("UserData.txt")
    
    do {
        let savedData = try String(contentsOf: filename)
        let savedCredentials = savedData.split(separator: ":")
        
        if savedCredentials.count == 2 {
            let savedPhone = String(savedCredentials[0])
            let savedPassword = String(savedCredentials[1])
            
            return savedPhone == phoneNumber && savedPassword == password
        } else {
            return false
        }
    } catch {
        print("无法读取数据：\(error.localizedDescription)")
        return false
    }
}
