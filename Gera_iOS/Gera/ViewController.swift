//
//  ViewController.swift
//  Gera
//
//  Created by Marko Simic on 11/27/15.
//  Copyright © 2015 Human. All rights reserved.
//

import UIKit
import CoreMotion
import KRANN
import Parse

class ViewController: UIViewController {

    @IBOutlet var numberNormal: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet var TimeText: UILabel!
    @IBOutlet var numNormals: UILabel!
    @IBOutlet var numFalls: UILabel!

    let updateRate : NSTimeInterval = 0.02
    let manager = CMMotionManager()
    let queue = NSOperationQueue.mainQueue()
    let maxTime = 200;
    var data = PFObject(className: "Sample")
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
        self.recordButton.setTitle("Record", forState: UIControlState.Normal)
        motionUpdateInterval = updateRate
        updateCounts()
        
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
            stopRecording(false)
        }
        else {
            startRecording()
        }
    }
    
    /**
    ** Keep track of the time and stop recording at maxTime
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
                    stopRecording(true)
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
    }
    
    
    func startRecording() {
        //Start Timer
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
        TimeText.text = "0.0"
        
        //Update Button State
        self.recordButton.selected = true
        self.recordButton.setTitle("Stop", forState: UIControlState.Selected)
        
        //Record Data
        self.rawData = []

        manager.startDeviceMotionUpdatesToQueue(queue) {
            (data, error) in

            let roll = data?.attitude.roll
            let pitch = data?.attitude.yaw
            let yaw = data?.attitude.pitch

            let gx = data?.gravity.x
            let gy = data?.gravity.y
            let gz = data?.gravity.z
            
            let accelX = data?.userAcceleration.x
            let accelY = data?.userAcceleration.y
            let accelZ = data?.userAcceleration.z
            
            let rotX = data?.rotationRate.x
            let rotY = data?.rotationRate.y
            let rotZ = data?.rotationRate.z

            
            self.rawData.appendContentsOf( [roll, pitch, yaw, gx, gy, gz, accelX, accelY, accelZ, rotX, rotY, rotZ])
        
        }
    }
    
    func stopRecording(saveSample : Bool) {
        
        //Update UI
        self.recordButton.selected = false
        self.recordButton.setTitle("Start", forState: UIControlState.Normal)
        
        //Stop Timer
        timer.invalidate()
        counter = 0

        //Stop Recoding Data
        manager.stopDeviceMotionUpdates()
        
        if saveSample {
            self.saveSample()
        }
        updateCounts()
    }

    
    func saveSample() {
        //Truncate data streams to the right length
        let motionData = self.rawData.suffix(numFeatures)
        
        //Store sample info
        data["sample_type"] = sampleMode
        data["motion_data"] = String(motionData)
        data["vector_size"] = motionData.count
        
        //Save data point
        data.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
        //Create new data point
        data = PFObject(className: "Sample")
    }
    
    func updateCounts() {
        PFQuery.clearAllCachedResults()
      
        let normalQuery = PFQuery(className: "Sample")
        normalQuery.whereKey("sample_type", equalTo: "Normal")
        normalQuery.countObjectsInBackgroundWithBlock {
            (count: Int32, error: NSError?) -> Void in
            if error == nil {
                self.numFalls.text = String(count)
            }
        }
        
       let fallQuery = PFQuery(className: "Sample")
        fallQuery.whereKey("sample_type", equalTo: "Fall")
        fallQuery.countObjectsInBackgroundWithBlock {
            (count: Int32, error: NSError?) -> Void in
            if error == nil {
                self.numFalls.text = String(count)
            }
        }
        

    }
    
    func updateCountLabels() {
        
    }

}

