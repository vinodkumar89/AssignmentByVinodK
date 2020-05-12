//
//  Extensions.swift
//  EvaluationApp
//
//  Created by mac on 20/07/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import Kingfisher


//ImageView
extension UIImageView {
    func setImages(url:String){
        let activityInd = UIActivityIndicatorView()
        activityInd.center = CGPoint(x: self.frame.size.width  / 2,
                                     y: self.frame.size.height / 2)
        activityInd.color = UIColor.white
        self.addSubview(activityInd)
        let url = URL(string: url)
        let processor = DownsamplingImageProcessor(size: self.frame.size)
            >> RoundCornerImageProcessor(cornerRadius: 0)
        // self.kf.indicatorType =
        activityInd.startAnimating()
        self.kf.setImage(
            with: url,
            placeholder:UIImage(named: "avtar"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
                activityInd.stopAnimating()
            case .failure(let error):
                activityInd.stopAnimating()
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
    }}


extension UIView {
    
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
            
            print("Top: \(topInset)")
            print("bottom: \(bottomInset)")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
    
}



    extension UIViewController {
        func alert(message: String, title: String = "") {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            if let presented = self.presentedViewController {
                presented.removeFromParentViewController()
            }
            if presentedViewController == nil {
                self.present(alertVC, animated: true, completion: nil)
            }
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                alertVC.dismiss(animated: true, completion: nil)
            }}
        
        func alertWithNavigation(message: String, title: String = "",vc:UIViewController) {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            if let presented = self.presentedViewController {
                presented.removeFromParentViewController()
            }
            if presentedViewController == nil {
                self.present(alertVC, animated: true, completion: nil)
            }
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                alertVC.dismiss(animated: true, completion: {
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                })
            }}
        
        func alertWithPresent(message: String, title: String = "",vc:UIViewController) {
            
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            self.present(alertVC, animated: true, completion: nil)
            
            if let presented = self.presentedViewController {
                presented.removeFromParentViewController()
            }
            if presentedViewController == nil {
                self.present(alertVC, animated: true, completion: nil)
            }
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                alertVC.dismiss(animated: true, completion: {
                    self.present(vc, animated: true, completion: {
                    })
                    
                })
            }}
        
        func alertWithPop(message: String, title: String = "") {
            
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            self.present(alertVC, animated: true, completion: nil)
            
            if let presented = self.presentedViewController {
                presented.removeFromParentViewController()
            }
            if presentedViewController == nil {
                self.present(alertVC, animated: true, completion: nil)
            }
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                alertVC.dismiss(animated: true, completion: {
                    
                    self.navigationController?.popViewController(animated: true)
                })
            }}
        
        func alertWithPopToRoot(message: String, title: String = "") {
            
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            self.present(alertVC, animated: true, completion: nil)
            
            if let presented = self.presentedViewController {
                presented.removeFromParentViewController()
            }
            if presentedViewController == nil {
                self.present(alertVC, animated: true, completion: nil)
            }
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                alertVC.dismiss(animated: true, completion: {
                    
                    self.navigationController?.popToRootViewController(animated:true)
                })
            }}
        
        
}
