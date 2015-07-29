//
//  ViewController.swift
//  WeatherGraph
//
//  Created by Jens Bruggemans on 29/07/15.
//  Copyright (c) 2015 Embur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let weatherGraphView = WeatherGraphView()
    weatherGraphView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 260)
    weatherGraphView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))
    self.view.addSubview(weatherGraphView)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

