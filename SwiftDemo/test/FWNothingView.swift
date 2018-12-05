//
//  FWNothingView.swift
//  yunduoketang
//
//  Created by wangfei-sal on 16/5/12.
//  Copyright © 2016年 fwang. All rights reserved.
//

import UIKit


protocol FWNothingViewDelegate : NSObjectProtocol {
    func refreshNothing();
}

class FWNothingView: UIView {

    weak var delegate : FWNothingViewDelegate? = nil
    var isFullSet : Bool = false
    var title : String = "" { didSet { titleLabel.text=title+"\n"+"点击刷新" } }
    
    var attributedText : String = "" {
        didSet { titleLabel.attributedText = NSMutableAttributedString.init(string: attributedText) }
    }
    
    var attributed : NSAttributedString = NSAttributedString() {
        didSet { titleLabel.attributedText = attributed }
    }
    
    var imgName : String = "" {
        didSet { imageView.image = UIImage(named: imgName) }
    }
    
    let imageView  = UIImageView.init(image: UIImage.init(named: "空空如也.png"))
    let titleLabel = UILabel.init(frame: CGRect.zero)
    let touchView  = UIButton.init(frame: CGRect.zero)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        self.addSubview(imageView)

        
        titleLabel.numberOfLines = 1
        titleLabel.textColor = UIColor.lightGray
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(titleLabel)
        
        
        touchView.backgroundColor = UIColor.clear
        touchView.addTarget(self, action: #selector(FWNothingView.refresh), for: UIControlEvents.touchUpInside)
        self.addSubview(touchView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isFullSet {

            let fW = VIEWW(self)*0.5
            let fH = fW*1.9
            
            let rate : CGFloat = 347/469
            
            imageView.frame  = CGRect(x: 0, y: 0, width: rate*fW, height: fW)
            imageView.center = CGPoint(x: self.center.x, y: self.center.y - 100)
            
            titleLabel.frame = CGRect(x: 0, y: VIEWMaxY(imageView), width: VIEWW(self), height: fH - VIEWMaxY(imageView))
            touchView.frame  = titleLabel.frame
        }
        else {
            let height = VIEWH(self)/4*3
            let rate : CGFloat = 347/469
            
            imageView.frame  = CGRect(x: 0, y: 0, width: rate*height, height: height)
            
            titleLabel.frame = CGRect(x: 0, y: height, width: VIEWW(self), height: VIEWH(self)-height)
//            titleLabel.sizeToFit()
//            titleLabel.center = CGPoint(x: 0, y: titleLabel.center.y)
            touchView.frame  = CGRect(x: 0, y: 0,      width: VIEWW(self), height: VIEWH(self))
        }
    }
    
    @objc func refresh() {
        delegate?.refreshNothing()
    }
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isUserInteractionEnabled == false || self.isHidden == true || self.alpha <= 0.01 {
            return nil
        }
        
        if self.point(inside: point, with: event) == false {
            return nil
        }
        
        let p = self.convert(point, to: touchView)
        if let fitView = touchView.hitTest(p, with: event) {
            return fitView
        }
        
        return nil
    }
}
