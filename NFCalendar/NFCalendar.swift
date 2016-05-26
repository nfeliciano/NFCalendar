//
//  NFCalendar.swift
//  NFCalendarSample
//
//  Created by Noel Feliciano on 2016-03-25.
//  Copyright © 2016 nfsw. All rights reserved.
//

import UIKit

class NFCalendar: UIView, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let currentDate = NSDate()
    
    /*Initialization Classes
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        let scrollView = self.initializeScrollView()
        self.addSubview(scrollView)
        for page in 0...2 {
            let collectionView : UICollectionView = self.initializeCollectionView()
            collectionView.frame = CGRectMake(scrollView.bounds.size.width*CGFloat(page), collectionView.frame.origin.y, collectionView.frame.size.width, collectionView.frame.size.height)
            collectionView.tag = page
            scrollView.addSubview(collectionView)
        }
        scrollView.setContentOffset(CGPointMake(scrollView.bounds.size.width, 0), animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    //TODO: add more convenience init classes?
    
    func initializeScrollView() -> UIScrollView {
        let scrollView : UIScrollView = UIScrollView.init(frame: self.bounds)
        scrollView.delegate = self
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*3, scrollView.frame.size.height)
        scrollView.scrollEnabled = true
        scrollView.pagingEnabled = true
        scrollView.backgroundColor = UIColor.redColor()
        return scrollView
    }
    
    func initializeCollectionView() -> UICollectionView {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectionView : UICollectionView = UICollectionView.init(frame: self.frame, collectionViewLayout: layout)
        collectionView.registerNib(UINib(nibName: "NFCalendarCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        collectionView.registerNib(UINib(nibName: "NFCalendarHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.orangeColor()
        collectionView.scrollEnabled = false
        
        return collectionView
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:NFCalendarCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! NFCalendarCell
        
        var date = currentDate
        if (collectionView.tag == 0) {
            date = date.lastMonth()
        } else if (collectionView.tag == 2) {
            date = date.nextMonth()
        }
        
        // -1 to account for 'whichWeekday' being a nonZero number, and -1 to account for indexPath.row starting at 0
        let firstDay = date.firstDayOfMonth().whichWeekday() - 2
        
        // The last days of the month before
        if (indexPath.row < firstDay+1) {
            let lastMonth: NSDate!
            if (date.whichMonth() == 1) {
                lastMonth = NSDate(year: date.whichYear()-1, month: 12, day: 1)
            }
            else {
                lastMonth = NSDate(year: date.whichYear(), month: date.whichMonth()-1, day: 1)
            }
            
            cell.cellLabel.text = "\(lastMonth.numDaysInMonth()-firstDay+indexPath.row)"
            cell.cellLabel.textColor = UIColor.grayColor()
        }
        else if (indexPath.row <= date.numDaysInMonth() + firstDay) {
            cell.cellLabel.text = "\(indexPath.row-firstDay)"
        }
        // The first days of the month after
        else {
            cell.cellLabel.text = "\((indexPath.row-firstDay-date.numDaysInMonth()))"
            cell.cellLabel.textColor = UIColor.grayColor()
        }
        return cell
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentDate.numCalendarSlotsInMonth()
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header:NFCalendarHeader = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", forIndexPath: indexPath) as! NFCalendarHeader
        var date = currentDate
        if (collectionView.tag == 0) {
            date = date.lastMonth()
        } else if (collectionView.tag == 2) {
            date = date.nextMonth()
        }
        header.monthLabel.text = "\(date.whichYear()) \(date.monthName(false))"
        return header
    }
    
    // MARK: UICollectvionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let rect = collectionView.frame
        
        var unitHeight:CGFloat = rect.height-60
        if (collectionView.numberOfItemsInSection(0) <= 28) {
            unitHeight = unitHeight / 5
        }
        else if (collectionView.numberOfItemsInSection(0) <= 35) {
            unitHeight = unitHeight / 6
        }
        else {
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
