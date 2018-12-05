//
//  BannerViewController.swift
//  Demo
//
//  Created by apple on 2018/6/6.
//  Copyright © 2018年 zhang. All rights reserved.
//

import UIKit

class BannerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(ZBannerView.init(frame: CGRect.init(x: 10, y: 100, width: self.view.frame.width-20, height: 120)))
        // Do any additional setup after loading the view.
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
