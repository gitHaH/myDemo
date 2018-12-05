//
//  ZStackViewController.swift
//  SwiftDemo
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class ZStackViewController: UIViewController {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var btnShort: UIButton!
    @IBOutlet weak var btnLong: UIButton!
    var largeNum = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...2{
            let imageV = self.value(forKey: "img\(i+1)") as? UIImageView
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick(_:)))
            imageV?.tag = i+1
            imageV?.addGestureRecognizer(tap)
        }
        
        // Do any additional setup after loading the view.
    }

    @objc func tapClick(_ tap:UITapGestureRecognizer){
        let tag = tap.view?.tag ?? 0
        
        let arr = [1,2,3].filter({$0 != tag})
        let isLarge = tag == largeNum
        UIView.animate(withDuration: 0.6) {
            for (_,i) in arr.enumerated() {
                let imageV = self.value(forKey: "img\(i)") as? UIImageView
                imageV?.isHidden = !isLarge
            }
        }
        if isLarge{
           largeNum = 0
        }else{
           largeNum = tag
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shortClick(_ sender: Any) {
        titleLabel.numberOfLines = 1
        detailLabel.numberOfLines = 1
    }
    
    @IBAction func longClick(_ sender: Any) {
        titleLabel.numberOfLines = 0
        detailLabel.numberOfLines = 0
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
