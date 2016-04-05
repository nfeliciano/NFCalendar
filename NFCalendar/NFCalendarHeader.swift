//
//  NFCalendarHeader.swift
//  NFCalendarSample
//
//  Created by Noel Feliciano on 2016-03-26.
//  Copyright © 2016 nfsw. All rights reserved.
//

import UIKit

class NFCalendarHeader: UICollectionReusableView {

    @IBOutlet weak var dayOne: UILabel!
    @IBOutlet weak var dayTwo: UILabel!
    @IBOutlet weak var dayThree: UILabel!
    @IBOutlet weak var dayFour: UILabel!
    @IBOutlet weak var dayFive: UILabel!
    @IBOutlet weak var daySix: UILabel!
    @IBOutlet weak var daySeven: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
