//
//  TFunk.swift
//  SwiftDemo
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

extension GuideViewController{
    func tfuncDealTest() {
        let a = ["a", "b", "c", "d", "e", "f", "g"]
        let b = a.shuffled()
        print(b)
        
        let c = ZClass()
//        let arr = 
    }
}

extension Array{
    mutating func shuffle(){
        for i in 0..<(count-1){
            print("count = \(count)\ni = \(i)")
            let j = Int(arc4random_uniform(UInt32(count-i)))+i
            self.swapAt(i, j)
        }
    }
    
    func shuffled() -> [Element] {
        var clone = self
        clone.shuffle()
        return clone
    }

}

class ZClass:NSObject{
    var name = ""
    var age = 0
    required override init() {}
}
