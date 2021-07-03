//
//  GroupCell.swift
//  vkApp
//
//  Created by Anna Delova on 4/15/21.
//

import UIKit

class GroupCell: UITableViewCell {

    
    
    @IBOutlet weak var groupAvatarImg: UIImageView!
    @IBOutlet weak var groupName: UILabel!
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        groupAvatarImg.image = nil
//        groupName.text = nil
//    }
    
    func configure(name: String, imageURL: String) {
        groupName.text = name
        groupAvatarImg.kf.setImage(with: URL(string: imageURL))
       
        
    }

}
