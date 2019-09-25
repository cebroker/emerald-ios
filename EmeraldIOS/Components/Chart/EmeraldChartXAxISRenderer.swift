//
//  EmeraldChartXAxISRenderer.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/25/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation
import Charts

class EmeraldChartXAxisRenderer: XAxisRenderer {
    private var icon: UIImage
    internal var colorsDictionary: [String: UIColor]!
    
    init(viewPortHandler: ViewPortHandler, xAxis: XAxis?, transformer: Transformer?, icon: UIImage? = nil) {
        self.icon = (UIImage(named: "Edit",
                             in: Bundle(for: ClassBundle.self),
                             compatibleWith: nil)?.withRenderingMode(.alwaysTemplate))!
        super.init(viewPortHandler: viewPortHandler, xAxis: xAxis, transformer: transformer)
    }
    
    override func drawLabel(context: CGContext, formattedLabel: String, x: CGFloat, y: CGFloat, attributes: [NSAttributedString.Key : Any], constrainedToSize: CGSize, anchor: CGPoint, angleRadians: CGFloat) {
        let color = colorsDictionary[formattedLabel]
        let stringAttirbutes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20.0)!]
        
        super.drawLabel(context: context, formattedLabel: "12345677", x: x + 5, y: y + 20, attributes: stringAttirbutes, constrainedToSize: constrainedToSize, anchor: anchor, angleRadians: angleRadians)
        super.drawLabel(context: context, formattedLabel: formattedLabel, x: x, y: y, attributes: attributes, constrainedToSize: constrainedToSize, anchor: anchor, angleRadians: angleRadians)
        ChartUtils.drawImage(context: context, image: icon, x: x + 40, y: y + 6, size: CGSize(width: 10, height: 14))
        
    }
}
