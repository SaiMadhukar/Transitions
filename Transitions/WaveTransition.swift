//
//  WaveTransition.swift
//  Transitions
//
//  Created by Sai Madhukar on 27/07/17.
//  Copyright © 2017 Sai Madhukar. All rights reserved.
//

import UIKit

class WaveTransition: NSObject {
    
    var wave = UIView()
    
    enum TranstionMode {
        case push
        case pop
        
        
    }
    
    var startPoint : CGPoint = CGPoint.zero {
        
        didSet{
            wave.center = startPoint
        }
        
    }
    var duration : Double = 0.8
    var backgroundColor : UIColor = UIColor(red: 73.0/255.0, green: 133.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    var transcationMode : TranstionMode = .push

    
}


extension WaveTransition : UIViewControllerAnimatedTransitioning{
    
    
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
                wave = UIView()
                
                wave.backgroundColor = backgroundColor
                wave.frame = frameForWave(withCenter: viewCenter, withSize: viewSize, withStartingPoint: startPoint)
                wave.center = startPoint
              //  wave.layer.cornerRadius = wave.frame.size.height / 2
                
                container.addSubview(wave)
              
                container.insertSubview(presentingView, belowSubview: wave)
                presentingView.alpha = 0
                
                
                UIView.animate(withDuration: duration, animations: {
                    self.wave.transform = .identity
                    self.wave.alpha = 1
                    
                    
                }, completion: { (success) in
                    presentingView.alpha = 1
                    self.wave.removeFromSuperview()
                    
                    transitionContext.completeTransition(success)
                })
                
            }
            break
        case .pop:
            
            if let returningView = transitionContext.view(forKey: .to) {
                
                wave = UIView()
                let viewCenter = returningView.center
                let viewSize = returningView.bounds.size
                
                wave.backgroundColor = backgroundColor
                wave.frame = frameForWave(withCenter: viewCenter, withSize: viewSize, withStartingPoint: startPoint)
                wave.center = startPoint
                wave.layer.cornerRadius = wave.frame.size.height / 2
                
                container.addSubview(wave)
                container.insertSubview(returningView, belowSubview: wave)
                returningView.alpha = 1
                wave.alpha = 1
                
                UIView.animate(withDuration: duration, animations: {
                    self.wave.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    self.wave.alpha = 1
                    
                }, completion: { (success) in
                    self.wave.removeFromSuperview()
                    transitionContext.completeTransition(success)
                })
            }
            
            break
            
            
        }
        
        
        
        
    }
    
    func frameForWave(withCenter center: CGPoint,
                        withSize viewSize: CGSize,
                        withStartingPoint startPoint : CGPoint) -> CGRect {
        
        let width = fmax(startPoint.x, viewSize.width - startPoint.x)
        let height = fmax(startPoint.y,viewSize.height - startPoint.y)
        let radius = sqrt(width * width + height * height) * 2
        let size = CGSize(width: radius, height: radius)
        return CGRect(origin: CGPoint.zero, size: size)
        
    }
    
    
    
    
}

