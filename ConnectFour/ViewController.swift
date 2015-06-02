//
//  ViewController.swift
//  ConnectFour
//
//  Created by Nick Brandaleone on 6/1/15.
//  Copyright (c) 2015 Nick Brandaleone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gameBoardView: GameBoardView!
    var gameState: Model!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.gameState = Model()
        self.gameBoardView = GameBoardView()
        self.view.addSubview(self.gameBoardView)
        
        // stretch gameBoardView to end of screen horizontally
        let c1 = NSLayoutConstraint.constraintsWithVisualFormat("|-[gameBoardView]-|",
            options: NSLayoutFormatOptions.DirectionLeftToRight,
            metrics: nil,
            views: ["gameBoardView": gameBoardView])
        self.view.addConstraints(c1)
        
        // center gameBoardView vertically
        let c2 = NSLayoutConstraint(item: self.gameBoardView,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 1.0, constant: 0)
        self.view.addConstraint(c2)
        
        let recognizer = UITapGestureRecognizer(target: self, action: Selector("spawnPiece:"))
        // recognizer.delegate = self
        view.addGestureRecognizer(recognizer)
    }
    
    func spawnPiece(tap: UITapGestureRecognizer){
        let size: CGSize = self.gameBoardView.pieceSize()
        let tapLocation: CGPoint = tap.locationInView(self.view)
        let point: CGPoint = CGPointMake(tapLocation.x - size.width / 2.0, tapLocation.y - size.height / 2.0)
        
        var frame: CGRect = CGRectZero
        frame.size = size
        frame.origin = point
        
        // Add piece to board
        gameState.piecesPlayed++
        var piece: PieceView = PieceView(frame: frame, num: gameState.piecesPlayed)
        self.view.insertSubview(piece, belowSubview: self.gameBoardView)
        
        // Drop piece using animation. Remove when hits bottom of screen.
        // TODO: Use UIDynamics to simulate bounce. Must force pieces in column channels. Track when to stop.
        UIView.animateWithDuration(0.75, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            var newFrame = frame
            newFrame.origin.y = self.view.bounds.size.height
            piece.frame = newFrame
            }, completion: {(finished: Bool) in
                piece.removeFromSuperview()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

