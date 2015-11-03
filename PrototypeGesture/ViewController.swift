//
//  ViewController.swift
//  PrototypeGesture
//
//  Created by Mark Angelo Noquera on 11/2/15.
//  Copyright © 2015 Mark Angelo Noquera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var profileOne      = UIView()
    var profileTwo      = UIView()
    var profileThree    = UIView()
    var dropAreaView    = UIView()
    let panGestureOne   = UIPanGestureRecognizer()
    let panGestureTwo   = UIPanGestureRecognizer()
    let panGestureThree = UIPanGestureRecognizer()
    var originCenter    = CGPointZero
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        initTarget(panGestureOne)
        initTarget(panGestureTwo)
        initTarget(panGestureThree)
        
        profileOne.userInteractionEnabled = true
        profileTwo.userInteractionEnabled = true
        profileThree.userInteractionEnabled = true

        profileOne.addGestureRecognizer(panGestureOne)
        profileTwo.addGestureRecognizer(panGestureTwo)
        profileThree.addGestureRecognizer(panGestureThree)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initTarget(panGesture: UIPanGestureRecognizer) {
        panGesture.addTarget(self, action: "draggedView:")
    }
    
    
    func draggedView(sender: UIPanGestureRecognizer) {
        self.view.bringSubviewToFront(sender.view!)
        let translation = sender.translationInView(self.view)
        switch sender.state {
        case UIGestureRecognizerState.Began:
            originCenter = sender.view!.center
        case UIGestureRecognizerState.Ended:
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                if CGRectContainsPoint(self.dropAreaView.frame, sender.view!.center) {
                    UIView.animateWithDuration(0.4, animations: { () -> Void in
                        sender.view?.hidden = true
                        self.dropAreaLocate()
                    })
                } else {
                    sender.view!.center = self.originCenter
                    self.dropAreaLocate()
                }
            
            })
        case UIGestureRecognizerState.Changed:
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                sender.view!.center = CGPointMake(sender.view!.center.x + translation.x, sender.view!.center.y + translation.y)
            })
            
            if CGRectContainsPoint(self.dropAreaView.frame, sender.view!.center) {
                dropAreaView.backgroundColor = UIColor.clearColor()
                dropAreaView.layer.borderColor = UIColor.whiteColor().CGColor
                dropAreaView.layer.borderWidth = 6
            } else {
                self.dropAreaLocate()
            }
            
        default:
            break
        }

        sender.setTranslation(CGPointZero, inView: self.view)
    }
    
    
    func initComponent() {
        profileOne      = view.viewWithTag(1) as UIView!
        profileTwo      = view.viewWithTag(2) as UIView!
        profileThree    = view.viewWithTag(3) as UIView!
        dropAreaView    = view.viewWithTag(4) as UIView!
        self.profileOne.layer.cornerRadius = self.profileOne.bounds.size.height / 2
        self.profileTwo.layer.cornerRadius = self.profileTwo.bounds.size.height / 2
        self.profileThree.layer.cornerRadius = self.profileThree.bounds.size.height / 2
        dropAreaLocate()
    }
    
    func dropAreaLocate() {
        dropAreaView.backgroundColor = UIColor.clearColor()
        dropAreaView.layer.borderColor = UIColor.grayColor().CGColor
        dropAreaView.layer.borderWidth = 3
    }
    
}

