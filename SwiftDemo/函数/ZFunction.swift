//
//  ZFunction.swift
//  SwiftDemo
//
//  Created by apple on 2018/9/14.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit
typealias SortDescriptor<Value> = (Value,Value)->Bool
extension ViewController{
    func function(){
        let peoples = [
            People(first: "Emily", last: "Young", yearOfBirth: 2002),
            People(first: "David", last: "Gray", yearOfBirth: 1991),
            People(first: "Robert", last: "Barnes", yearOfBirth: 1985),
            People(first: "Ava", last: "Barnes", yearOfBirth: 2000),
            People(first: "Joanne", last: "Miller", yearOfBirth: 1994),
            People(first: "Ava", last: "Barnes", yearOfBirth: 1998),
            ]
        ocDeal(peoples)
        swiftDeal(peoples)
        diyDeal(peoples)
        diyFunc(peoples)
        seque()
    }
    
    func ocDeal(_ peoples:[People]){
        // NSSortDescriptor
        let lastDescriptor = NSSortDescriptor.init(key: #keyPath(People.last), ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        let firstDes = NSSortDescriptor.init(key: #keyPath(People.first), ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        //        let firstDescriptor = NSSortDescriptor(key: #keyPath(People.first),
        //            ascending: true,
        //            selector: #selector(NSString.localizedStandardCompare(_:)))
        let yearDes = NSSortDescriptor.init(key: #keyPath(People.yearOfBirth), ascending: true)
        ///我们使用 NSArray 的 sortedArray(using:) 方法。这个方法可以接受一系列排序描述符。为了确定两个元素的顺序，它会先使用第一个描述符，并检查其结果。如果两个元素在第一个描述符下相同，那么它将使用第二个描述符
        let descriptors = [lastDescriptor,firstDes,yearDes]
        let a =  (peoples as NSArray).sortedArray(using: descriptors)
        print(a)
    }
    func swiftDeal(_ peoples:[People]){
        let pp = peoples.sorted(by: {
            let left = [$0.last,$0.first,String($0.yearOfBirth)]
            let right = [$1.last,$1.first,String($1.yearOfBirth)]
            return left.lexicographicallyPrecedes(right)
        })
        
        
        let ppp = peoples.sorted { (p1, p2) -> Bool in
            let left = [p1.last,p1.first]
            let right = [p2.last,p2.first]
            return left.lexicographicallyPrecedes(right, by: {
                $0.localizedStandardCompare($1) == .orderedAscending
            })
        }
        print(pp,ppp)
    }
    
    func diyDeal(_ peoples:[People]) {
//        let sortByYear:SortDescriptor<People> = {
//            return $0.yearOfBirth < $1.yearOfBirth
//        }
        let sortByName:SortDescriptor<People> = {
            return $0.last.localizedStandardCompare($1.last) == .orderedAscending
        }
        let a = peoples.sorted(by: sortByName)
        
        print(a)
    }
    
    func diyFunc(_ peoples:[People]){
//        let sortByYear:SortDescriptor<People> = mySortDescriptor(key: {$0.yearOfBirth}, by: <)
        
    }
    
    func mySortDescriptor<Value,Key>(key:@escaping(Value)->Key,by areinincreasingOrder:@escaping(Key,Key)->Bool)->SortDescriptor<Value>{
        return {areinincreasingOrder(key($0),key($1))}
    }
    
    
    func seque(){
        
        let a = ["a", "b", "c", "d", "e", "f", "g"]
        let r = a.reversed()
        
        let isEven = {
            $0%2 == 0
        }
        _ = (0..<5).contains(where: isEven)
        
        let isSub = [1,2,3].isSubSet(of: [1,2,3,4])
        let isStrSub = [1].isSubset(of: ["1","2"]) { (a, b) -> Bool in
            return String(a) == b
        }
        let isSimSub = [1].isSubset(of: ["1","2"], by: {String($0) == $1})
        print(isSub,isStrSub,isSimSub)
        
        
        
    }
    
}

/// @objcMembers，这样它的所有成员都将在 Objective-C 中可见
@objcMembers
final class People: NSObject {
    let first: String
    let last: String
    let yearOfBirth: Int
    init(first: String, last: String, yearOfBirth: Int) {
        self.first = first
        self.last = last
        self.yearOfBirth = yearOfBirth
    }
}
//“非泛型函数先于泛型函数”
/// 使用泛型约束进行重载


extension Sequence where Element:Hashable {
    func isSubSet(of other:[Element]) -> Bool {
        let otherSet = Set(other)
        for element in self{
            guard otherSet.contains(element)else{return false}
        }
        return true
    }
    
    func isSubset<S:Sequence>(of other:S)->Bool where S.Element == Element{
        let otherSet = Set(other)
        for element in self {
            guard otherSet.contains(element) else {return false}
        }
        return true
    }
}

extension Sequence{
    func isSubset<S:Sequence>(of other:S,by
        areEquivalent:(Element,S.Element)->Bool)
        ->Bool{
        
            for element in self {
                guard other.contains(where:{
                    areEquivalent(element,$0)
                })else{return false}
            }
            return true
    }
}


