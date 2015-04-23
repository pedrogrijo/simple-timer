//
//  ViewController.swift
//  SimpleStopwatch
//
//  Created by Pedro Rodrigues Grijó on 4/17/15.
//  Copyright (c) 2015 Pedro Rodrigues Grijó. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var startTime = NSTimeInterval()
    var saveElapsedTime = NSTimeInterval()
    var timer = NSTimer()
    var userStartTime = 1500.0
    var timeInterval = Double()
    var timerStopped = true

    
    func formatTime(elapsedTime: Double){
        
        //calculate the minutes in elapsed time.
        let minutes = Int(elapsedTime / 60.0)
        
        //calculate the seconds in elapsed time.
        let seconds = Int(elapsedTime % 60)
        
        //find out the fraction of centiseconds to be displayed.
        let fraction = Int((elapsedTime - floor(elapsedTime)) * 100)
        
        //add the leading zero for minutes, seconds and centiseconds and store them as string constants
        let strMinutes = minutes > 9 ? String(minutes):"0" + String(minutes)
        let strSeconds = seconds > 9 ? String(seconds):"0" + String(seconds)
        let strFraction = fraction > 9 ? String(fraction):"0" + String(fraction)
        
        //concatenate minutes, seconds and milliseconds as assign it to the UILabel
        displayTimeLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
    }
    
    func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = startTime - currentTime
        
        //Saves the elapsed time
        saveElapsedTime = elapsedTime
        
        formatTime(elapsedTime)
        
    }
    
    //Labels
    @IBOutlet weak var displayTimeLabel: UILabel!
    
    
    //Start/Pause button
    @IBAction func start(sender: AnyObject) {
        if !timer.valid && timerStopped{
            timerStopped = false
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate() + timeInterval
        }
        else if timer.valid && !timerStopped{
            timer.invalidate()
            timeInterval = Double(saveElapsedTime)
            timerStopped = true
        }
        
    }
    
    //Reset button. Resets the timer to the interval chosen by the user
    @IBAction func reset(sender: AnyObject) {
        
        if timer.valid{
            timer.invalidate()
        }
        timeInterval = userStartTime
        formatTime(timeInterval)
        timerStopped = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timeInterval = userStartTime
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

