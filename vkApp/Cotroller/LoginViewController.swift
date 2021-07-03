//
//  ViewController.swift
//  vkApp
//
//  Created by Anna Delova on 4/2/21.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var passwordName: UILabel!
        
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordnameText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

              
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if let email = usernameText.text, let password = passwordnameText.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.showRegisterError(error: e.localizedDescription)
                    print(e.localizedDescription)
                } else { // navigate to another VC
                    self.performSegue(withIdentifier: Constants.Segue.login, sender: self)
                }
            }
        }
    }
    
    @IBAction func RegisterButton(_ sender: UIButton) {
        
        if let email = usernameText.text, let password = passwordnameText.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.showRegisterError(error: e.localizedDescription)
                    print(e.localizedDescription)
                } else { // navigate to another VC
                    self.performSegue(withIdentifier: Constants.Segue.register, sender: self)
                }
            }
        }
    }
    
    func showRegisterError(error:String) {
        // create controller
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        // create button
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // add button to the controller
        alertController.addAction(action)
        // display UIAlertController
        present(alertController, animated: true, completion: nil)
    }

  
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
        

}

