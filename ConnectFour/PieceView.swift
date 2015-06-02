//
//  PieceView.swift
//  ConnectFour
//
//  Created by Nick Brandaleone on 6/2/15.
//  Copyright (c) 2015 Nick Brandaleone. All rights reserved.
//

import UIKit

class PieceView: UIView {

    init(frame: CGRect, num: Int) {
        super.init(frame: frame)
        
        var color: UIColor
        if (num % 2 == 0){
            color = UIColor.redColor()
        } else {
            color = UIColor.blackColor()                    // black goes first
        }
        self.backgroundColor = color
        self.layer.cornerRadius = frame.size.width / 2.0    // makes a perfect circle
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
