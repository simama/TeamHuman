//
//  ViewController.swift
//  Gera
//
//  Created by Marko Simic on 11/27/15.
//  Copyright © 2015 Human. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var xgValue: UILabel!
    @IBOutlet weak var ygValue: UILabel!
    @IBOutlet weak var zgValue: UILabel!
    @IBOutlet weak var xaValue: UILabel!
    @IBOutlet weak var yaValue: UILabel!
    @IBOutlet weak var zaValue: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var detectionModeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.recordButton.setTitle("Record", forState: UIControlState.Normal)
        self.detectionModeButton.setTitle("Detect", forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toggleButtonName(sender: UIButton) {
        if self.recordButton.selected == false {
            self.recordButton.selected = true
            self.recordButton.setTitle("Stop", forState: UIControlState.Selected)
        }
        else {
            self.recordButton.selected = false
            self.recordButton.setTitle("Record", forState: UIControlState.Normal)
        }
    }
    @IBAction func toggleButtonDetect(sender: UIButton) {
        if self.detectionModeButton.selected == false {
            self.detectionModeButton.selected = true
        }
        else {
        //if self.detectionModeButton.selected == true {
            self.detectionModeButton.selected = false
        }

    }
    

}

