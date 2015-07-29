//
//  BaseViewController.swift
//  BikeBlackSpot-iOS
//
//  Created by Anita Santoso on 29/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation
import UIKit
import Cartography

public class BaseViewController : UIViewController {
    
    var segueIdentifier:String?
    var button:UIButton?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }
    
    func addNextButton(text:String, segueIdentifier:String? = nil) {
        var button = UIButton()
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        button.setBackgroundColor(Colour.Yellow, forState:UIControlState.Normal)
        button.setBackgroundColor(Colour.DarkYellow, forState:UIControlState.Disabled)
        
        self.view.addSubview(button)
        self.button = button
        
        setNextButtonTitle(text)
        
        constrain(button) { button in
            button.height == 40
            button.bottom == button.superview!.bottom - 10.0
            button.left == button.superview!.left + 10.0
            button.right == button.superview!.right - 10.0
        }
        
        if let id = segueIdentifier {
            self.segueIdentifier = id
            button.addTarget(self, action: "performSegue", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    func setNextButtonTitle(title:String) {
        if let button = self.button {
           let title = NSMutableAttributedString(string: title, attributes: [NSFontAttributeName:Font.buttonTitle()])
            button.setAttributedTitle(title, forState: UIControlState.Normal)
        }
    }
    
    func nextButton() -> UIButton? {
        return self.button
    }
    
    func performSegue() {
        performSegueWithIdentifier(segueIdentifier!, sender: nil)
    }
}