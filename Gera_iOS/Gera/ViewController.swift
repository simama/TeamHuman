//
//  ViewController.swift
//  Gera
//
//  Created by Marko Simic on 11/27/15.
//  Copyright © 2015 Human. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var xgValue: UILabel!
    @IBOutlet weak var ygValue: UILabel!
    @IBOutlet weak var zgValue: UILabel!
    @IBOutlet weak var xaValue: UILabel!
    @IBOutlet weak var yaValue: UILabel!
    @IBOutlet weak var zaValue: UILabel!
    @IBOutlet weak var recordButton: UIButton!

    let updateRate : NSTimeInterval = 1 //0.02
    let manager = CMMotionManager()
    let queue = NSOperationQueue.mainQueue()

    
    var accelerometerUpdateInterval: NSTimeInterval = 0.0
    var gyroUpdateInterval: NSTimeInterval = 0.0
    var motionUpdateInterval: NSTimeInterval = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.recordButton.setTitle("Record", forState: UIControlState.Normal)
        accelerometerUpdateInterval = updateRate
        gyroUpdateInterval = updateRate
        motionUpdateInterval = updateRate
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**
     ** Start Recording sample
     **/
    @IBAction func toggleButtonName(sender: UIButton) {
        if  self.recordButton.selected  {
            self.recordButton.selected = false
            self.recordButton.setTitle("Record", forState: UIControlState.Normal)
            manager.stopAccelerometerUpdates()
            manager.stopGyroUpdates()
            manager.stopDeviceMotionUpdates()
        }
        else {
            self.recordButton.selected = true
            self.recordButton.setTitle("Stop", forState: UIControlState.Selected)
            manager.startAccelerometerUpdatesToQueue(queue) {
                (data, error) in
                print(data)
            }
            manager.startGyroUpdatesToQueue(queue) {
                (data, error) in
                print(data)
            }
            manager.startDeviceMotionUpdatesToQueue(queue) {
                (data, error) in
                print(data)
            }
        }
    }

}

