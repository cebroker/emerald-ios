//
//  EmeraldCanvasView.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/8/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

open class EmeraldCanvasView: UIView {
    
    fileprivate var bezierPoints = [CGPoint](repeating: CGPoint(), count: 5)
    fileprivate var bezierPath = UIBezierPath()
    fileprivate var bezierCounter : Int = 0
    
    open var isSigned: Bool = false
    open var strokeColor = UIColor.black
    open var strokeWidth: CGFloat = 2.0 {
        didSet { bezierPath.lineWidth = strokeWidth }
    }
    
    // MARK: - Initializers
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        bezierPath.lineWidth = strokeWidth
        addLongPressGesture()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        bezierPath.lineWidth = strokeWidth
        addLongPressGesture()
    }
    
    override open func draw(_ rect: CGRect) {
        bezierPath.stroke()
        strokeColor.setStroke()
        bezierPath.stroke()
        
    }
    
    // MARK: - Touch Functions
    
    func addLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(_:)))
        longPressGesture.minimumPressDuration = 1.5
        self.addGestureRecognizer(longPressGesture)
    }
    
    @objc func longPressed(_ gesture: UILongPressGestureRecognizer) {
        let touchPoint = gesture.location(in: self)
        let endAngle: CGFloat = .pi * 2.0
        bezierPath.move(to: touchPoint)
        bezierPath.addArc(withCenter: touchPoint, radius: 2, startAngle: 0, endAngle: endAngle, clockwise: true)
        setNeedsDisplay()
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let currentPoint = touchPoint(touches) {
            isSigned = true
            bezierPoints[0] = currentPoint
            bezierCounter = 0
        }
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let currentPoint = touchPoint(touches) {
            bezierCounter += 1
            bezierPoints[bezierCounter] = currentPoint
            
            if bezierCounter == 4 {
                bezierPoints[3] = CGPoint(x: (bezierPoints[2].x + bezierPoints[4].x) / 2 , y: (bezierPoints[2].y + bezierPoints[4].y) / 2)
                bezierPath.move(to: bezierPoints[0])
                bezierPath.addCurve(to: bezierPoints[3], controlPoint1: bezierPoints[1], controlPoint2: bezierPoints[2])
                setNeedsDisplay()
                bezierPoints[0] = bezierPoints[3]
                bezierPoints[1] = bezierPoints[4]
                bezierCounter = 1
            }
        }
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        bezierCounter = 0
    }
    
    func touchPoint(_ touches: Set<UITouch>) -> CGPoint? {
        if let touch = touches.first {
            return touch.location(in: self)
        }
        return nil
    }
    
    //MARK: Utility Methods
    
    open func clear() {
        isSigned = false
        bezierPath.removeAllPoints()
        setNeedsDisplay()
    }
    
    open func getSignatureAsImage() -> UIImage? {
        if isSigned {
            UIGraphicsBeginImageContext(CGSize(width: self.bounds.size.width, height: self.bounds.size.height))
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let signature: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return signature
        }
        return nil
    }
    
    open func getSignatureBoundsInCanvas() -> CGRect {
        return bezierPath.bounds
    }
    
    //MARK: Save load signature methods
    
    open func saveSignature(_ localPath: String) {
        if isSigned {
            NSKeyedArchiver.archiveRootObject(bezierPath, toFile: localPath)
        }
    }
    
    open func loadSignature(_ filePath: String) {
        if let path = getPath(filePath) {
            isSigned = true
            bezierPath = path
            setNeedsDisplay()
        }
    }
    
    fileprivate func getPath(_ filePath: String) -> UIBezierPath? {
        if FileManager.default.fileExists(atPath: filePath) {
            return NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? UIBezierPath
        }
        return nil
    }
    
    func removeSignature() {
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let filePath = (docPath! as NSString).appendingPathComponent("sig.data")
        do {
            try FileManager.default.removeItem(atPath: filePath)
        }
        catch let error {
            print(error)
        }
    }
}
