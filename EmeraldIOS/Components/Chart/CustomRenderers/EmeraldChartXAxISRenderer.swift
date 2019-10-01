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
    internal var icon: UIImage?
    internal var colorsDictionary: [String: UIColor]!
    internal var dataEntries: [EmeraldChartSimpleDataEntry]?
    internal var subtitlesFont: UIFont?
    
    init(viewPortHandler: ViewPortHandler, xAxis: XAxis?, transformer: Transformer?, icon: UIImage?) {
        self.icon = icon
        super.init(viewPortHandler: viewPortHandler, xAxis: xAxis, transformer: transformer)
    }
    
    override func drawLabel(context: CGContext,
                            formattedLabel: String,
                            x: CGFloat, y: CGFloat,
                            attributes: [NSAttributedString.Key : Any],
                            constrainedToSize: CGSize,
                            anchor: CGPoint,
                            angleRadians: CGFloat) {
        
        super.drawLabel(context: context,
                        formattedLabel: formattedLabel,
                        x: x,
                        y: y,
                        attributes: attributes,
                        constrainedToSize: constrainedToSize,
                        anchor: anchor,
                        angleRadians: angleRadians)
        
        let labelSize = (formattedLabel as NSString).boundingRect(with: constrainedToSize,
                                                                  options: .usesLineFragmentOrigin,
                                                                  attributes: attributes,
                                                                  context: nil)
        var subtitle = ""
        
        var entry: EmeraldChartSimpleDataEntry? = nil
        if let entries = dataEntries {
            entry = entries.first(where: {$0.title == formattedLabel})
        }
        
        var subtitlesAttributes = attributes
        if let foundEntry = entry {
            if let subsFont = subtitlesFont {
                subtitlesAttributes[NSAttributedString.Key.font] =  subsFont
            }
            subtitlesAttributes[NSAttributedString.Key.foregroundColor] = foundEntry.color
            subtitle = String(Int(foundEntry.value))
        }
       
        
        if !subtitle.isEmpty{
            ChartUtils.drawText(context: context,
                                text: subtitle,
                                point: CGPoint(x: x + 5, y: y + 20),
                                attributes: subtitlesAttributes,
                                anchor: anchor,
                                angleRadians: angleRadians)

        }
        
        if let labelIcon = icon {
            ChartUtils.drawImage(context: context,
                                 image: labelIcon,
                                 x: x + offsetByLabelWidth(labelWidth: labelSize.width),
                                 y: y + 6,
                                 size: CGSize(width: 10, height: 14))
        }
        
    }
    
    private func offsetByLabelWidth(labelWidth: CGFloat) -> CGFloat{
        return labelWidth/1.5
    }
    
}
