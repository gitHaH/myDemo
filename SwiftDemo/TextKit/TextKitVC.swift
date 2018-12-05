//
//  TextKitVC.swift
//  SwiftDemo
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class TextKitVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func initSubView(){
        let string = "第一章\n风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山\n神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙风雪山神庙"
        let muStr = NSMutableAttributedString.init(string: string)
        let size = CGSize.init(width: ScreenWidth-40, height: 50)
        let parastyle = NSMutableParagraphStyle.init()
        parastyle.alignment = .center
        parastyle.paragraphSpacing = 15
        let att = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15),
                   NSAttributedStringKey.paragraphStyle:parastyle]
        muStr.addAttributes(att, range: NSMakeRange(0, string.count))
        // 管理文字内容的容器
        let textStorage = NSTextStorage.init(attributedString: muStr)
        // 布局管理 给内容容器添加布局(可以添加多个)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        // 布局管理 - 内容管理
        let textContainer = NSTextContainer.init(size: size)
        layoutManager.addTextContainer(textContainer)
        
        let frame = layoutManager.usedRect(for: textContainer)
        // 给定size情况下 在该size内可显示的文字的范围 layoutManager会对其中的textContainers做文字内容分割
        let range = layoutManager.glyphRange(for: textContainer)
        
        // 局限内容显示区域
        let textV = UITextView.init(frame: CGRect.init(x: 20, y: 70, width: ScreenWidth-40, height: 80), textContainer: textContainer)
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
