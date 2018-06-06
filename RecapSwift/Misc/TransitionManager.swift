//
//  TransitionManager.swift
//  Transitionbasic
//
//  Created by Daniel Hjärtström on 2018-03-15.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

enum PresentationStatus {
    case present, dismiss
}

enum Style {
    case dimmed, blurred
}

class TransitionManager: NSObject, UIViewControllerTransitioningDelegate {

    private var height: CGFloat
    private var tapToDismiss: Bool
    private var duration: Double
    private var style: Style
    
    init(height: CGFloat, tapToDismiss: Bool, duration: Double, style: Style) {
        self.height = height
        self.tapToDismiss = tapToDismiss
        self.duration = duration
        self.style = style
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting, height: height, tapToDismiss: tapToDismiss, style: style)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimation(height: height, duration: duration, status: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimation(height: height, duration: duration, status: .dismiss)
    }
    
}

class PresentationController: UIPresentationController {
    
    var height: CGFloat
    var style: Style
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        let temp = UITapGestureRecognizer(target: self, action: #selector(dismiss(sender:)))
        temp.numberOfTapsRequired = 1
        return temp
    }()
    
    let dimView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return temp
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let temp = UIVisualEffectView(effect: effect)
        return temp
    }()
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, height: CGFloat, tapToDismiss: Bool, style: Style) {
        self.height = height
        self.style = style
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    
        if tapToDismiss {
            if style == .blurred {
                blurView.addGestureRecognizer(tapRecognizer)
            } else {
                dimView.addGestureRecognizer(tapRecognizer)
            }
        }
    }
    
    override func presentationTransitionWillBegin() {

        if style == .blurred {
            blurView.frame = self.containerView!.bounds
            blurView.alpha = 0
            containerView?.insertSubview(blurView, at: 0)
            
            let transitionCoordinator = presentingViewController.transitionCoordinator
            transitionCoordinator?.animate(alongsideTransition: { [weak self] (_) -> () in
                self?.blurView.alpha = 1.0
            })
        } else {
            dimView.frame = self.containerView!.bounds
            dimView.alpha = 0
            containerView?.insertSubview(dimView, at: 0)
            
            let transitionCoordinator = presentingViewController.transitionCoordinator
            transitionCoordinator?.animate(alongsideTransition: { [weak self] (_) -> () in
                self?.dimView.alpha = 1.0
            })
        }
        
    }
    
    override func dismissalTransitionWillBegin() {
        let transitionCoordinator = presentedViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: { [weak self] (_) -> () in
            
            if self?.style == .blurred {
                self?.blurView.alpha = 0.0
            } else {
                self?.dimView.alpha = 0.0
            }
        })
    }
    
    // Sets viewcontroller frame to be equal to it's container's bounds
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = CGRect(x: 0, y: frameOfPresentedViewInContainerView.height - height, width: frameOfPresentedViewInContainerView.width, height: height)
    }
    
    @objc private func dismiss(sender: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}


class TransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var height: CGFloat
    var duration: Double
    var status: PresentationStatus
    
    init(height: CGFloat, duration: Double, status: PresentationStatus) {
        self.height = height
        self.duration = duration
        self.status = status
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let from = transitionContext.viewController(forKey: .from) else { return }
        guard let to = transitionContext.viewController(forKey: .to) else { return }
        
        guard let fromView = from.view else { return }
        guard let toView = to.view else { return }
        
        if status == .present {
            container.addSubview(toView)
            container.clipsToBounds = true
            container.layer.masksToBounds = true
            toView.frame.origin.y = toView.bounds.height
            
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
                toView.frame.origin.y -= self.height
            }, completion: { (completion) in
                transitionContext.completeTransition(!(transitionContext.transitionWasCancelled))
            })
            
        } else {
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
                fromView.frame.origin.y += self.height
            }, completion: { (completion) in
                transitionContext.completeTransition(!(transitionContext.transitionWasCancelled))
                
            })
        }
    }
    
}
