//
//  UIViewController+ChildViewController.swift
//  CRUD Core Data Map
//
//  Created by Maxime BOINET on 17/12/2017.
//  Copyright © 2017 Maxime BOINET. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addChildViewController(_ childController: UIViewController, in subview: UIView) {
        guard let view = childController.view else {
            return
        }
        view.frame = subview.bounds
        view.autoresizingMask = UIViewAutoresizing(rawValue: 0b111111)
        subview.addSubview(view)
        self.addChildViewController(childController)
    }
    
    func removeVisibleChildViewController(_ childController: UIViewController) {
        childController.removeFromParentViewController()
        childController.view.removeFromSuperview()
    }
    
}
