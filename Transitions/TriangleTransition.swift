//
//  TriangleTransition.swift
//  Transitions
//
//  Created by Sai Madhukar on 27/07/17.
//  Copyright © 2017 Sai Madhukar. All rights reserved.
//

import UIKit

class TriangleView : UIView {
    
    var color = UIColor.yellow
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
        context.closePath()
        
        context.setFillColor(color.cgColor)
        context.fillPath()
    }
}



class TriangleTransition: NSObject {
    
    
    var triangle = TriangleView()
    
    enum TranstionMode {
        case push
        case pop
        
        
    }
    
    var startPoint : CGPoint = CGPoint.zero {
        
        didSet{
            triangle.center = startPoint
        }
        
    }
    var duration : Double = 0.8
    var backgroundColor : UIColor = .yellow
    var transcationMode : TranstionMode = .push
}



extension TriangleTransition : UIViewControllerAnimatedTransitioning{
    
    
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
                triangle = TriangleView()
                triangle.backgroundColor = .clear
                triangle.color = backgroundColor
                triangle.frame = frameForCircle(withCenter: viewCenter, withSize: viewSize, withStartingPoint: startPoint)
                triangle.center = startPoint
                triangle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                container.addSubview(triangle)
                container.insertSubview(presentingView, belowSubview: triangle)
                presentingView.alpha = 0
                
                
                UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.triangle.transform = .identity
                    self.triangle.alpha = 1
                    
                    
                }, completion: { (success) in
                    presentingView.alpha = 1
                    self.triangle.removeFromSuperview()
                    
                    transitionContext.completeTransition(success)
                })
                
            }
            break
        case .pop:
            
            if let returningView = transitionContext.view(forKey: .to) {
                
                triangle = TriangleView()
                triangle.backgroundColor = .clear
                let viewCenter = returningView.center
                let viewSize = returningView.bounds.size
                
                triangle.color = backgroundColor
                triangle.frame = frameForCircle(withCenter: viewCenter, withSize: viewSize, withStartingPoint: startPoint)
                triangle.center = startPoint
               
                
                container.addSubview(triangle)
                container.insertSubview(returningView, belowSubview: triangle)
                returningView.alpha = 1
                triangle.alpha = 1
                
              UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.triangle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    self.triangle.alpha = 1
                    
                }, completion: { (success) in
                    self.triangle.removeFromSuperview()
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

