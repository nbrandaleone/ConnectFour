//
//  GameBoardView.swift
//  ConnectFour
//
//  Created by Nick Brandaleone on 6/2/15.
//  Copyright (c) 2015 Nick Brandaleone. All rights reserved.
//

import UIKit

class GameBoardView: UIView {
    
    let PADDING: CGFloat = 8.0
    var rows = 0
    var columns = 0

    // Designated initializer
    init(rows: Int, columns: Int){
        super.init(frame: CGRectZero)   // initWithFrame is usually overridden if setting up view programmatically.
        
        self.rows = rows
        self.columns = columns
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.opaque = false
    }
    
    // Convenience initializer, required to call the designated initializer above
    convenience init(){
        self.init(rows: 6, columns: 7)
    }

    // This method is required. It is usually overridden if you are loading the view from a Nib.
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    override func updateConstraints() {
        let aspectRatio: CGFloat = CGFloat(self.columns) / CGFloat(self.rows)
        
        // Keeps aspect ratio
        // Fix landscape. Add more constraints.
        let c1 = NSLayoutConstraint(item: self,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1/aspectRatio,
            constant: 0)
        self.addConstraint(c1)
        
        // Ensure that width is at least 200 points wide
        let viewsDictionary = ["self": self]
        let c2 = NSLayoutConstraint.constraintsWithVisualFormat("H:[self(>=200)]",
            options: NSLayoutFormatOptions.DirectionLeftToRight,
            metrics: nil,
            views: viewsDictionary)
        self.addConstraints(c2)
        
        super.updateConstraints()
    }
    
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        
        CGContextBeginPath(context)
        CGContextAddRect(context, self.bounds)
        
        let innerRect = CGRectInset(self.bounds, PADDING, PADDING)
        let squareSize: CGFloat = innerRect.size.width / CGFloat(self.columns)
        let holeSize: CGFloat = squareSize - PADDING * 2
        
        // Start drawing in innerRect, so we have nice padding. Move over to distribute padding on all sides.
        CGContextTranslateCTM(context, PADDING, PADDING)
        
        // Create holes in the gameBoard
        for var y =  0; y < self.rows; y++ {
            for var x = 0; x < self.columns; x++ {
                let holeRect = CGRectMake(PADDING, PADDING, holeSize, holeSize)
                CGContextAddEllipseInRect(context, holeRect)
                CGContextTranslateCTM(context, squareSize, 0)
            }
            CGContextTranslateCTM(context, -innerRect.size.width, squareSize)
        }
        
        // Yellow-ish color
        CGContextSetFillColorWithColor(context, UIColor(red: 0.822, green: 0.822, blue: 0.0, alpha: 1.0).CGColor)
        CGContextEOFillPath(context)    // The even-odd CG function leaves "holes"
        
        CGContextRestoreGState(context)
    }
    
    // To be used in ViewController to create proper sized pieces
    func pieceSize() -> CGSize {
        let innerRect = CGRectInset(self.bounds, PADDING, PADDING)
        let squareSize: CGFloat = innerRect.size.width / CGFloat(self.columns)
        return CGSizeMake(squareSize, squareSize)
    }
}
