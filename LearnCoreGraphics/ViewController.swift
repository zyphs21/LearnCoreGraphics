//
//  ViewController.swift
//  CoreGraphicTest
//
//  Created by Hanson on 16/8/8.
//  Copyright © 2016年 hanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var graphView: GraphicView!
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var averageWaterDrunk: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var medalView: MedalView!
    
    var isGraphViewShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkTotal()
        
        counterLabel.text = String(counterView.counter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnPushButton(button: PushButtonView) {
        if button.isAddButton {
            counterView.counter += 1
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        counterLabel.text = String(counterView.counter)
        
        if isGraphViewShowing {
            counterViewTap(nil)
        }
        
        checkTotal()
    }
    
    @IBAction func counterViewTap(gesture:UITapGestureRecognizer?) {
        if (isGraphViewShowing) {
            
            //hide Graph
            UIView.transitionFromView(graphView,
                                      toView: counterView,
                                      duration: 1.0,
                                      options: [.TransitionFlipFromLeft, .ShowHideTransitionViews],
                                      completion: nil)
        } else {
            
            //show Graph
            setupGraphDisplay()
            UIView.transitionFromView(counterView,
                                      toView: graphView,
                                      duration: 1.0,
                                      options: [.TransitionFlipFromRight, .ShowHideTransitionViews],
                                      completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
    }

    func setupGraphDisplay() {
        
        //Use 7 days for graph - can use any number,
        //but labels and sample data are set up for 7 days
//        let noOfDays:Int = 7
        
        //1 - replace last day with today's actual data
        graphView.graphPoints[graphView.graphPoints.count-1] = counterView.counter
        
        //2 - indicate that the graph needs to be redrawn
        graphView.setNeedsDisplay()
        
        maxLabel.text = "\(graphView.graphPoints.maxElement()!)"
        
        //3 - calculate average from graphPoints
        let average = graphView.graphPoints.reduce(0, combine: +) / graphView.graphPoints.count
        averageWaterDrunk.text = "\(average)"
        
        //set up labels
        //day of week labels are set up in storyboard with tags
        //today is last day of the array need to go backwards
        
        //4 - get today's day number
        _ = NSDateFormatter()
        let calendar = NSCalendar.currentCalendar()
        let componentOptions: NSCalendarUnit = .Weekday
        let components = calendar.components(componentOptions,
                                             fromDate: NSDate())
        var weekday = components.weekday
        
        let days = ["S", "S", "M", "T", "W", "T", "F"]
        
        //5 - set up the day name labels with correct day
        for i in (1...days.count).reverse() {
            if let labelView = graphView.viewWithTag(i) as? UILabel {
                if weekday == 7 {
                    weekday = 0
                }
                labelView.text = days[weekday]
                weekday -= 1
                if weekday < 0 {
                    weekday = days.count - 1
                }
            }
        }
    }
    
    func checkTotal() {
        if counterView.counter >= 8 {
            medalView.showMedal(true)
        } else {
            medalView.showMedal(false)
        }
    }
}

