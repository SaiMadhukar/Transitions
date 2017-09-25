//
//  ViewController.swift
//  Transitions
//
//  Created by Sai Madhukar on 27/07/17.
//  Copyright © 2017 Sai Madhukar. All rights reserved.
//

import UIKit




class FirstViewController: UIViewController,UIViewControllerTransitioningDelegate {

    
    let transition = SquareTransition()
    
    var button = UIButton()
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transcationMode = .push
        transition.startPoint = button.center
        print(button.center)
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transcationMode = .pop
        transition.startPoint = button.center
        
        return transition
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        button.frame = CGRect(x: (view.bounds.width / 2) - 50, y: 100, width: 100, height: 50)
        print(button.center)
        button.setTitle("Push", for: UIControlState.normal)
        button.setTitleColor(.orange, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.titleLabel?.contentMode = .center
        button.addTarget(self, action: #selector(self.handleNext), for: .touchUpInside)
        view.addSubview(button)
        self.transitioningDelegate = self
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func handleNext()
    {
        let second = SecondViewController()
        second.transitioningDelegate = self
        present(second, animated: true, completion: nil)
        print("next button pressed")
        
    }
    
}

