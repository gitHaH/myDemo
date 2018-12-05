//
//  VarViewController.swift
//  SwiftDemo
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class VarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var arr1:Set = [1,2,4]
        let arr2:Set = [3,4]
        let arr3 = arr1.subtracting(arr2)
        print(arr3)// 1,2  补集
        print("")
        let arr4 = arr1.intersection(arr2)
        print(arr4)//
        
        
        let arr5 = arr1.formUnion(arr2)
        print(arr5)
        
        
//        let arr = [1,2,3,5,46,5,2,49].unique()
//        print(arr)
        
        let rangeArr1 = ...5
        
        let rangeArr3 = ..<10
        let rangeArr4 = 2...
        let rangeArr2 = Array(1...6)
        let a = 3
        print("\(rangeArr2[a...])")
        
        // Do any additional setup after loading the view.
    }

    //
    
    //合并
    func overrideDic(){
        /*
         merging
         dic3 是合并dic 和 dic2的集合，key相同的取dic得值
         dic3 ["B": "BEE", "A": "AN", "D": "DOO", "c": "CII"]
         */
        let dic = ["A":"AN","B":"BEE","D":"DOO"]
        let dic2 = ["A":"AI","B":"BYY","c":"CII"]
        let dic3 = dic2.merging(dic, uniquingKeysWith: {$1})
        print(dic3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension Sequence where Element:Hashable {
//    func unique() -> [Element] {
//        var seen:Set<Element> = []
//        return filter({ (element) -> Bool in
//            if seen.contains(element){
//                return false
//            }else{
//                seen.insert(element)
//                return true
//            }
//        })
//    }
//}
