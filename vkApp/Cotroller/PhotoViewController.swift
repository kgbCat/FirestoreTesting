//
//  PhotoViewController.swift
//  vkApp
//
//  Created by Anna Delova on 5/13/21.
//

import UIKit

class PhotoViewController: UIViewController {
//
    var selectedData: UIImage?
    
    @IBOutlet weak var photo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photo.image = selectedData
    
        
    }
    
}
