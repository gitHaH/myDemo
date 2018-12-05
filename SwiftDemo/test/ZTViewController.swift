//
//  ZTViewController.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class ZTViewController: UIViewController {

    var red:UIView!
    var green:UIView!
    var yellow:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        let v =  ZZCircleBackView.init(frame: CGRect.init(x: 0, y: 150, width: ScreenWidth, height: 250), andData: [5.2,3.6,7.8,8.3,5.4,4.9,11.3,28.2], colorArr: ["111111","551155","119911","ffdd11","dd11ff","abaf4d","111111","666666"])
//        view.addSubview(v!)
        
        red = UIView.init(frame: CGRect.init(x: 70, y: 70, width: 270, height: 100))
        red.backgroundColor = .red
        view.addSubview(red)
        
        green = UIView.init(frame: CGRect.init(x: 10, y: 10, width: 10, height: 10))
        green.backgroundColor = .green
        red.addSubview(green)
        
        yellow = UIView.init(frame: CGRect.init(x: 10, y: 40, width: 10, height: 10))
        yellow.backgroundColor = .yellow
        red.addSubview(yellow)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("")
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
