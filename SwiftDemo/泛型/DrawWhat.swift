//
//  DrawWhat.swift
//  SwiftDemo
//
//  Created by apple on 2018/9/26.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

extension ViewController{
    
}

protocol Drawing {
    func addEllipse(rect:CGRect,fill:UIColor)
    func addRectangle(rect:CGRect,fill:UIColor)
}

extension CGContext:Drawing{
    func addEllipse(rect: CGRect, fill: UIColor) {
        setFillColor(fill.cgColor)
        fillEllipse(in: rect)
    }
    
    func addRectangle(rect: CGRect, fill: UIColor) {
        setFillColor(fill.cgColor)
        self.fill(rect)
    }
}

struct SVG {
    func addCircle(){
        print("svg addCircle")
    }
}
extension SVG{
    func deleteCircle(){
        print("extension deleteCircle")
    }
}

protocol JustProtocol {
    func addCircle()
    func deleteCircle()
}
extension SVG:JustProtocol{
    
}
