//
//  AnimationViewController.swift
//  SwiftDemo
//
//  Created by 张萌 on 2020/5/14.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    var labels = [UILabel]()
    var restLabels = [UILabel]()
    
    let wid:CGFloat = 260
    let height:CGFloat = 30
    
    var lastIsOver = true
    let coverV = UIButton.init(frame: CGRect.init(x: 0, y: __NavH, width: ScreenWidth, height: 100))

    var tmpLab = UILabel.init()
    var animtedLab:UILabel?
    var num = 0
    
    let dmV = UIView.init()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan
        
        dmV.frame = CGRect.init(x: 0, y: VIEWMaxY(coverV), width: ScreenWidth, height: height*5)
        view.addSubview(dmV)
        coverV.backgroundColor = .red
        view.addSubview(coverV)
        
        coverV.addTarget(self, action: #selector(a), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    @objc func a(){
        print("")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        num += 1
        if restLabels.count < 1{
            tmpLab = UILabel.init()
            
            tmpLab.textAlignment = .center
            dmV.addSubview(tmpLab)
        }else{
            tmpLab = restLabels[0]
            restLabels.remove(at: 0)
        }
        tmpLab.text = "王亚亚\(num)进入直播间"
        if labels.count > 4{
//            NSObject.cancelPreviousPerformRequests(withTarget: self)
            if let _ = self.animtedLab{
                self.removeLab(1)
            }else{
                self.removeLab(0)
            }
        }
        labelDeal()
        
    }
    
    fileprivate func removeLab(_ index:Int){
        guard labels.count>index else{return}
        let topLab = labels[index]
        topLab.frame.origin.y -= self.height
        topLab.alpha = 0
        self.labels.remove(at: index)
        self.restLabels.append(topLab)
        for i in index..<self.labels.count{
            labels[i].frame.origin.y -= self.height
        }
    }
    
    @objc fileprivate func labelDeal(){
        tmpLab.alpha = 1
        labels.append(tmpLab)
        
        let y = CGFloat(labels.count-1)*height
        
        tmpLab.frame = CGRect.init(x: -wid, y: y, width: wid, height: height)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.tmpLab.frame.origin.x = 0
        })
        
        if lastIsOver{
            lastIsOver = false
            self.perform(#selector(afeterDeal), with: nil, afterDelay: 2)
        }
    }
    
    @objc fileprivate func afeterDeal(){
        
        guard let topLab = labels.first else{return}
        
        UIView.animate(withDuration: 0.3, animations: {
            self.animtedLab = topLab
            topLab.frame.origin.y -= self.height
            topLab.alpha = 0
        }) { (finishied) in
            self.animtedLab = nil
            self.perform(#selector(self.afeterDeal), with: nil, afterDelay: 2)
            self.labels.remove(at: 0)
            self.restLabels.append(topLab)
            if self.labels.isEmpty{
                self.lastIsOver = true
                NSObject.cancelPreviousPerformRequests(withTarget: self)
            }
            print(self.labels.count,self.restLabels.count)
            for lab in self.labels{
                UIView.animate(withDuration: 0.1) {
                    lab.frame.origin.y -= self.height
                }
            }
            
        }
    }
    
    fileprivate func finishAnimation(_ label:UILabel){
        self.animtedLab = nil
        self.labels.remove(at: 0)
        self.restLabels.append(label)
        for lab in self.labels{
           lab.frame.origin.y -= self.height
        }
       
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        if nil == parent{
            labels.removeAll()
        }
    }
    deinit {
        print("消除")
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


