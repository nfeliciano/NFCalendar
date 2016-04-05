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
        return cell
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let today = NSDate()
        return today.numDaysInMonth()
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header:NFCalendarHeader = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", forIndexPath: indexPath) as! NFCalendarHeader
        header.monthLabel.text = "January"
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
