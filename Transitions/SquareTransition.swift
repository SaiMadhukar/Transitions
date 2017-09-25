//
//  SquareTransition.swift
//  Transitions
//
//  Created by Sai Madhukar on 27/07/17.
//  Copyright © 2017 Sai Madhukar. All rights reserved.
//

import UIKit

class SquareTransition: NSObject {
    
    
    var circle = UIView()
    
    enum TranstionMode {
        case push
        case pop
        
        
    }
    
    var startPoint : CGPoint = CGPoint.zero {
        
        didSet{
            circle.center = startPoint
        }
        
    }
    var duration : Double = 0.8
    var backgroundColor : UIColor = .yellow
    var transcationMode : TranstionMode = .push
    
}


extension SquareTransition : UIViewControllerAnimatedTransitioning{
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        
        switch transcationMode {
        case .push:
            
            
            if let presentingView = transitionContext.view(forKey: .to) {
                
                let viewCenter = presentingView.center
                let viewSize = presentingView.bounds.size
                circle = UIView()
                
                circle.backgroundColor = backgroundColor
                circle.frame = frameForCircle(withCenter: viewCenter, withSize: viewSize, withStartingPoint: startPoint)
                circle.center = startPoint
                circle.layer.cornerRadius = circle.frame.size.height / 8
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                container.addSubview(circle)
                //container.addSubview(presentingView)
                // presentingView.alpha = 0
                container.insertSubview(presentingView, belowSubview: circle)
                presentingView.alpha = 0
                
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = .identity
                    self.circle.alpha = 1
                    
                    //presentingView.alpha = 0.6
                }, completion: { (success) in
                    presentingView.alpha = 1
                    self.circle.removeFromSuperview()
                    
                    transitionContext.completeTransition(success)
                })
                
            }
            break
        case .pop:
            
            if let returningView = transitionContext.view(forKey: .to) {
                
                circle = UIView()
                let viewCenter = returningView.center
                let viewSize = returningView.bounds.size
                
                circle.backgroundColor = backgroundColor
                circle.frame = frameForCircle(withCenter: viewCenter, withSize: viewSize, withStartingPoint: startPoint)
                circle.center = startPoint
                circle.layer.cornerRadius = circle.frame.size.height / 8
                
                container.addSubview(circle)
                container.insertSubview(returningView, belowSubview: circle)
                returningView.alpha = 1
                circle.alpha = 1
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    self.circle.alpha = 1
                    
                }, completion: { (success) in
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                })
            }
            
            break
            
            
        }
        
        
        
        
    }
    
    func frameForCircle(withCenter center: CGPoint,
                        withSize viewSize: CGSize,
                        withStartingPoint startPoint : CGPoint) -> CGRect {
        
        let width = fmax(startPoint.x, viewSize.width - startPoint.x)
        let height = fmax(startPoint.y,viewSize.height - startPoint.y)
        let radius = sqrt(width * width + height * height) * 2
        let size = CGSize(width: radius, height: radius)
        return CGRect(origin: CGPoint.zero, size: size)
        
    }
    
    
    
    
}
