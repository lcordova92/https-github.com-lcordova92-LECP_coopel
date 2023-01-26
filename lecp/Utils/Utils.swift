//
//  Utils.swift
//  lecp
//
//  Created by Luis Eduardo Cordova Pichardo on 21/01/23.
//

import Foundation
import UIKit
import SkeletonView

class Utils{
    
    func generateGradientBackground(view: UIView) -> UIView{
        // Create a gradient layer.
        let gradientLayer = CAGradientLayer()
        // Set the size of the layer to be equal to size of the display.
        gradientLayer.frame = view.bounds
        // Set an array of Core Graphics colors (.cgColor) to create the gradient.
        // This example uses a Color Literal and a UIColor from RGB values.
        gradientLayer.colors = [#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1).cgColor, UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor]
        // Rasterize this static layer to improve app performance.
        gradientLayer.shouldRasterize = true
        gradientLayer.locations = [0, 0.4]
        gradientLayer.frame = view.frame
        // Apply the gradient to the backgroundGradientView.z
        view.layer.insertSublayer(gradientLayer, at: 0)
        return view
    }
    
    func showMessage(mensaje:String, titulo:String) -> UIAlertController{
        
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)

        return alert
        
    }
    
    
}

extension UIView {
    func shake(duration timeDuration: Double = 0.07, repeat countRepeat: Float = 3){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = timeDuration
        animation.repeatCount = countRepeat
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}

extension UITextField {

    var isEmpty: Bool {
        if let text = self.text, !text.isEmpty {
             return false
        }
        return true
    }
}

extension UIImageView{
    func loadFromUrl(url: URL){
        if let data = try? Data(contentsOf: url){
            if let imageUrl = UIImage(data: data){
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.image = imageUrl
                    self.hideSkeleton()
                }
            }
      }
    }
}
