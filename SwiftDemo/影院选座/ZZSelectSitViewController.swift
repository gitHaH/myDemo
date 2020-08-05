//
//  ZZSelectSitViewController.swift
//  SwiftDemo
//
//  Created by 张萌 on 2020/7/1.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ZZSelectSitViewController: UIViewController
{
    
    let scr = Scr.init(frame: CGRect.zero)
    var pinchGes:UIPinchGestureRecognizer!
    var origionFrame = CGRect.zero
    var scrSubViews = [[UIButton]]()
    var screenShotImg = UIView.init()
    var currentScale:CGFloat = 1
    
    var origionWid:CGFloat = 0
    var origionSpace:CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 10
        let wid = (ScreenWidth-space*9)/10
        let height = wid
        
        origionWid = wid
        origionSpace = space
        for i in 0..<10 {
            var arr = [UIButton]()
            for j in 0..<10 {
                let btn = UIButton.init(type: .custom)
                btn.backgroundColor = UIColor.init(red: CGFloat(arc4random()%255)/255, green: CGFloat(arc4random()%255)/255, blue: CGFloat(arc4random()%255)/255, alpha: 1)
                btn.frame = CGRect.init(x: (wid+space)*CGFloat(i), y: (height+space)*CGFloat(j), width: wid, height: height)
                scr.addSubview(btn)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                btn.setTitle("\(j*10+i+1)", for: .normal)
                arr.append(btn)
            }
            scrSubViews.append(arr)
        }
        scr.frame = CGRect.init(x: 0, y: __NavH+20, width: ScreenWidth, height: ScreenHeight-__NavH-20)
        view.addSubview(scr)
        
        pinchGes = UIPinchGestureRecognizer.init(target: self, action: #selector(pinchGesAction(_:)))
        scr.addGestureRecognizer(pinchGes)
        
        origionFrame = scr.frame
        // Do any additional setup after loading the view.
    }
    
    @objc private func pinchGesAction(_ ges:UIPinchGestureRecognizer){
        var scale = ges.scale
        if scale > 3 {scale = 3}
        if scale < 1 {scale = 1}
        switch ges.state {
        case .began:
            print("begin")
            screenShotImg = scr.snapshotView(afterScreenUpdates: false) ?? UIView.init()
            view.addSubview(screenShotImg)
            scr.isHidden = true
            
            screenShotImg.frame = scr.frame
        case .changed:
//            print("change")
            if ges.scale < 1{return}
            let point = ges.location(in: scr)
            screenShotImg.bounds = CGRect.init(x: 0, y: 0, width: origionFrame.size.width*scale, height: origionFrame.size.height*scale)
            let centerXOff = (origionFrame.midX-point.x)*scale
            let centerYOff = (origionFrame.midY-point.y)*scale
            screenShotImg.center = CGPoint.init(x: point.x+centerXOff, y: point.y+centerYOff)
//            print(screenShotImg.frame,"\n",ges.scale)
        case .ended:
//            print(screenShotImg.frame,scale)
            scr.frame = screenShotImg.frame
            scr.contentOffset = CGPoint.zero
            currentScale = scale
            screenShotImg.removeFromSuperview()
            scr.isHidden = false
            reloadFrame()
        default:
            break
        }
        
//        print(screenShotImg.frame)
    }
    
    fileprivate func reloadFrame(){
        scr.contentSize = CGSize.init(width: origionFrame.size.width*currentScale*2, height: origionFrame.size.height*currentScale*2)
        let space:CGFloat = 10*currentScale
        let wid = (ScreenWidth-10*9)/10*currentScale
        let height = wid
        print("or: wid = \(origionWid) space = \(origionSpace) \n cur: wid = \(wid) space = \(space) \n scale = \(currentScale) and widScale = \(VIEWW(scr)/ScreenWidth)")
        for (i,btns) in scrSubViews.enumerated() {
            for (j,btn) in btns.enumerated() {
                btn.frame = CGRect.init(x: (wid+space)*CGFloat(i), y: (height+space)*CGFloat(j), width: wid, height: height)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 16*currentScale)
            }
        }
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

class Scr: UIScrollView {
    override func touchesShouldCancel(in view: UIView) -> Bool {
        return true
    }
}
