//
//  PropertyFrame.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/30.
//

import SwiftUI

struct PropertyFrame: View {
    var width: CGFloat
    var numberOfItems: Int
    var invisiblePaddingWidth: CGFloat {
        (self.width - self.headerWidth) / 2 + self.arrowTerminalWidth
    }
    @State var maxY: CGFloat = 90
    
    let headerWidth: CGFloat = 350
    let headerHeight: CGFloat = 90
    let itemHeight: CGFloat = 90
    var oneVerticalLineWithoutArrow: CGFloat {
        (self.itemHeight - self.arrowTerminalHeight)/2
    }
    let arrowTerminalWidth: CGFloat = 15
    let arrowTerminalHeight: CGFloat = 30
    let bottomPaddingForLastText: CGFloat = 30
    
    var body: some View {
        Path { path in
            // header
            path.move(to: CGPoint(x: invisiblePaddingWidth, y: 0))
            path.addLine(to: CGPoint(x: invisiblePaddingWidth, y: headerHeight))
            path.move(to: CGPoint(x: invisiblePaddingWidth + headerWidth, y: headerHeight))
            path.addLine(to: CGPoint(x: invisiblePaddingWidth + headerWidth, y: 0))
            path.addLine(to: CGPoint(x: invisiblePaddingWidth, y: 0))
            path.move(to: CGPoint(x: self.invisiblePaddingWidth, y: self.headerHeight))
            path.addLine(to: CGPoint(x: self.arrowTerminalWidth, y: self.headerHeight))
            path.move(to: CGPoint(x: invisiblePaddingWidth + headerWidth, y: headerHeight))
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: headerHeight))
            
            // property
            for numberOfItem in 0..<numberOfItems {
                // left
                path.move(to: CGPoint(x: arrowTerminalWidth, y: headerHeight + itemHeight*CGFloat(numberOfItem)))
                path.addLine(to: CGPoint(x: arrowTerminalWidth, y: headerHeight + itemHeight*CGFloat(numberOfItem) + oneVerticalLineWithoutArrow))
                path.addLine(to: CGPoint(x: 0, y: headerHeight + itemHeight*CGFloat(numberOfItem) + oneVerticalLineWithoutArrow))
                path.addLine(to: CGPoint(x: 0, y: headerHeight + itemHeight*CGFloat(numberOfItem) + oneVerticalLineWithoutArrow + arrowTerminalHeight))
                path.addLine(to: CGPoint(x: arrowTerminalWidth, y: headerHeight + itemHeight*CGFloat(numberOfItem) + oneVerticalLineWithoutArrow + arrowTerminalHeight))
                path.addLine(to: CGPoint(x: arrowTerminalWidth, y: headerHeight + itemHeight*CGFloat(numberOfItem) + oneVerticalLineWithoutArrow*2 + arrowTerminalHeight))
                // move to right
                path.move(to: CGPoint(x: width + arrowTerminalWidth, y: headerHeight + itemHeight*CGFloat(numberOfItem)))
                // left
                path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: headerHeight + itemHeight*CGFloat(numberOfItem) + oneVerticalLineWithoutArrow))
                path.addLine(to: CGPoint(x: width + arrowTerminalWidth*2, y: headerHeight + itemHeight*CGFloat(numberOfItem) + oneVerticalLineWithoutArrow))
                path.addLine(to: CGPoint(x: width + arrowTerminalWidth*2, y: headerHeight + itemHeight*CGFloat(numberOfItem) + oneVerticalLineWithoutArrow + arrowTerminalHeight))
                path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: headerHeight + itemHeight*CGFloat(numberOfItem) + oneVerticalLineWithoutArrow + arrowTerminalHeight))
                path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: headerHeight + itemHeight*CGFloat(numberOfItem) + oneVerticalLineWithoutArrow*2 + arrowTerminalHeight))
            }
            
            // footer
            path.move(to: CGPoint(x: arrowTerminalWidth, y: headerHeight + itemHeight*CGFloat(numberOfItems)))
            path.addLine(to: CGPoint(x: arrowTerminalWidth, y: bottomPaddingForLastText + headerHeight*2 + itemHeight*CGFloat(numberOfItems)))
            path.addLine(to: CGPoint(x: invisiblePaddingWidth, y: bottomPaddingForLastText + headerHeight*2 + itemHeight*CGFloat(numberOfItems)))
            path.addLine(to: CGPoint(x: invisiblePaddingWidth, y: bottomPaddingForLastText + headerHeight + itemHeight*CGFloat(numberOfItems)))
            path.addLine(to: CGPoint(x: invisiblePaddingWidth + headerWidth, y: bottomPaddingForLastText + headerHeight + itemHeight*CGFloat(numberOfItems)))
            path.addLine(to: CGPoint(x: invisiblePaddingWidth + headerWidth, y: bottomPaddingForLastText + headerHeight*2 + itemHeight*CGFloat(numberOfItems)))
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: bottomPaddingForLastText + headerHeight*2 + itemHeight*CGFloat(numberOfItems)))
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: headerHeight + itemHeight*CGFloat(numberOfItems)))
        }
        .stroke(lineWidth: 5)
    }
}

struct PropertyFrame_Previews: PreviewProvider {
    static var previews: some View {
        PropertyFrame(width: 600, numberOfItems: 3)
            .frame(width: 1200, height: 1000)
    }
}
