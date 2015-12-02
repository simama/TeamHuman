//
//  ViewController.swift
//  Gera_User_App
//
//  Created by Marko Simic on 12/1/15.
//  Copyright © 2015 Human. All rights reserved.
//

import UIKit
import CoreData
import CoreMotion

class ViewController: UIViewController {

    
    let updateRate : NSTimeInterval = 0.02
    let manager = CMMotionManager()
    let queue = NSOperationQueue.mainQueue()
    let maxTime = 200;
//    var data = PFObject(className: "Sample") used to connect to PARSE cloud. Don't need it here
    let numFeatures = 1920
    
    var sampleMode = "Normal"
    var accelerometerUpdateInterval: NSTimeInterval = 0.05
    var gyroUpdateInterval: NSTimeInterval = 0.05
    var motionUpdateInterval: NSTimeInterval = 0.05
    var timer: NSTimer = NSTimer()
    var counter = 0
    var rawData = [Double?]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

