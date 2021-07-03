//
//  RegisterViewController.swift
//  vkApp
//
//  Created by Anna Delova on 6/28/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    
    @IBAction func registerDataButton(_ sender: UIButton) {
        
        if let name = firstNameText.text,
           let surname = lastNameText.text,
           let dataSender = Auth.auth().currentUser?.email {
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                Constants.FStore.sender: dataSender,
                Constants.FStore.firstName: name,
                Constants.FStore.lastName: surname,
                Constants.FStore.date: Date().timeIntervalSince1970,
            ]) { (error) in
                if let e = error {
                    print(e)
                } else {
                    print("Data is successfully saved ")
                }
            }
        
        }
        
    }
    
}
