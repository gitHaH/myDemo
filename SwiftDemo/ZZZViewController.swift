//
//  ZZZViewController.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class ZZZViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tab:UITableView!
    var img:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tab = UITableView.init(frame: view.bounds)
        tab.delegate = self
        tab.dataSource = self
        view.addSubview(tab)
        
        let img = UIImageView.init(frame: tab.frame)
        img.image = UIImage.init(named: "1")
        self.img = img
        tab.insertSubview(img, at: 0)
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 50))
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var frame:CGRect! = self.img.frame
        frame.size.height += 300
        self.img.frame = frame
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
