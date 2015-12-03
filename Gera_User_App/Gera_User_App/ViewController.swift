//
//  ViewController.swift
//  Gera_User_App
//
//  Created by Marko Simic on 12/2/15.
//  Copyright © 2015 Human. All rights reserved.
//

import UIKit
import CoreData
import CoreMotion
import MLPNeuralNet
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var OkPrompt: UILabel!
    @IBOutlet weak var detectButton: UIButton!
    @IBOutlet weak var numDetections: UILabel!
    @IBOutlet weak var num: UILabel!
    
    let queue = NSOperationQueue.mainQueue()
    let manager = CMMotionManager()
    
    var timer: NSTimer = NSTimer()
    var rawData = [Double?]()
    var finalData = [Double]()
    var netSample = [Double]()
    var weights = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.detectButton.setTitle("Record", forState: UIControlState.Normal)
        self.OkPrompt.textColor = UIColor.whiteColor()
       
        do {
            weights = try weightsFromResource("weightFile.txt")
        }
        catch {
            print("WHERE ARE THE WEIGHTS");
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func detectToggle(sender: UIButton) {
        if  self.detectButton.selected  {
            stopRecording()
            //self.detectButton.selected = false
            //self.detectButton.setTitle("Record", forState: UIControlState.Normal) these were just for test
        }
        else {
            startRecording()
            //self.detectButton.selected = true
            //self.detectButton.setTitle("Stop", forState: UIControlState.Selected) these were just for test
        }

    }
    
    
    func startRecording() {
        
        //Update Button State
        self.detectButton.selected = true
        self.detectButton.setTitle("Stop", forState: UIControlState.Selected)
        self.OkPrompt.textColor = UIColor.whiteColor()
        
        //Record Data
        self.rawData = []
        self.finalData = []
        
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
            
            //Convert nil values to 0
            self.rawData.appendContentsOf( [roll, pitch, yaw, gx, gy, gz, accelX, accelY, accelZ, rotX, rotY, rotZ])
            self.finalData = self.rawData.map({ $0 == nil ? 0 : $0! })
            
            if (self.finalData.count == 1920) {
                self.netSample = self.finalData
                self.rawData = []
                self.mlpNeuralNet(self.weights, netSample: self.netSample)
            }
        }
    }
    
    func stopRecording() {
        
        //Update UI
        self.detectButton.selected = false
        self.detectButton.setTitle("Start", forState: UIControlState.Normal)
        
        //Stop Timer
        timer.invalidate()
        
        //Stop Recoding Data
        manager.stopDeviceMotionUpdates()
        
    }
    
    func mlpNeuralNet(weights: Array<Double>, netSample: Array<Double>){
            //NSData *weights = [NSData dataWithBytes:wts length:sizeof(wts)];
        var weight_data = NSData(bytes: weights, length: weights.count * sizeof(Double))
        var feature_data = NSData(bytes: netSample, length: netSample.count * sizeof(Double))
        let model: MLPNeuralNet = MLPNeuralNet.init(layerConfig: [1920,700,2], weights: weight_data, outputMode: MLPClassification)
        model.hiddenActivationFunction = MLPReLU
        model.outputActivationFunction = MLPSigmoid
        var prediction :NSMutableData! = NSMutableData(capacity: 1)
        
        model.predictByFeatureVector(feature_data, intoPredictionVector: prediction!)
        
        let assesment = prediction.bytes
        print(assesment)
        if (something == something) {
            self.OkPrompt.textColor = UIColor.blackColor()
            stopRecording()
        }
    }
    
    func weightsFromResource(fileName: String) throws -> [Double] {
        guard let path = NSBundle.mainBundle().pathForResource(fileName, ofType: nil) else {
            throw NSError(domain: NSCocoaErrorDomain, code: NSFileNoSuchFileError, userInfo: [ NSFilePathErrorKey : fileName ])
        }
       
        let wghJoined = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
        let wghString = wghJoined.componentsSeparatedByString("\n")
        let weights = wghString.map{ Double($0) ?? 0 }
        
        return weights
    }
    
}

