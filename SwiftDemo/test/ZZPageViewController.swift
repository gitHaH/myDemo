//
//  ZZPageViewController.swift
//  SwiftDemo
//
//  Created by apple on 2018/10/19.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class ZZPageViewController: UIViewController,UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    var content = ""
    var current = 0
    var pageArr = [NSMutableAttributedString]()
    var models = [ChapterModel]()
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if current == 0{
           return nil
        }else{
            current -= 1
            return getVC(str: pageArr[current])
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if current == pageArr.count-1{
            return nil
        }else{
            current += 1
            return getVC(str: pageArr[current])
        }
    }
    
    let pageVC = UIPageViewController.init(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        pageVC.delegate = self
        pageVC.dataSource = self
        self.addChildViewController(pageVC)
        self.view.addSubview(pageVC.view)
        dealData()
//        self.didMove(toParentViewController: self)
        // Do any additional setup after loading the view.
    }

    func dealData(){
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "郭黄之恋", ofType: "txt")!)
        if let contentStr = try? String.init(contentsOf: url, encoding: .utf8){
            content = contentStr
            let results = cutChapter(content: content)
            var titleRange = NSMakeRange(0, 0)
            
            if results.count>0{
                titleRange = results.first!.range
            }
            
            var endIndex = content.startIndex
            var titles = [String]()
            
            for (index,result) in results.enumerated(){
                let startIndex = content.index(content.startIndex, offsetBy: result.range.location)
                endIndex = content.index(startIndex, offsetBy: result.range.length)
                let currentTitle = String(content[startIndex...endIndex])
                titles.append(currentTitle)
                
                let model = ChapterModel()
                model.chapterIndex = index+1
                model.title = currentTitle
                model.path = ""
                models.append(model)
            }
            cutPages(models[0])
        }
        
    }
    
    // 获取章节range
    func cutChapter(content:String) ->[NSTextCheckingResult]{
        let pattern = "第[ ]*[0-9一二三四五六七八九十百千]*[ ]*[章回].*"
        let regExp = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        let results = regExp.matches(in: content, options: .reportCompletion, range: NSMakeRange(0, content.count))
        return results
    }
    // 章节分页
    func cutPages(_ model:ChapterModel){
        let result = cutChapter(content: content)[model.chapterIndex-1]
        
        let size = CGSize.init(width: ScreenWidth-20, height: ScreenHeight-74)
        let att = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15)]
        let orginMuStr = NSMutableAttributedString.init(string: content, attributes: att)
        let textStorage = NSTextStorage.init(attributedString: orginMuStr)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        var i = 0
        while true {
            i+=1
            let textContainer = NSTextContainer.init(size: size)
            layoutManager.addTextContainer(textContainer)
            let range = layoutManager.glyphRange(for: textContainer)
            if range.length <= 0{
                break
            }
            let contentStr = content as NSString
            let str = contentStr.substring(with: range)
            let attStr = NSMutableAttributedString.init(string: str, attributes: att)
            pageArr.append(attStr)
        }
        pageVC.setViewControllers([getVC(str: pageArr[0])], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        print(pageArr)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVC(str:NSAttributedString)->UIViewController{
        let vc = UIViewController()
        
        let img = UIImageView.init(frame: vc.view.frame)
        img.image = UIImage.init(named: "bg")
        vc.view.addSubview(img)
        
        let textView = UITextView.init(frame: CGRect.init(x: 10, y: 69, width: ScreenWidth-20, height: ScreenHeight-74))
        textView.attributedText = str
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 15)
        vc.view.addSubview(textView)
        return vc
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        showMenuItemView(action, withSender: sender)
        return false
    }
    
    func showMenuItemView(_ action: Selector, withSender sender: Any?){
//        self.becomeFirstResponder()
        let menuController = sender as! UIMenuController
        
////        let menuController = UIMenuController.shared
//        let copyItem = UIMenuItem.init(title: "复制", action: #selector(ZZPageViewController.copy))
//        let noteItem = UIMenuItem.init(title: "笔记", action: #selector(ZZPageViewController.note))
//
//        menuController.menuItems = [copyItem, noteItem]
//        menuController.update()
//        var rect: CGRect = CGRect()
////        if selectedLineArray.first != nil {
////            rect = selectedLineArray.first!
////        }
////        menuController.setTargetRect(action., in: self)
//        menuController.setMenuVisible(true, animated: true)
    }
    func copy(){
        
    }
    @objc func note(){
        
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

class MyView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TextVC: UIViewController {
    fileprivate let label = UILabel.init(frame: CGRect.init(x: 10, y: 10, width: 355, height: ScreenHeight-70))
    
    var text = "" {
        didSet{
            label.text = text
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        self.view.addSubview(label)
    }
}

class Model: NSObject {
//    var
}

class ChapterModel: NSObject {
    
    var title: String?
    var path: String?
    var chapterIndex: Int = 1
}
