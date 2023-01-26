//
//  ViewController.swift
//  lecp
//
//  Created by Luis Eduardo Cordova Pichardo on 21/01/23.
//

import UIKit

class LoginViewController: UIViewController, UserPresenterDelegate {
    
    @IBOutlet var viewScrollView: UIScrollView!
    private let presenter = UserPresenter()
    var alert = UIAlertController()

    @IBOutlet weak var passwordUiText: UITextField!
    @IBOutlet weak var usernameUiText: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //title = "Login"
        view = Utils().generateGradientBackground(view: view)
        
        // Presenter
        presenter.setViewDelegate(delegate: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    var isExpand: Bool = false
    @objc func keyboardAppear(){
        if !isExpand{
            let frame = CGRect(x: -1, y: 450, width: 10, height: 370); //wherever you want to scroll
            viewScrollView.scrollRectToVisible(frame, animated: true)
            isExpand = true
        }
    }
    
    @IBAction func loginActionButton(_ sender: Any) {
        self.messageLabel.isHidden = true
        view.endEditing(true)
        if(usernameUiText.isEmpty){
            usernameUiText.shake()
        }else if(passwordUiText.isEmpty){
            passwordUiText.shake()
        }else{
            self.alert = Utils().showMessage(mensaje: "Loading", titulo: "The movie DB")
            getTopMostViewController()?.present(alert, animated: true, completion: nil)
            presenter.getnewSessiontoken(apiKey: "385ffc860064978de0a4bdc0eb37836e")
        }
    }
    
    // Presenter Delegate
    
    func getnewSessiontoken(sessionToken: getTokenResponse) {
        DispatchQueue.main.async {
            if(sessionToken.success){
                UserDefaults.standard.set(sessionToken.request_token, forKey: "REQUEST_TOKEN")
                self.presenter.login(username: self.usernameUiText.text!, password: self.passwordUiText.text!)
            }else{
                
            }
        }
    }
    
    func presentLogin(responseLogin: LoginResponse) {
        DispatchQueue.main.async {
            if(responseLogin.success){
                self.alert.dismiss(animated: true)
                
                self.performSegue(withIdentifier: "goToMovies", sender: self.getTopMostViewController())
                self.dismiss(animated: true)
            }else{
                self.alert.dismiss(animated: true)
                self.messageLabel.isHidden = false
                self.messageLabel.text = responseLogin.status_message
            }
        }
    }
    
    func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.windows[0].rootViewController

            while let presentedViewController = topMostViewController?.presentedViewController {
                topMostViewController = presentedViewController
            }

            return topMostViewController
        }
    

}
