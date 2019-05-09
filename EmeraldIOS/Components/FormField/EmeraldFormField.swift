////
////  EmeraldFormField.swift
////  EmeraldIOS
////
////  Created by Genesis Sanguino on 5/6/19.
////  Copyright © 2019 Condor Labs. All rights reserved.
////
//
//import UIKit
//
//@IBDesignable
//public class EmeraldFormField: UIControl {
//    
//    @IBInspectable var themeStyle: String = EmeraldTextFieldStyle.plain.IBInspectable {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//    
//    @IBInspectable var themeNormalBorderColor: String = Color.border.IBInspectable {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//    
//    @IBInspectable var themeSelectedBorderColor: String = Color.link.rawValue {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//    
//    override public func draw(_ rect: CGRect) {
//        super.draw(rect)
//        
//        let style = EmeraldTextFieldStyle(IBInspectable: themeStyle)
//        switch style {
//        case .bordered:
//            drawBorders()
//        default:
//            break
//        }
//    }
//    
//    private var borderColorForState: UIColor {
//        if isSelected {
//            return Color.uiColor(themeSelectedBorderColor)
//        }
//        return Color.uiColor(themeNormalBorderColor)
//    }
//    
//    private func drawBorders() {
//        let strokeWidth: CGFloat = 1
//        let path = UIBezierPath(rect: bounds.insetBy(dx: strokeWidth, dy: strokeWidth))
//        path.lineWidth = strokeWidth
//        borderColorForState.setStroke()
//        path.stroke()
//    }
//}
