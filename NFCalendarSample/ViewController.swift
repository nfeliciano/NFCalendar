//
//  ViewController.swift
//  NFCalendarSample
//
//  Created by Noel Feliciano on 2016-03-25.
//  Copyright © 2016 nfsw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let x: NFCalendar = NFCalendar.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 400))
        self.view.addSubview(x)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

