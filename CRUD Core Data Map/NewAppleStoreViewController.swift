//
//  NewAppleStoreViewController.swift
//  CRUD Core Data Map
//
//  Created by Maxime BOINET on 17/12/2017.
//  Copyright © 2017 Maxime BOINET. All rights reserved.
//

import UIKit
import CoreLocation

public protocol NewAppleStoreViewControllerDelegate: class {
    
    func newAppleStoreViewController(_ newAppleStoreViewController: NewAppleStoreViewController)
    
}

public class NewAppleStoreViewController: UIViewController {
    
    public weak var delegate: NewAppleStoreViewControllerDelegate?
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleTextField: UITextField!
    
    @IBOutlet var latLabel: UILabel!
    @IBOutlet var latTextField: UITextField!
    
    @IBOutlet var lonLabel: UILabel!
    @IBOutlet var lonTextField: UITextField!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("controllers.new_apple_store.title", comment: "")
        self.titleLabel.text = NSLocalizedString("controllers.new_apple_store.title_label", comment: "")
        self.latLabel.text = NSLocalizedString("controllers.new_apple_store.latitude_label", comment: "")
        self.lonLabel.text = NSLocalizedString("controllers.new_apple_store.longitude_label", comment: "")
        
        self.titleTextField.delegate = self
        self.latTextField.delegate = self
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeViewController))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(submitAppleStore))
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @objc public func closeViewController() {
        self.dismiss(animated: true)
    }
    
    @objc public func submitAppleStore() {
        guard
            let title = self.titleTextField.text,
            title.count > 0,
            let latString = self.latTextField.text,
            let lat = Double(latString),
            let lonString = self.lonTextField.text,
            let lon = Double(lonString) else {
                let alert = UIAlertController(title: NSLocalizedString("app.vocabulary.error_title", comment: ""),
                                              message: NSLocalizedString("app.vocabulary.error_form_message", comment: ""),
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("app.vocabulary.close", comment: ""), style: .cancel))
                self.present(alert, animated: true)
                return
        }
        let store = Store(title, CLLocationCoordinate2D(latitude: lat, longitude: lon))
        self.delegate?.newAppleStoreViewController(self)
    }
}

extension NewAppleStoreViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
