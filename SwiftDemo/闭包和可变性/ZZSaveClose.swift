//
//  ZZSaveClose.swift
//  SwiftDemo
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit
/*
 “在 unowned 和 weak 之间进行选择
 
 在你的 API 中，是应该选择使用 unowned 呢，还是应该使用 weak？从根本上来说，这个问题取决于相关对象的生命周期。如果这些对象的生命周期互不相关，也就是说，你不能保证哪一个对象存在的时间会比另一个长，那么弱引用就是唯一的选择。
 
 另一种情况下，如果你可以保证非强引用对象拥有和强引用对象同样或者更长的生命周期的话，unowned 引用通常会更方便一些。这是因为我们可以不需要处理可选值，而且变量将可以被 let 声明，而与之相对，弱引用必须被声明为可选的 var。同样的生命周期是很常见的，特别是当两个物体拥有主从关系的时候。当主对象通过强引用控制子对象的生命周期，而且你可以确定没有其他对象知道这个子对象的“的存在时，子对象对主对象的逆向引用就可以是 unowned 引用。
 
 unowned 引用要比 weak 引用少一些性能损耗，因此访问一个 unowned 引用的属性或者调用它上面的方法都会稍微快一些；不过，这个因素应该只在性能非常重要的代码路径上才需要被考虑。
 
 unowned 引用带来的不好的地方当然是如果你在生命周期的假设上犯了错，那么你的程序就将崩溃。个人来说，我发现我自己经常会在 unowned 也可以使用的情况下，还是去选择用 weak。weak 将强制我们在所有使用的地方都去检查引用是否”

*/
extension ViewController{
    
    func saveClose() {
        var c = uniqueIntegerProvide()
        var d = uniqueIntegerProvide()
        for i  in 0..<50 {
            let a = uniqueIntegerProvide()
            let b = a()
            print(b)
            
            if i == 2{
                d = a
            }
            if i == 3{
                c = a
            }
        }
//        let g = 3.biggerThanOther(<#T##other: Int##Int#>)
        let b = c()
        print(b)
        
        print("\(d()),\(d())")
    }
    
    func uniqueIntegerProvide() -> ()->Int {
        var i = 0
        return {
            i += 1
            return i
        }
    }
}

extension Int{
    func biggerThanOther(_ other:Int)->Bool{
        return self > other
    }
}
