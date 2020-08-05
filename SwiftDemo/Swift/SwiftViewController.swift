//
//  SwiftViewController.swift
//  SwiftDemo
//
//  Created by 张萌 on 2020/6/23.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        blockDeal()
    }
    
    //MARK: - 闭包
    var block = { (v1:Int,v2:Int) ->Int in
        v1+v2
    }
    
    func blockDeal(){
        let b = block(1,2)
        print(b)
    }
    
    //MARK: - 枚举
    enum Date {
        case digit(year:Int,month:Int,day:Int)
        case string(String)
    }
    
    func whatEnumConvenience(){
        var date = Date.digit(year: 2020, month: 6, day: 23)
        date = .string("2020-06-23")
        switch date {
        case .digit(year: let year, month: let month, day: let day):
            print("year is \(year) month is \(month) day is \(day)")
        case let .string(value):
            print(value)
        }
    }
    
    //MARK: - 结构体和类
    struct Point {
        var x = 10
        var y = 10
    }
    
    class Size {
        var w = 10
        var h = 10
    }
    
    func whatIsDiffenceAboutStructAndClass(){
        let p = Point()
        var pT = p
        pT.x = 20
        
        let s = Size()
        let sT = s
        sT.w = 20
        // 结构体 深复制 ；类 浅复制
        print(p.x,pT.x,"\n",s.w,sT.w)
        // 10  20 ； 20  20
    }
    
    //MARK:- 从5开始 累加2 不超过19 打印： 5 7 9 11 13 15 17
    func strideTest(){
        for i in stride(from: 5, to: 19, by: 2) {
            print(i)
        }
    }

    //MARK:- 贯穿效果 只管穿到下一个case
    func switchFallthrough(_ a:Int){
        switch a {
        case 1:
            print("1")
            fallthrough
        case 2:
            print("2")
            fallthrough
        case 3:
            print("3")
//            fallthrough
//            break
        default:
            print("4")
        }
    }
    
    //MARK:- where
    func whereUse(){
        let arr = [-1,20,-4,10]
        for i in arr where i > 0 {
            print(i)
        }
    }
    
    //MARK:- 标签语言 break oute 跳出大循环
    func outerUse(){
        oute: for i in 1...4{
            for k in 1...4 {
                if k == 3{
                    continue oute
                }
                if i == 1{
                    // 跳出内层循环
                    break
                }
                if i == 3{
                    // 跳出i的大循环
                    break oute
                }
                print("i = \(i)   j=\(k)")
            }
        }
    }
    
    //MARK:- 高阶套娃
    func kidOne(_ one:Int)->Int{
        one+1
    }
    
    func kidTwo(_ two:Int)->Int{
        two - 1
    }
    
    func kidKid(_ whichKid:Int) -> (Int)->Int{
        whichKid == 1 ? kidOne:kidTwo
    }
    
    func startEatKid(){
        print(kidKid(1)(2))
    }
    //MARK:- 函数返回可以省略return
    func returnString(_ str:String)->String{
        str + "return"
    }
    
    //MARK:- 注释
    /// 注释
    ///
    /// 注释的正确写法
    ///
    ///  - Parameter p1:第一个参数
    ///  - Parameter p2:第二个参数
    ///  - Parameter p3:不存在参数
    ///  - Returns: 一个返回值
    ///
    ///  - NOTE: 👻才写这么详细的注释
    ///
    func whatIsMark(_ p1:Int,p2:String) -> String {
        "\(p1) ---- \(p2)"
    }
    

}
