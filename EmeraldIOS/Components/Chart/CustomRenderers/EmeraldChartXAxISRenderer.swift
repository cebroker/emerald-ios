//
//  EmeraldChartXAxISRenderer.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/25/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation
import Charts

/// This class allow us to override the default implementation for 'X' axis,
/// that means we can add texts, icons, change color or whatever we need to do in 'X' axis.
/// For instance, here is where we add the SUBTITLE LABEL and TITLE ICON.
class EmeraldChartXAxisRenderer: XAxisRenderer {

    typealias Attributes = [NSAttributedString.Key: Any]

    internal var icon: UIImage?
    internal var colorsDictionary: [String: UIColor]!
    internal var dataEntries: [EmeraldChartSimpleDataEntry]?
    internal var subtitlesFont: UIFont?

    init(viewPortHandler: ViewPortHandler, xAxis: XAxis?, transformer: Transformer?, icon: UIImage?) {
        self.icon = icon
        super.init(viewPortHandler: viewPortHandler, xAxis: xAxis, transformer: transformer)
    }
    
    /// This is the functions that we needs to override to allow add custom conent to X axis.
    ///
    /// - Parameters:
    ///   - context: Context
    ///   - formattedLabel: Title string to be shown.
    ///   - x: X position where Title should be putted.
    ///   - y: Y position where Title should be putted
    ///   - attributes: String attributes to be added to formattedLabel
    ///   - constrainedToSize: Default arguments.
    ///   - anchor: Default arguments.
    ///   - angleRadians: Default arguments.
    override func drawLabel(
        context: CGContext,
        formattedLabel: String,
        x: CGFloat,
        y: CGFloat,
        attributes: Attributes,
        constrainedToSize: CGSize,
        anchor: CGPoint,
        angleRadians: CGFloat) {

        super.drawLabel(
            context: context,
            formattedLabel: formattedLabel,
            x: x,
            y: y,
            attributes: attributes,
            constrainedToSize: constrainedToSize,
            anchor: anchor,
            angleRadians: angleRadians)

        
        let currentDataEntry = self.getCurrentFormattedLabelEntry(formattedLabel)
        let subtitle = String(Int(currentDataEntry.value))

        if !subtitle.isEmpty {
            let subtitlesAttributes = self.getSubtitleAttributes(attributes, color: currentDataEntry.color)
            let subtitleXPosition = x + self.getSubtitleXPosition(
                titleSize: formattedLabel.size(withAttributes: attributes),
                valueSize: subtitle.size(withAttributes: subtitlesAttributes))
            let subtitlePositionPoint = CGPoint(x: subtitleXPosition, y: y + 20)

            ChartUtils.drawText(
                context: context,
                text: subtitle,
                point: subtitlePositionPoint,
                attributes: subtitlesAttributes,
                anchor: anchor,
                angleRadians: angleRadians)
        }

        if self.icon != nil {
            let labelSize = formattedLabel.size(withAttributes: attributes)
            ChartUtils.drawImage(context: context,
                image: self.icon!,
                x: x + (labelSize.width / 1.5),
                y: y + (labelSize.height / 2),
                size: CGSize(width: 10, height: 12))
        }
    }
    
    /// This function return the `EmeraldChartSimpleDataEntry` currently proccessed, this is useful for know the bar chart where we
    /// want to add the subtitle
    ///
    /// - Parameter formattedLabel: Currently title.
    private func getCurrentFormattedLabelEntry(_ formattedLabel: String) -> EmeraldChartSimpleDataEntry {
        guard let entries = self.dataEntries,
            let foundEntry = entries.first(where: { $0.title == formattedLabel }) else {
                fatalError("Data cannot be empty")
        }

        return foundEntry
    }
    
    /// Function to add all `Attributes` thtat we wants to add to subtitle.
    /// Here is where we add the subtitle COLOR and FONT.
    ///
    /// - Parameters:
    ///   - attributes: Shared attributes with Title.
    ///   - color: Color to be added as attribute.
    private func getSubtitleAttributes(_ attributes: Attributes, color: UIColor) -> Attributes {
        var attributes = attributes
        attributes[NSAttributedString.Key.foregroundColor] = color

        if self.subtitlesFont != nil {
            attributes[NSAttributedString.Key.font] = self.subtitlesFont
        }

        return attributes
    }
    
    /// This function allow us to calculate the `X` position for `Subtitle`, making that TITLE and SUBTITLE started at same position.
    /// This return the CGFloat `X` where the subtitle should be start
    ///
    /// - Parameters:
    ///   - titleSize: Title string size calculated according attributes.
    ///   - valueSize: Subtitle string size calculated according attributes.
    private func getSubtitleXPosition(titleSize: CGSize, valueSize: CGSize) -> CGFloat {
        let titleWidth = (titleSize.width)
        let subtitleWidth = (valueSize.width)

        return ((titleWidth - subtitleWidth) / 2 * -1)
    }
}
