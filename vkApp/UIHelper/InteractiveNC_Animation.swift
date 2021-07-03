//
//  InteractiveNC_Animation.swift
//  vkApp
//
//  Created by Anna Delova on 5/4/21.
//

import UIKit

class CustomInteractiveTrasition: UIPercentDrivenInteractiveTransition {
    var isStarted = false
    var shouldFinish = false
}

class InteractiveNC_Animation: UINavigationController, UINavigationControllerDelegate {
    
    let interactiveTransition = CustomInteractiveTrasition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        let edgePanGR = UIScreenEdgePanGestureRecognizer(
            target: self,
            action: #selector(hadlePan(_:)))
        edgePanGR.edges = .left
        view.addGestureRecognizer(edgePanGR)
    }
    
    @objc private func hadlePan(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveTransition.isStarted = true
            
            
        case .changed:
            guard let width = recognizer.view?.bounds.width else {
                interactiveTransition.isStarted = false
                interactiveTransition.cancel()
                
                return
            }
            let translaton = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translaton.x / width
            let progress = max(0, min(relativeTranslation, 1))
            interactiveTransition.update(progress)
            interactiveTransition.shouldFinish = progress > 0.35
            
        case .ended:
            interactiveTransition.isStarted = false
            interactiveTransition.shouldFinish ? interactiveTransition.finish() : interactiveTransition.cancel()
            
        case .cancelled:
            interactiveTransition.isStarted = false
            interactiveTransition.cancel()
            
        default: break
        }
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            return PopAnimation()
        case .push:
            return PushAnimation()
        default:
            return nil
        }
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        interactiveTransition.isStarted ? interactiveTransition : nil
    }
}

//

class PushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
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

class PopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
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

