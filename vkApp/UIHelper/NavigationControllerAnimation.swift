//
//  NavigationControllerAnimation.swift
//  vkApp
//
//  Created by Anna Delova on 5/4/21.
//
import UIKit


class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animateTime = 1.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.frame = transitionContext.containerView.frame
        
    
//        destination.view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))

        destination.view.transform = CGAffineTransform(
            translationX: source.view.bounds.width,
            y: source.view.bounds.height)

        
        UIView.animate(withDuration: animateTime) {
            destination.view.transform = .identity
        } completion: { complete in
            transitionContext.completeTransition(complete)
        }
        


    
}
}

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animateTime = 1.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        
//        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        
//        destination.view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        
        destination.view.transform = CGAffineTransform(
            translationX: -source.view.bounds.width,
            y: -source.view.bounds.height)
        
        UIView.animate(withDuration: animateTime) {
            destination.view.transform = .identity
        } completion: { complete in
            transitionContext.completeTransition(complete)
        }

    }
}

