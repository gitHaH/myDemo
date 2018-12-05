//
//  CodeAndEncode.swift
//  SwiftDemo
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

extension ViewController{
    func codeTest() {
//        let places = [ZPlace.init(name: "bj", location: CGPoint.init(x: 1, y: 1)),ZPlace.init(name: "sh", location: CGPoint.init(x: 2, y: 2))]
        
        let animals = ["elephant", "zebra", "dog"]
        _ = animals.sorted { lhs, rhs in
            let l = lhs.reversed()
            let r = rhs.reversed()
            return l.lexicographicallyPrecedes(r)
        }
        
        
        let places = [ZZPlace.init(string: "bj", loca: CGPoint.init(x: 1, y: 1)),ZZPlace.init(string: "sh", loca: CGPoint.init(x: 2, y: 2))]
        let encode = JSONEncoder()
        if let jsonData = try? encode.encode(places){
            let jsonString = String.init(decoding: jsonData, as: UTF8.self)
            print(jsonString)
            decode(jsonData)
        }

    }
    
    func decode(_ jsonData:Data){
        let decode = JSONDecoder()
        if let devoded = try? decode.decode([ZZPlace].self, from: jsonData){
            print(devoded)
        }
        print("")
    }
}

struct ZPlace:Codable {
    var name:String
    var location:CGPoint
    
}
class ZZPlace: NSObject,Codable {
    var name = ""
    var location = CGPoint.zero
    init(string:String,loca:CGPoint) {
        super.init()
        name = string
        location = loca
    }
}
