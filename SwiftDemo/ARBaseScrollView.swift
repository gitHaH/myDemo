//
//  ARBaseScrollView.swift
//  Arrail
//
//  Created by 张萌 on 2020/4/3.
//  Copyright © 2020 张萌. All rights reserved.
//

import UIKit

public class ARBaseScrollView: UITableView {

    public var refreshBlock:(()->Void)?
    public var loadMoreBlock:(()->Void)?
    
    fileprivate lazy var animationView:ARAnimationView = {
        let v = ARAnimationView.init(frame: CGRect.init(x: 0, y: -200, width: ScreenWidth, height: 200))
        
        return v
    }()
    
    fileprivate lazy var bottomPullView:ARBottomPullAnimationView = {
        let v = ARBottomPullAnimationView.init(frame: CGRect.init(x: 0, y: ScreenHeight, width: ScreenWidth, height: CGScale(50)))
        return v
    }()
    
    public var shouldRefresh = false{
        didSet{
            guard animationView.superview == nil else{return}
            addSubview(animationView)
            guard bottomPullView.superview == nil else{return}
            addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        }
    }
   
    public var shouldPull = false{
        didSet{
            guard bottomPullView.superview == nil else{return}
            addSubview(bottomPullView)
            guard animationView.superview == nil else{return}
            addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        }
    }
    
   
    
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "contentOffset" else{return}
        guard let scrollView = object as? ARBaseScrollView else{return}
        let y = scrollView.contentOffset.y
        if y > 0 && shouldPull{
            // 上拉加载
            let dis = scrollView.contentSize.height-VIEWH(scrollView)
            if y >= dis {
                bottomPullView.frame.origin.y = scrollView.contentSize.height
                bottomPullView.startPull()
                if scrollView.isDecelerating && (dis>VIEWH(bottomPullView) || dis<0){
                    scrollDeal(false)
                }
                
            }
        }else if y < 0 && shouldRefresh{
            // 下拉刷新
            if y>animationView.rate {
                animationView.rate = y
                if (y <= -__NavH && scrollView.isDecelerating) {
                    scrollDeal(true)
                }
            }else{
                animationView.rate = y
            }
        }
        
    }
    
    @objc fileprivate func animationsDo(){
        UIView.animate(withDuration: 0.3, animations: {
            self.animationView.endAnimation()
            self.bottomPullView.endAnimation()
            self.contentInset = UIEdgeInsets.zero
        }) { (completed) in
            self.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        }
    }
    
    //MARK: - 下拉刷新
    fileprivate func scrollDeal(_ isRefresh:Bool){
        self.removeObserver(self, forKeyPath: "contentOffset")
        isScrollEnabled = false
        if isRefresh{
            animation()
        }else{
            pullAnimation()
        }
    }
    
    fileprivate func animation(){
        UIView.animate(withDuration: 0.6, animations: {
            self.contentInset = UIEdgeInsets.init(top: __NavH, left: 0, bottom: 0, right: 0)
            self.animationView.startAnimation()
        }) { (completed) in
            if completed && self.animationView.isAnimating{
                self.refresh()
            }
        }
    }
    
    fileprivate func refresh(){
        refreshBlock?()
    }
    
    public func endRefresh(){
//        if (self.contentOffset.y==0) {
//            return;
//        }
        if (!self.isScrollEnabled) {
            self.isScrollEnabled = true;
            animationView.endRefresh("刷新成功")
            perform(#selector(animationsDo), with: nil, afterDelay: 0.2)
        }
    }
    //MARK: - 上拉加载
    fileprivate func pullAnimation(){
        UIView.animate(withDuration: 0.6, animations: {
            self.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: -VIEWH(self.bottomPullView), right: 0)
            self.bottomPullView.startAnimation()
        }) { (completed) in
            if completed && self.bottomPullView.isAnimating{
                self.loadMoreBlock?()
            }
        }
    }
    
    
    public func endRefreshFooter(){
        if (!self.isScrollEnabled) {
            self.isScrollEnabled = true;
            bottomPullView.endRefresh("已加载")
            perform(#selector(animationsDo), with: nil, afterDelay: 0.2)
        }
    }
    
    deinit {
        if shouldRefresh || shouldPull{
            self.removeObserver(self, forKeyPath: "contentOffset")
        }
    }
}

class ARAnimationView: UIView {
    fileprivate var animationImageView = UIImageView.init(image: UIImage.init(named: "icon_xiala_one"))
    fileprivate var resultLabel = UILabel.init()
    var rate:CGFloat = 0{
        didSet{
            bigBigBig()
        }
    }
    
    var isAnimating:Bool {
        get {return animationImageView.isAnimating}
    }
    
    public func endRefresh(_ txt:String){
        resultLabel.text = txt
        resultLabel.isHidden = false;
        animationImageView.isHidden = true;
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imgNameArr = ["icon_xiala_one","icon_xiala_two"]
        var imgArr = [UIImage]()
        for imgName in imgNameArr {
            let img = UIImage.init(named: imgName) ?? UIImage.init()
            imgArr.append(img)
        }
        animationImageView.frame = CGRect.init(x: VIEWW(self)/2, y: VIEWH(self)-2, width: 1, height: 1)
        animationImageView.animationImages = imgArr
        addSubview(animationImageView)
        
        resultLabel.textColor = __RGB(0x666666)
        resultLabel.frame = CGRect.init(x: 10, y: VIEWH(self)-CGScale(38), width: VIEWW(self)-20, height: CGScale(18))
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 16)
        addSubview(resultLabel)
    }
    
   
    
    public func startAnimation(){
        animationImageView.startAnimating()
    }
    public func endAnimation(){
        animationImageView.stopAnimating()
    }
    
    fileprivate func bigBigBig(){
        resultLabel.isHidden = true
        animationImageView.isHidden = false
        
        let off:CGFloat = min(rate * -1, __NavH)
        let wid = 0.42*off
        let height = 0.81*off
        animationImageView.frame = CGRect.init(x: (VIEWW(self)-wid)/2, y: VIEWH(self)-height, width: wid, height: height)
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
}

// 上拉加载
class ARBottomPullAnimationView:UIView{
    fileprivate var animationImageView = UIActivityIndicatorView.init(frame: CGRect.zero)
    fileprivate var resultLabel = UILabel.init()
 
    let wid = CGScale(15)
    
    var isAnimating:Bool {
        get {return animationImageView.isAnimating}
    }
    
    public func endRefresh(_ txt:String){
        resultLabel.text = txt
        resultLabel.isHidden = false;
        animationImageView.isHidden = true;
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imgNameArr = ["icon_xiala_one","icon_xiala_two"]
        var imgArr = [UIImage]()
        for imgName in imgNameArr {
            let img = UIImage.init(named: imgName) ?? UIImage.init()
            imgArr.append(img)
        }
        animationImageView.frame = CGRect.init(x: VIEWW(self)/2-wid/2, y: CGScale(16), width: wid, height: wid)
//        animationImageView.animationImages = imgArr
        addSubview(animationImageView)
        animationImageView.isHidden = true
        
        resultLabel.text = "松开立即加载"
        resultLabel.isHidden = false
        resultLabel.textColor = __RGB(0x666666)
        resultLabel.frame = CGRect.init(x: 10, y: VIEWY(animationImageView), width: VIEWW(self)-20, height: CGScale(18))
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 16)
        addSubview(resultLabel)
    }
    func startPull(){
        resultLabel.isHidden = false
        resultLabel.text = "松开立即加载"
    }
    public func startAnimation(){
        animationDeal(true)
        animationImageView.startAnimating()
    }
    public func endAnimation(){
        animationImageView.stopAnimating()
    }
    
    fileprivate func animationDeal(_ isAnimation:Bool){
        animationImageView.isHidden = !isAnimation
        resultLabel.isHidden = isAnimation
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
