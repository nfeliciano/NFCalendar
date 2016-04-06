//
//  NFCalendar.swift
//  NFCalendarSample
//
//  Created by Noel Feliciano on 2016-03-25.
//  Copyright © 2016 nfsw. All rights reserved.
//

import UIKit

class NFCalendar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    /*Initialization Classes
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.initializeCollectionView())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    //TODO: add more convenience init classes
    
    func initializeCollectionView() -> UICollectionView {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectionView:UICollectionView = UICollectionView.init(frame: self.frame, collectionViewLayout: layout)
        collectionView.registerNib(UINib(nibName: "NFCalendarCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
//        collectionView.registerNib(UINib(nibName: "NFCalendarHeader", bundle: nil), forCellWithReuseIdentifier: "Header")
        collectionView.registerNib(UINib(nibName: "NFCalendarHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.orangeColor()
        
        return collectionView
    }
    
    // MARK: UICollectionViewDelegate
    
    // MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:NFCalendarCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! NFCalendarCell
        let date = NSDate()
        let firstDay = date.firstDayOfMonth().whichWeekday()
        if (indexPath.row < firstDay-1) {
            let lastMonth: NSDate!
            if (date.whichMonth() == 1) {
                lastMonth = NSDate(year: date.whichYear()-1, month: 12, day: 1)
            } else {
                lastMonth = NSDate(year: date.whichYear(), month: date.whichMonth()-1, day: 1)
            }
            
            // -1 to account for 'whichWeekday' being a nonZero number, and -1 to account for indexPath.row starting at 0
            cell.cellLabel.text = "\(lastMonth.numDaysInMonth()-(firstDay-2)+indexPath.row)"
            cell.cellLabel.textColor = UIColor.grayColor()
            
            //TODO: get number of days from last month
        } else {
            cell.cellLabel.text = "\(indexPath.row-firstDay+2)"
        }
        
        //TODO: add in leftover days for next month
        return cell
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NSDate().numCalendarSlotsInMonth()
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header:NFCalendarHeader = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", forIndexPath: indexPath) as! NFCalendarHeader
        header.monthLabel.text = "April"
        return header
    }
    
    // MARK: UICollectvionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let rect = collectionView.frame
        
        var unitHeight:CGFloat = rect.height-60
        if (collectionView.numberOfItemsInSection(0) <= 28) {
            unitHeight = unitHeight / 5
        } else if (collectionView.numberOfItemsInSection(0) <= 35) {
            unitHeight = unitHeight / 6
        } else {
            unitHeight = unitHeight / 8
        }
        return CGSizeMake(rect.width/7, unitHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(collectionView.frame.size.width, 60)
    }
}
