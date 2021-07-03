//
//  UserCell.swift
//  vkApp
//
//  Created by Anna Delova on 4/19/21.
//

import UIKit
import Kingfisher


class UserCell: UITableViewCell {


    @IBOutlet weak var userAvatarImg: UIImageView!
    @IBOutlet weak var userName: UILabel!

//    override func prepareForReuse() {
//        super.prepareForReuse()
//        userAvatarImg.image = nil
//        userName.text = nil
//    }
    
    func configure(name: String, imageURL: String) {
        userAvatarImg.kf.setImage(with: URL(string: imageURL))
        userName.text = name
        
    }
    
    func animateAvatar() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 0.5
        animation.mass = 1.5
        animation.duration = 0.4
        animation.beginTime = CACurrentMediaTime() + 0.5
        animation.stiffness = 300
        animation.fillMode = CAMediaTimingFillMode.backwards

        self.userAvatarImg.layer.add(animation, forKey: nil)
    }
    override func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        viewTapped()
    }
    @objc func viewTapped() {
        animateAvatar()
    }
    

    

}
