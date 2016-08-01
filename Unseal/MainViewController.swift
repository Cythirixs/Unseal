//
//  MainViewController.swift
//  Unseal
//
//  Created by synaptics on 7/26/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class MainViewController: UIViewController {
    
    var timer : NSTimer?
    
    var main : MainScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        main =  MainScene(fileNamed:"MainScene")
        
        if (main != nil) {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            main.scaleMode = .AspectFit
            
            skView.presentScene(main)
        }
        
        timer?.invalidate()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "changeView:", userInfo: nil, repeats: false)
    }
    
    func changeView(timer : NSTimer){
        if main.gameStart{
            let view = self.storyboard!.instantiateViewControllerWithIdentifier("GameViewController")
            self.showViewController(view as UIViewController, sender: view)
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

