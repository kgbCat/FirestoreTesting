//
//  CustomSegue.swift
//  vkApp
//
//  Created by Anna Delova on 5/4/21.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    override func perform() {
        guard let conteinerView = source.view else { return }
        
        conteinerView.addSubview(destination.view)
        destination.view.frame = conteinerView.frame
        
        destination.view.transform = CGAffineTransform(
            translationX: +source.view.bounds.width, y: +source.view.bounds.height)
        
        UIView.animate(withDuration: 1.5) {
            self.destination.view.transform = .identity
        } completion: { _ in
            self.source.present(self.destination, animated: false)
        }
        
        
    }
}
