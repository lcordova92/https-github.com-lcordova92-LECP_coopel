//
//  LoginResponse.swift
//  lecp
//
//  Created by Luis Eduardo Cordova Pichardo on 25/01/23.
//

import Foundation

struct LoginResponse: Codable{
    let success: Bool
    let status_code: Int?
    let status_message: String?
    let expires_at: String?
}
