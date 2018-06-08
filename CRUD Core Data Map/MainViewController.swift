//
//  MainViewController.swift
//  CRUD Core Data Map
//
//  Created by Maxime BOINET on 17/12/2017.
//  Copyright © 2017 Maxime BOINET. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var childContentView: UIView!
    
    lazy var mapViewController: MapViewController = {
        return MapViewController()
    }()
    lazy var listViewController: StoreListViewController = {
        return StoreListViewController()
    }()
    public var visibleViewController: UIViewController {
        if self.mapViewController.view.window != nil {
            return self.mapViewController
        }
        return self.listViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewController(self.mapViewController, in: self.childContentView)
    }
    
    @IBAction func switchController() {
        UIView.beginAnimations("", context: nil)
        
        
        let visibleViewController = self.visibleViewController
        self.removeVisibleChildViewController(visibleViewController)
        if visibleViewController == self.mapViewController {
            self.addChildViewController(self.listViewController, in: self.childContentView)
            UIView.setAnimationTransition(.curlUp, for: self.childContentView, cache: false)
        } else {
            self.addChildViewController(self.mapViewController, in: self.childContentView)
            UIView.setAnimationTransition(.curlDown, for: self.childContentView, cache: false)
        }
        UIView.setAnimationDuration(1.5)
        UIView.commitAnimations()
    }
    
    @IBAction func touchNewAppleStore() {
        let appleStoreViewController = NewAppleStoreViewController()
        appleStoreViewController.delegate = self
        self.present(PortraitNavigationController(rootViewController: appleStoreViewController), animated: true)
    }
}

extension MainViewController: NewAppleStoreViewControllerDelegate {
    
    func newAppleStoreViewController(_ newAppleStoreViewController: NewAppleStoreViewController) {
        newAppleStoreViewController.dismiss(animated: true)
    }
}
