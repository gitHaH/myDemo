//
//  GuideViewController.swift
//  yunduoketang
//
//  Created by caolixiao on 2017/6/19.
//  Copyright © 2017年 fwang. All rights reserved.
//

import Foundation
import UIKit

public let GuideViewControllerDidFinish = "GuideViewControllerDidFinish"
public let kEneterViewControllerDidFinish = NSNotification.Name(rawValue: "kEneterViewControllerDidFinish")

class GuideCell: UICollectionViewCell {
    private let newImageView = UIImageView(frame: ScreenBounds)
    private let nextButton = UIButton(frame: CGRect(x: (ScreenWidth - CGScale(165)) * 0.5, y: ScreenHeight - CGScale(121), width: CGScale(165), height: CGScale(33)))
    
    var newImage: UIImage? {
        didSet {
            newImageView.image = newImage
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        newImageView.contentMode = .scaleAspectFill
        contentView.addSubview(newImageView)

        nextButton.backgroundColor = UIColor.clear
        nextButton.addTarget(self, action: #selector(GuideCell.nextButtonClick), for: UIControlEvents.touchUpInside)
        nextButton.isHidden = true
        contentView.addSubview(nextButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nextButton.frame = self.bounds
    }
    
    func setNextButtonHidden(hidden: Bool) {
        nextButton.isHidden = hidden
    }
    
    // GuideViewControllerDidFinish 还有一处在app.delegate中 进入到主界面中使用的
    @objc func nextButtonClick() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: GuideViewControllerDidFinish), object: nil)
    }
}



public let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height
public let ScreenBounds: CGRect = UIScreen.main.bounds

class GuideViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    private var collectView: UICollectionView?
    private var imageNames = ["guideone", "guidetwo", "guidethree"]
    private let cellIdentifier = "GuideCell"
    private var isHiddenNextButton = true
    let scr = UIScrollView.init(frame: ScreenBounds)
    private var pageController = UIPageControl(frame: CGRect(x:0, y:(ScreenHeight - 50), width:ScreenWidth, height:20))
    
    deinit {
        print("GuideViewController deinit =========");
    }
    
    @IBAction func click(_ sender: Any) {
        self.navigationController?.pushViewController(ZStackViewController(), animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        buildCollectionView()
    
        tfuncDealTest()
        
        scr.delegate = self
        scr.isPagingEnabled = true
        scr.bounces = true
        scr.contentSize = CGSize.init(width: CGFloat(imageNames.count)*ScreenWidth, height: 0)

        for (index,str) in imageNames.enumerated() {
            let img = UIImageView.init(frame: CGRect.init(x: ScreenWidth*CGFloat(index), y: 0, width: ScreenWidth, height: ScreenHeight))
            img.image = UIImage.init(named: str)
            scr.addSubview(img)
        }
        self.view.addSubview(scr)
        buildPageController()
    }
    
    // MARK: - Build UI
    private func buildCollectionView() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = ScreenBounds.size
        layout.scrollDirection = .horizontal
        
        collectView = UICollectionView(frame: ScreenBounds, collectionViewLayout: layout)
        collectView?.delegate = self
        collectView?.dataSource = self
        collectView?.showsVerticalScrollIndicator = false
        collectView?.showsHorizontalScrollIndicator = false
        collectView?.isPagingEnabled = true
        collectView?.bounces = false
        collectView?.register(GuideCell.self, forCellWithReuseIdentifier: cellIdentifier)
        view.addSubview(collectView!)
    }
    
    func buildPageController() {
        pageController.numberOfPages = imageNames.count
        pageController.currentPage = 0
//        view.addSubview(pageController)
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! GuideCell
        cell.newImage = UIImage(named: imageNames[indexPath.row])
        if indexPath.row != imageNames.count - 1 { // 3
            cell.setNextButtonHidden(hidden: true) // 如果不是第三张就隐藏button
        }
        return cell
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.x<0{
            print("end draging")
            scrollView.setContentOffset(CGPoint.init(x: ScreenWidth*2, y: 0), animated: false)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.x == ScreenWidth * CGFloat(imageNames.count - 1) {
//
//            let cell = collectView!.cellForItem(at: IndexPath.init(row: imageNames.count - 1, section: 0)) as! GuideCell
//            cell.setNextButtonHidden(hidden: false)
//            isHiddenNextButton = false
//        }
        print("结束减速后的偏移---\(scrollView.contentOffset.x)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        if scrollView.contentOffset.x != ScreenWidth * CGFloat(imageNames.count - 1) && !isHiddenNextButton && scrollView.contentOffset.x > ScreenWidth * CGFloat(imageNames.count - 2) {
            let cell = collectView!.cellForItem(at: IndexPath.init(row: imageNames.count - 1, section: 0)) as! GuideCell
            cell.setNextButtonHidden(hidden: true)
            isHiddenNextButton = true
        }
        pageController.currentPage = Int(scrollView.contentOffset.x / ScreenWidth + 0.5)
    }
    
//    override var shouldAutorotate :Bool {
//        return false
//    }
//    
//    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
//        return UIInterfaceOrientationMask.portrait
//    }
//    override var preferredInterfaceOrientationForPresentation : UIInterfaceOrientation {
//        return UIInterfaceOrientation.portrait
//    }
}

