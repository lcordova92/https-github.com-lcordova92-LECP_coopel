//
//  getTokenResponse.swift
//  lecp
//
//  Created by Luis Eduardo Cordova Pichardo on 25/01/23.
//

import Foundation

struct getTokenResponse: Codable{
    let success: Bool
    let expires_at: String
    let request_token: String
}
