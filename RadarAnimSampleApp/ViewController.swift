//
//  ViewController.swift
//  RadarAnimSampleApp
//
//  Created by Saddam Akhtar on 26/04/18.
//  Copyright © 2018 Saddam Akhtar. All rights reserved.
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

    @IBAction func view_tap(_ sender: UITapGestureRecognizer) {
        let radarAnim = RadarAnimationLayer()
        
        radarAnim.duration = 2.0
        radarAnim.color = UIColor.brown
        
        radarAnim.animate(startPoint: sender.location(in: self.view),
                          diameter: 160.0,
                          containerLayer: self.view.layer)
        
        radarAnim.animate(startPoint: sender.location(in: self.view),
                          diameter: 160.0,
                          containerLayer: self.view.layer,
                          startDiameter: 60)
    }
    
}

