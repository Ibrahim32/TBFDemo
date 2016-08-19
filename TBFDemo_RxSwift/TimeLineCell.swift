//
//  TimeLineCell.swift
//  TBFDemo_RxSwift
//
//  Created by khan on 18/08/16.
//  Copyright © 2016 TBF. All rights reserved.
//

import UIKit
import QuartzCore


class TimeLineCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var departureTime: UILabel!
    @IBOutlet weak var arrivalTime: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var noOfStops: UILabel!
    @IBOutlet weak var cardView: UIView!
    override func layoutSubviews() {
        setupCardLayout()
    }
    func setupCardLayout(){
        self.cardView.alpha = 1
        self.cardView.layer.masksToBounds = false
        self.cardView.layer.cornerRadius = 1
        self.cardView.layer.shadowOffset = CGSizeMake(-0.2, -0.2)
        self.cardView.layer.shadowRadius = 1
        let path = UIBezierPath(rect: self.cardView.bounds)
        self.cardView.layer.shadowPath = path.CGPath
        self.cardView.layer.shadowOpacity = 0.2
    }
    

    
    class func animate(cell:UITableViewCell) {
        let view = cell.contentView
        
        view.layer.transform = TimeLineCellAnimatorStartTransform
        view.layer.opacity = 0.8
        
        UIView.animateWithDuration(0.4) {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        }
    }
}
private let TimeLineCellAnimatorStartTransform:CATransform3D = {
    let rotationDegrees: CGFloat = -15.0
    let rotationRadians: CGFloat = rotationDegrees * (CGFloat(M_PI)/180.0)
    let offset = CGPointMake(-20, -20)
    var startTransform = CATransform3DIdentity
    startTransform = CATransform3DRotate(CATransform3DIdentity,
                                         rotationRadians, 0.0, 0.0, 1.0)
    startTransform = CATransform3DTranslate(startTransform, offset.x, offset.y, 0.0)
    
    return startTransform
}()
