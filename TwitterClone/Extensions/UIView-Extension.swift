//
//  UIView-Extension.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 20.05.2023.
//

import Foundation
import UIKit

extension UIView {
    
   @IBInspectable var cornerRadius : CGFloat{
        get{
            return self.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
            
        }
    }
}
