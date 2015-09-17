//
//  ViewController.swift
//  ProblematicPresentation
//
//  Created by Vladimír Bělohradský on 17/09/15.
//  Copyright © 2015 Fripito Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func openButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("openDetail", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dialogVC = segue.destinationViewController as? DialogViewController {
            debugPrint("Opening dialog")
            dialogVC.parent = self
            dialogVC.modalPresentationStyle = UIModalPresentationStyle.Custom
            dialogVC.transitioningDelegate = dialogVC
        }
    }
}

