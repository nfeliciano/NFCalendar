//
//  NFCalendarCell.swift
//  NFCalendarSample
//
//  Created by Noel Feliciano on 2016-03-26.
//  Copyright © 2016 nfsw. All rights reserved.
//

import UIKit

class NFCalendarCell: UICollectionViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
