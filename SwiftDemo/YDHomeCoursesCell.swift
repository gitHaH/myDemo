//
//  YDHomeCoursesCell.swift
//  yunduoketang
//
//  Created by apple on 2018/10/17.
//  Copyright © 2018年 fwang. All rights reserved.
//

import UIKit

class TestModel: NSObject {
    var title = ""
    var time = ""
    var teacher = [String]()
    var limit = ""
    var money = ""
}

class YDHomeCoursesCell: UITableViewCell {

    @IBOutlet weak var moneyLab: UILabel!
    @IBOutlet weak var limitLab: UILabel!
    @IBOutlet weak var timeHeight: NSLayoutConstraint!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var teacherView: UIView!
    var model = TestModel(){
        didSet{
            titleLab.text = model.title
            if model.time.count > 0{
                timeLab.text = nil
                timeLab.isHidden = false
                timeHeight.constant = 10.5
                let attMutaStr = NSMutableAttributedString.init(string: " "+model.time)
                
                let img =  UIImage.init(named: "time")
                let attach = NSTextAttachment.init()
                attach.image = img
                attach.bounds = CGRect.init(origin: CGPoint.init(x: 0, y: -2), size: CGSize.init(width: 13, height: 13))
                let attString = NSAttributedString.init(attachment: attach)
                attMutaStr.insert(attString, at: 0)
                
                timeLab.attributedText = attMutaStr
            }else{
                timeHeight.constant = 0.001
                timeLab.isHidden = true
            }
            updateConstraints()
            
            for i in 0..<4{
                let label = teacherView.viewWithTag(i+1) as? UILabel
                if i < model.teacher.count{
                    label?.isHidden = false
                    label?.text = " "+model.teacher[i]+"  "
                }else{
                    label?.isHidden = true
                }
            }
            
            limitLab.text = model.limit
            moneyLab.text = model.money
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

class YDTeacherLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layerDeal()
    }
    
    func layerDeal(){
        self.layer.mask = nil
        let path = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight, UIRectCorner.bottomLeft], cornerRadii: CGSize.init(width: VIEWH(self)/2, height: VIEWH(self)/2))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
}
