//
//  WritingCopyVC.swift
//  SwiftDemo
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

extension ViewController{
    func writeCopy(){
        var x = Box.init(NSMutableData())
        let isUnique = isKnownUniquelyReferenced(&x)
//        var y = x
        print(isUnique)
    }
    
    func whatIsWriteCopy(){
        // 写时复制 “每当数组被改变，它首先检查它对存储缓冲区的引用是否是唯一的，或者说，检查数组本身是不是这块缓冲区的唯一拥有者。如果是，那么缓冲区可以进行原地变更；也不会有复制被进行。不过，如果缓冲区有一个以上的持有者 (如本例中)，那么数组就需要先进行复制，然后对复制的值进行变化，而保持其他的持有者不受影响。”
        let input: [UInt8] = [0x0b,0xad,0xf0,0x0d]
        let other: [UInt8] = [0x0d]
        var d = Data(bytes: input)
        let e = d
        d.append(contentsOf: other)
        print("\(d)  and e \(e)")
        
        
        let f = NSMutableData.init(bytes: input, length: input.count)
        let g = f
        f.append(other, length: other.count)
        print("\(g)\n\(f)")
        
        
    }
}

class Box<A> {
    var unBox:A
    init(_ value:A) {
        self.unBox = value
    }
}

struct MtData {
    private var _data : Box<NSMutableData>
    var _dataForWriting:NSMutableData{
        mutating get{
            if !isKnownUniquelyReferenced(&_data){
                _data = Box.init(_data.unBox.mutableCopy() as! NSMutableData
                )
                print("copy")
            }
            return _data.unBox
        }
    }
    init() {
        _data = Box(NSMutableData())
    }
    init(_ data:NSData) {
        _data = Box.init(data.mutableCopy() as! NSMutableData)
    }
}


