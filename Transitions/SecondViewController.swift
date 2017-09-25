//
//  SecondViewController.swift
//  Transitions
//
//  Created by Sai Madhukar on 27/07/17.
//  Copyright © 2017 Sai Madhukar. All rights reserved.
//

import UIKit
import GameKit



class SecondViewController: UIViewController{
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
      
        
        let button = UIButton(frame: CGRect(x: (view.bounds.width / 2) - 50, y: 100, width: 100, height: 50))
        button.setTitle("Pop", for: UIControlState.normal)
        button.setTitleColor(.orange, for: UIControlState.normal)
        button.titleLabel?.contentMode = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        view.addSubview(button)
        
        
       
        
        // Do any additional setup after loading the view.
    }
    
    
   
    
    
    
    
    
    
    @objc func handleBack()
    {
        print("back button pressed")
       
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
