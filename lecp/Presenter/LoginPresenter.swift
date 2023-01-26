//
//  Presenter.swift
//  lecp
//
//  Created by Luis Eduardo Cordova Pichardo on 21/01/23.
//

import Foundation
import UIKit

// https://api.themoviedb.org/3/movie/550?api_key=385ffc860064978de0a4bdc0eb37836e

protocol UserPresenterDelegate: AnyObject{
    func presentLogin(responseLogin: LoginResponse)
    func getnewSessiontoken(sessionToken: getTokenResponse)
}

typealias PresenterDelegate = UserPresenterDelegate & UIViewController

class UserPresenter{
    
    weak var delegate: PresenterDelegate?
    
    public func login(username: String, password: String){
        
        let parameters = ["username": username, "password": password, "request_token": UserDefaults.standard.string(forKey: "REQUEST_TOKEN")]
        
        let url = URL(string: "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=385ffc860064978de0a4bdc0eb37836e")!

        let session = URLSession.shared

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
    
        let task = session.dataTask(with: request, completionHandler: { [weak self] data, _, error in
                guard let data = data, error == nil else{
                    return
                }
                do{
                    let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                    self?.delegate?.presentLogin(responseLogin: response)
                }catch{
                    print(error)
                }
            })
            task.resume()
    }
    
    public func getnewSessiontoken(apiKey: String){
        
        //let parameters = ["api_key": apiKey]
        
        
        let url = URL(string: "https://api.themoviedb.org/3/authentication/token/new?api_key=\(apiKey)")!

        let session = URLSession.shared

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        /*do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }*/
/*
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")*/
    
        let task = session.dataTask(with: request, completionHandler: { [weak self] data, _, error in
                guard let data = data, error == nil else{
                    return
                }
                do{
                    let response = try JSONDecoder().decode(getTokenResponse.self, from: data)
                    self?.delegate?.getnewSessiontoken(sessionToken: response)
                }catch{
                    print(error)
                }
            })
            task.resume()
    }
    
    public func setViewDelegate(delegate: PresenterDelegate ){
        self.delegate = delegate
    }
}
