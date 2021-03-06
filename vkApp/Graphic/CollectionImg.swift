//
//  File.swift
//  vkApp
//
//  Created by Anna Delova on 4/16/21.
//

import UIKit

class CollectionImg: UIImageView {
    @IBInspectable var borderColor: UIColor = .darkGray
    @IBInspectable var borderWidth: CGFloat = 1.5
    

    override func awakeFromNib() {
//        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
//        self.backgroundColor = .clear
    }
}
