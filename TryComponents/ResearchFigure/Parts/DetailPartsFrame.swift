//
//  PropertyFrame2.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/05.
//

import SwiftUI

struct DetailPartsFrame: Shape {
    var width: CGFloat
    var numberOfItems: Int
    var widthFromLeftEdgeToConnection: CGFloat {
        (width - headerWidth) / 2 + arrowTerminalWidth
    }
    
    let headerWidth = DetailPartsSettingValues.headerWidth
    let headerHeight = DetailPartsSettingValues.headerHeight
    let itemHeight = DetailPartsSettingValues.itemHeight
    let oneVerticalLineWithoutArrow = DetailPartsSettingValues.oneVerticalLineWithoutArrow
    let arrowTerminalWidth = DetailPartsSettingValues.arrowTerminalWidth
    let arrowTerminalHeight = DetailPartsSettingValues.arrowTerminalHeight
    let bottomPaddingForLastText = DetailPartsSettingValues.bottomPaddingForLastText
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            // header
            // from right to left
            path.move(to: CGPoint(x: arrowTerminalWidth + width, y: headerHeight))
            path.addLine(to: CGPoint(x: widthFromLeftEdgeToConnection + headerWidth, y: headerHeight))
            path.addLine(to: CGPoint(x: widthFromLeftEdgeToConnection + headerWidth, y: 0))
            path.addLine(to: CGPoint(x: widthFromLeftEdgeToConnection, y: 0))
            path.addLine(to: CGPoint(x: widthFromLeftEdgeToConnection, y: headerHeight))
            path.addLine(to: CGPoint(x: arrowTerminalWidth, y: headerHeight))
            
            // items
            // left side
            // from top to bottom
            for numberOfItem in 0..<numberOfItems {
                path.addLine(to: CGPoint(x: arrowTerminalWidth, y: headerHeight + itemHeight*CGFloat(numberOfItem) + oneVerticalLineWithoutArrow))
                path.addLine(to: CGPoint(x: 0, y: headerHeight + itemHeight*CGFloat(numberOfItem) + oneVerticalLineWithoutArrow))
                path.addLine(to: CGPoint(x: 0, y: headerHeight + itemHeight*CGFloat(numberOfItem) + oneVerticalLineWithoutArrow + arrowTerminalHeight))
                path.addLine(to: CGPoint(x: arrowTerminalWidth, y: headerHeight + itemHeight*CGFloat(numberOfItem) + oneVerticalLineWithoutArrow + arrowTerminalHeight))
                path.addLine(to: CGPoint(x: arrowTerminalWidth, y: headerHeight + itemHeight*CGFloat(numberOfItem) + oneVerticalLineWithoutArrow*2 + arrowTerminalHeight))
            }
            
            // footer
            // from left to right
            path.addLine(to: CGPoint(x: arrowTerminalWidth, y: bottomPaddingForLastText + headerHeight*2 + itemHeight*CGFloat(numberOfItems)))
            path.addLine(to: CGPoint(x: widthFromLeftEdgeToConnection, y: bottomPaddingForLastText + headerHeight*2 + itemHeight*CGFloat(numberOfItems)))
            path.addLine(to: CGPoint(x: widthFromLeftEdgeToConnection, y: bottomPaddingForLastText + headerHeight + itemHeight*CGFloat(numberOfItems)))
            path.addLine(to: CGPoint(x: widthFromLeftEdgeToConnection + headerWidth, y: bottomPaddingForLastText + headerHeight + itemHeight*CGFloat(numberOfItems)))
            path.addLine(to: CGPoint(x: widthFromLeftEdgeToConnection + headerWidth, y: bottomPaddingForLastText + headerHeight*2 + itemHeight*CGFloat(numberOfItems)))
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: bottomPaddingForLastText + headerHeight*2 + itemHeight*CGFloat(numberOfItems)))
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: headerHeight + itemHeight*CGFloat(numberOfItems)))

            // items
            // right side
            // from bottom to top
            for numberOfItem in 0..<numberOfItems {
                let numberOfItemFromBottom = numberOfItems - (numberOfItem + 1)
                path.addLine(to: CGPoint(x: arrowTerminalWidth + width, y: headerHeight + itemHeight*CGFloat(numberOfItemFromBottom) + oneVerticalLineWithoutArrow + arrowTerminalHeight))
                path.addLine(to: CGPoint(x: arrowTerminalWidth*2 + width, y: headerHeight + itemHeight*CGFloat(numberOfItemFromBottom) + oneVerticalLineWithoutArrow + arrowTerminalHeight))
                path.addLine(to: CGPoint(x: arrowTerminalWidth*2 + width, y: headerHeight + itemHeight*CGFloat(numberOfItemFromBottom) + oneVerticalLineWithoutArrow))
                path.addLine(to: CGPoint(x: arrowTerminalWidth + width, y: headerHeight + itemHeight*CGFloat(numberOfItemFromBottom) + oneVerticalLineWithoutArrow))
                path.addLine(to: CGPoint(x: arrowTerminalWidth + width, y: headerHeight + itemHeight*CGFloat(numberOfItemFromBottom)))
            }
        }
    }
}

struct DetailPartsFrame_Previews: PreviewProvider {
    static var previews: some View {
        DetailPartsFrame(width: 800, numberOfItems: 5)
            .frame(width: 1200, height: 1000)
    }
}
