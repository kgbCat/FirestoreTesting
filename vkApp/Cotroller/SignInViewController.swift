//
//  SignInViewController.swift
//  vkApp
//
//  Created by Anna Delova on 6/28/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignInViewController: UIViewController {
    
    let db = Firestore.firestore()
    @IBOutlet weak var helloUser: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true        
        loadName()
    }
    @IBAction func LogOutButton(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        
    }
    func loadName() {
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.date)
            .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print(document.data())
                    let data = document.data()
                    let name = data[Constants.FStore.firstName]
                    self.helloUser.text = name as? String
                }
            }
        }
    }


}
