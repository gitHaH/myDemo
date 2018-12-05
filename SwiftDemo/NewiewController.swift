//
//  YDOpenClassVC.swift
//  yunduoketang
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 fwang. All rights reserved.
//

import UIKit

class YDOpenClassVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let classTableView = UITableView.init(frame: CGRect.zero, style: .plain)
    
    let lineV = UIView.init(frame: CGRect.zero)
    
    fileprivate let cell_identifer = "OpenClassTableViewCell"
    
    var headViews = [UIView]()
    var needLogin = true
    var page = 1
    var _totalPage = 9999
    
    var isLive = false
    var data = [TestModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let titleArr = ["从前有座山","从前有座山从前有座山从前有座山从前有座山从前有座山从前有座山从前有座山从前有座山从前有座山从前有座山从前有座山从前有座山从前有座山从前有座山从前有座山","从前有座山从前有座山从前有座山从前有座山","从前有从前有座山从前有座山座山","从前有从前有座山从前有座山从前有座山从前有座山从前有座山从前有座山从前有座山座山"]
        for i in 0..<5{
            let model = TestModel()
            model.title = titleArr[i]
            model.time = "2018年x月y日"
            model.teacher = i == 0 ? []:i==1 ? ["这个老师"]: i == 2 ? ["这个老师","这个老","这个","这"]: i == 3 ? ["这个老师","这个老师","这个老师","这个老师"]:["这个老师","这个老师父"]
            model.limit = "限购一千   已购八百"
            model.money = "999999"
            data.append(model)
        }
        buildTableView()
        //        self.getStatusCode()
        // Do any additional setup after loading the view.
    }
    
    func buildTableView(){
        
        classTableView.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight-64)
        classTableView.backgroundColor = UIColor.clear
        classTableView.delegate = self
        classTableView.dataSource = self
        //        classTableView.rowHeight = 98
        //      classTableView.estimatedRowHeight = 133
        //        classTableView.separatorInset = UIEdgeInsetsMake(0, 35, 0, 0)
        //        classTableView.register(UINib.init(nibName: "OpenClassTableViewCell", bundle: nil), forCellReuseIdentifier: cell_identifer)
        classTableView.register(UINib.init(nibName: "YDHomeCoursesCell", bundle: nil), forCellReuseIdentifier: cell_identifer)
        self.view.addSubview(classTableView)
        
        
        
    }
    
    
    // MARK: - tableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5//classModelArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//classModelArr[section].classes.count
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 0{
            return UITableViewAutomaticDimension
        }else{
            return 133.0
        }
    }
    //
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return 133
        }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_identifer) as! YDHomeCoursesCell
        cell.model = data[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
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
