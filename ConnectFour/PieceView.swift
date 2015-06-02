//
//  PieceView.swift
//  ConnectFour
//
//  Created by Nick Brandaleone on 6/2/15.
//  Copyright (c) 2015 Nick Brandaleone. All rights reserved.
//

import UIKit

class PieceView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.redColor()           // TODO: red and black are possible. Make color part of init
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
