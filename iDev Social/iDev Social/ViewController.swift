//
//  ViewController.swift
//  iDev Social
//
//  Created by Hemanth Devarapalli on 1/17/17.
//  Copyright © 2017 Hemanth Devarapalli. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!, completion: {(user, error) in
            if error != nil {
                print(error?.localizedDescription)
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .cancel, handler: {(alert) in
                    self.parent?.dismiss(animated: true, completion: {
                        
                    })
                })
                alert.addAction(ok)
                self.present(alert, animated: true, completion: {})
            } else {
                print("logged in")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        })
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: {(user, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
        })
    }
}

