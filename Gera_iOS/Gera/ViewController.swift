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

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet var TimeText: UILabel!
    
    let updateRate : NSTimeInterval = 1 //0.02
    let manager = CMMotionManager()
    let queue = NSOperationQueue.mainQueue()
    let maxTime = 200;
    
    var sampleMode = "Normal"
    var accelerometerUpdateInterval: NSTimeInterval = 0.05
    var gyroUpdateInterval: NSTimeInterval = 0.05
    var motionUpdateInterval: NSTimeInterval = 0.05
    var timer: NSTimer = NSTimer();
    var counter = 0;


    

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
            stopRecording()
        }
        else {
            //Start Timer
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
            TimeText.text = "0.0"
            
            //Update Button State
            self.recordButton.selected = true
            self.recordButton.setTitle("Stop", forState: UIControlState.Selected)

            //Record Data
            startRecording()
        }
    }
    
    /**
    **
    **/
    func updateTimer() {
        counter++;
        if (counter < 10) {
            TimeText.text = "0.0"  + String(counter)
        } else {
            if (counter < 100) {
                TimeText.text = "0." + String(counter)
            } else {
                let tail = counter % 100 == 0 ? "0": ""

                TimeText.text = String(counter / 100) + "." + String(counter % 100) + tail
                if (counter >= maxTime) {
                    stopRecording()
                    //TODO: Write that shit to the file
                    //TRIM_DATA to fixed size

                }
            }
        }
        
    }
    
    /**
     ** Set mode of recording for sample collection.
     **/
    @IBAction func selectMode(sender: AnyObject) {
        if sampleMode == "Normal" {
            sampleMode = "Fall"
        }
        else {
            sampleMode = "Normal"
        }
        print(sampleMode)
    }
    
    
    func startRecording() {
        manager.startAccelerometerUpdatesToQueue(queue) {
            (data, error) in
            print("ACCEL DATA")
            print(data)
            print("-------------------")
        }
        manager.startGyroUpdatesToQueue(queue) {
            (data, error) in
            print("GYRO DATA")
            print(data)
            print("__________________")
        }
        manager.startDeviceMotionUpdatesToQueue(queue) {
            (data, error) in
            print("MOTION DATA")
            print(data)
            print("_________________")
        }
    }
    
    func stopRecording() {
        //Update UI
        self.recordButton.selected = false
        self.recordButton.setTitle("Start", forState: UIControlState.Normal)
        
        //Stop Timer
        timer.invalidate()
        counter = 0
        //TODO: Invalidate writing that shit to text file

        //Stop Recoding Data
        manager.stopAccelerometerUpdates()
        manager.stopGyroUpdates()
        manager.stopDeviceMotionUpdates()
    }
    

}

