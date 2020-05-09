//
//  AttributeViewController.swift
//  SwiftDemo
//
//  Created by 张萌 on 2020/4/10.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class AttributeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let tab = ARBaseScrollView.init(frame: CGRect.init(x: 0, y: 100, width: ScreenWidth, height: ScreenHeight-100))
    var models = [ZZAttModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        let arr = ["你真是","😈😊😣","你😣你","😣😣😣😣😣机灵鬼机灵鬼机灵鬼机"]
        
        for _ in 0..<20 {
            let model = ZZAttModel()
            var tex = ""
            for _ in 0..<Int(arc4random()%20){
                tex += arr[Int(arc4random()%4)]
            }
            model.text = tex
            models.append(model)
        }
        tab.shouldRefresh = true
        tab.refreshBlock = {[weak self] in
            self?.tab.endRefresh()
        }
        tab.delegate = self
        tab.dataSource = self
        tab.register(ZZCell.classForCoder(), forCellReuseIdentifier: "ZZCell")
        view.addSubview(tab)
//
//        let text = "你是个小机灵鬼😈😈机灵鬼😈😈😈😈😊😊😊机灵鬼😊😊😊😣机灵鬼😣😣机灵鬼😣😣机灵鬼😣机灵鬼机灵鬼机灵鬼机灵鬼机灵鬼机灵鬼机灵鬼机灵鬼机灵鬼机灵鬼机灵鬼机灵鬼机灵鬼"
//        let att = NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 26)])//NSAttributedString.init(string: text)
//
//        let label = UILabel.init(frame: CGRect.init(x: 20, y: 100, width: ScreenWidth-40, height: 170))
//        label.backgroundColor = .cyan
//        label.numberOfLines = 0
//        label.font = UIFont.systemFont(ofSize: 26)
//        label.attributedText = att
//        label.frame.size = label.sizeThatFits(CGSize.init(width: VIEWW(label), height: 400))
//        view.addSubview(label)
//
//
//        let textV = UITextView.init(frame: CGRect.init(x: VIEWX(label), y: VIEWMaxY(label)+20, width: VIEWW(label), height: 170))
//        textV.font = label.font
//        textV.attributedText = att
//        textV.frame.size = textV.sizeThatFits(CGSize.init(width: VIEWW(label), height: 400))
//        view.addSubview(textV)
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZZCell") as? ZZCell
        cell?.model = models[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return models[indexPath.row].height
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

class ZZCell: UITableViewCell {
    
    let label = UILabel.init()
    let textV = UITextView.init()
    var model:ZZAttModel = ZZAttModel.init(){
        didSet{
            let text = model.text
            let param = NSMutableParagraphStyle.init()
            param.lineSpacing = 10
            let att = NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.font:label.font,NSAttributedString.Key.paragraphStyle:param])//NSAttributedString.init(string: text)
            label.attributedText = att
            
            let size = CGSize.init(width: ScreenWidth-40, height: CGFloat.greatestFiniteMagnitude)
            label.frame = CGRect.init(origin: CGPoint.init(x: 20, y: 10), size: label.sizeThatFits(size))
            
            textV.attributedText = att
            textV.frame = CGRect.init(origin: CGPoint.init(x: VIEWX(label), y: VIEWMaxY(label)+20), size: textV.sizeThatFits(size))
            
            model.height = VIEWMaxY(textV)+20
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(textV)

        
        label.backgroundColor = .cyan
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 26)
        
        textV.backgroundColor = .yellow
        textV.font = label.font
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ZZAttModel {
    var text = ""{
        didSet{
            let label = UILabel()
            let param = NSMutableParagraphStyle.init()
            param.lineSpacing = 10
            let att = NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.font:label.font,NSAttributedString.Key.paragraphStyle:param])
            label.attributedText = att
            let h = CGSize.init(width: ScreenWidth-40, height: CGFloat.greatestFiniteMagnitude).height
            height = h*2 + 50
        }
    }
    var height:CGFloat = 0
}
