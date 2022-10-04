//
//  PropertyFrame.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/30.
//

import SwiftUI

struct PropertyFrame: Shape {
    var width: CGFloat
    var numberOfItems: Int
    var invisiblePaddingWidth: CGFloat {
        (self.width - self.headerWidth) / 2 + self.arrowTerminalWidth
    }
    @State var maxY: CGFloat = 90
    
    let headerWidth: CGFloat = 350
    let headerHeight: CGFloat = 90
    let arrowTerminalWidth: CGFloat = 30
    let bottomPaddingForLastText: CGFloat = 30
    
    func path(in rect: CGRect) -> Path {
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
            for numberOfItem in 1...numberOfItems {
                // left
                path.move(to: CGPoint(x: arrowTerminalWidth, y: headerHeight*CGFloat(numberOfItem)))
                path.addLine(to: CGPoint(x: arrowTerminalWidth, y: headerHeight*CGFloat(numberOfItem) + arrowTerminalWidth))
                path.addLine(to: CGPoint(x: 0, y: headerHeight*CGFloat(numberOfItem) + arrowTerminalWidth))
                path.addLine(to: CGPoint(x: 0, y: headerHeight*CGFloat(numberOfItem) + arrowTerminalWidth*2))
                path.addLine(to: CGPoint(x: arrowTerminalWidth, y: headerHeight*CGFloat(numberOfItem) + arrowTerminalWidth*2))
                path.addLine(to: CGPoint(x: arrowTerminalWidth, y: headerHeight*CGFloat(numberOfItem) + arrowTerminalWidth*3))
                // move to right
                path.move(to: CGPoint(x: width + arrowTerminalWidth, y: headerHeight*CGFloat(numberOfItem)))
                // left
                path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: headerHeight*CGFloat(numberOfItem) + arrowTerminalWidth))
                path.addLine(to: CGPoint(x: width + arrowTerminalWidth*2, y: headerHeight*CGFloat(numberOfItem) + arrowTerminalWidth))
                path.addLine(to: CGPoint(x: width + arrowTerminalWidth*2, y: headerHeight*CGFloat(numberOfItem) + arrowTerminalWidth*2))
                path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: headerHeight*CGFloat(numberOfItem) + arrowTerminalWidth*2))
                path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: headerHeight*CGFloat(numberOfItem) + arrowTerminalWidth*3))
            }
            
            // footer
            path.move(to: CGPoint(x: arrowTerminalWidth, y: headerHeight*CGFloat(numberOfItems + 1)))
            path.addLine(to: CGPoint(x: arrowTerminalWidth, y: bottomPaddingForLastText + headerHeight*CGFloat(numberOfItems + 2)))
            path.addLine(to: CGPoint(x: invisiblePaddingWidth, y: bottomPaddingForLastText + headerHeight*CGFloat(numberOfItems + 2)))
            path.addLine(to: CGPoint(x: invisiblePaddingWidth, y: bottomPaddingForLastText + headerHeight*CGFloat(numberOfItems + 1)))
            path.addLine(to: CGPoint(x: invisiblePaddingWidth + headerWidth, y: bottomPaddingForLastText + headerHeight*CGFloat(numberOfItems + 1)))
            path.addLine(to: CGPoint(x: invisiblePaddingWidth + headerWidth, y: bottomPaddingForLastText + headerHeight*CGFloat(numberOfItems + 2)))
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: bottomPaddingForLastText + headerHeight*CGFloat(numberOfItems + 2)))
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: headerHeight*CGFloat(numberOfItems + 1)))
        }
    }
}

struct PropertyFrame_Previews: PreviewProvider {
    static var previews: some View {
        PropertyFrame(width: 600, numberOfItems: 3)
            .stroke(lineWidth: 5)
            .frame(width: 1200, height: 1000)
    }
}
