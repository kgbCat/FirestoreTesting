//  Created by Anna Delova on 4/14/21.

import UIKit

class FriendPhoto: UICollectionViewCell {


    @IBOutlet weak var friendImg: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!

    @IBAction func heartAction(_ sender: UIButton) {
        upDateButton(sender)
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        friendImg.image = nil
        likesLabel.text = nil
    }
    
    var touches = 0 {
        didSet{
            likesLabel.text = "Likes: \(touches)"
        }
    }
    
    func configure(imageURL: String) {
        friendImg.kf.setImage(with: URL(string: imageURL))
    }
    
    func animation3() {
        UIView.transition(with: likesLabel,
                          duration: 0.9,
                          options: [.transitionFlipFromLeft]){
            
        }
    }
    
    
    func animatePhoto() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 0.4
        animation.mass = 1
        animation.duration = 0.8
        animation.beginTime = CACurrentMediaTime() + 0.3
        animation.stiffness = 50
        animation.fillMode = CAMediaTimingFillMode.backwards

        self.friendImg.layer.add(animation, forKey: nil)
    }
    
    fileprivate func upDateButton(_ sender: UIButton) {
        if touches == 0 {
            animation3()
            animatePhoto()
            touches += 1
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            sender.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .selected)
            
        } else {
            animation3()
            touches = 0
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            sender.backgroundColor = .clear
            
        }
    }

        
    
}
