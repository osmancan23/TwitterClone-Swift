//
//  GenericViewController.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 13.06.2023.
//

import Foundation
import UIKit

class GenericViewController<T: UIView>: UIViewController {

  public var rootView: T { return view as! T }
    
  override open func loadView() {
     self.view = T()
  }

}
