//
//  ZZSubscripViewController.swift
//  SwiftDemo
//
//  Created by 张萌 on 2020/4/10.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ZZSubscripViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(ZZSubScripModel()[2])
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class ZZSubScripModel{
    var name = "ZZSubScripModel"
    var arr = ["a","b","c"]
    subscript(_ index:Int)->String{
        guard arr.count > index else{return ""}
        return arr[index]
    }
}
