//
//  QuestionScrollView.swift
//  yunduoketang
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 fwang. All rights reserved.
//

import UIKit

class QuestionScrollView: UIScrollView,UIGestureRecognizerDelegate {

    // 这方法单独写在vc里无效（scrollview addsubview webview 滑动问题）
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
