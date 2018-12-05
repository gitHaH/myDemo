//
//  ZZMyButton.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class ZZMyButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print("yyyyyy x = \(point.x)  y = \(point.y)")
        let bo = CGRect.init(x: -60, y: -60, width: frame.size.width+120, height: frame.size.height+120)
//        let bo = bounds.insetBy(dx: -60, dy: -60)
        return bo.contains(point)
    }
}
