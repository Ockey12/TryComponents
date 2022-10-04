//
//  PropertyFrame.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/30.
//

import SwiftUI

struct PropertyFrame: Shape {
    var width: CGFloat
    var invisiblePaddingWidth: CGFloat {
        (self.width - self.headerWidth) / 2 + self.arrowTerminalWidth
    }
    
    let headerWidth: CGFloat = 350
    let headerHeight: CGFloat = 90
    let arrowTerminalWidth: CGFloat = 30
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            // header
            path.move(to: CGPoint(x: self.invisiblePaddingWidth, y: 0))
            path.addLine(to: CGPoint(x: self.invisiblePaddingWidth, y: self.headerHeight))
            path.move(to: CGPoint(x: self.invisiblePaddingWidth + self.headerWidth, y: self.headerHeight))
            path.addLine(to: CGPoint(x: self.invisiblePaddingWidth + self.headerWidth, y: 0))
            path.addLine(to: CGPoint(x: self.invisiblePaddingWidth, y: 0))
            
            // property.left
            path.move(to: CGPoint(x: self.invisiblePaddingWidth, y: self.headerHeight))
            path.addLine(to: CGPoint(x: self.arrowTerminalWidth, y: self.headerHeight))
            path.addLine(to: CGPoint(x: self.arrowTerminalWidth, y: self.headerHeight + self.arrowTerminalWidth))
            path.addLine(to: CGPoint(x: 0, y: self.headerHeight + self.arrowTerminalWidth))
            path.addLine(to: CGPoint(x: 0, y: self.headerHeight + self.arrowTerminalWidth * 2))
            path.addLine(to: CGPoint(x: self.arrowTerminalWidth, y: self.headerHeight + self.arrowTerminalWidth * 2))
            path.addLine(to: CGPoint(x: self.arrowTerminalWidth, y: self.headerHeight + self.arrowTerminalWidth * 3))
            // fromLeftToRight
            path.move(to: CGPoint(x: self.width + self.arrowTerminalWidth, y: self.headerHeight + self.arrowTerminalWidth * 3))
            // property.right
            path.addLine(to: CGPoint(x: self.width + self.arrowTerminalWidth, y: self.headerHeight + self.arrowTerminalWidth * 2))
            path.addLine(to: CGPoint(x: self.width + self.arrowTerminalWidth * 2, y: self.headerHeight + self.arrowTerminalWidth * 2))
            path.addLine(to: CGPoint(x: self.width + self.arrowTerminalWidth * 2, y: self.headerHeight + self.arrowTerminalWidth))
            path.addLine(to: CGPoint(x: self.width + self.arrowTerminalWidth, y: self.headerHeight + self.arrowTerminalWidth))
            path.addLine(to: CGPoint(x: self.width + self.arrowTerminalWidth, y: self.headerHeight))
            path.addLine(to: CGPoint(x: self.invisiblePaddingWidth + self.headerWidth, y: self.headerHeight))
            
            // footer
            path.move(to: CGPoint(x: self.arrowTerminalWidth, y: self.headerHeight + self.arrowTerminalWidth * 3))
            path.addLine(to: CGPoint(x: self.arrowTerminalWidth, y: self.headerHeight + self.arrowTerminalWidth * 3 + self.headerHeight))
            path.addLine(to: CGPoint(x: self.invisiblePaddingWidth, y: self.headerHeight + self.arrowTerminalWidth * 3 + self.headerHeight))
            path.addLine(to: CGPoint(x: self.invisiblePaddingWidth, y: self.headerHeight + self.arrowTerminalWidth * 3))
            path.addLine(to: CGPoint(x: self.invisiblePaddingWidth + self.headerWidth, y: self.headerHeight + self.arrowTerminalWidth * 3))
            path.addLine(to: CGPoint(x: self.invisiblePaddingWidth + self.headerWidth, y: self.headerHeight + self.arrowTerminalWidth * 3 + self.headerHeight))
            path.addLine(to: CGPoint(x: self.width + self.arrowTerminalWidth, y: self.headerHeight + self.arrowTerminalWidth * 3 + self.headerHeight))
            path.addLine(to: CGPoint(x: self.width + self.arrowTerminalWidth, y: self.headerHeight + self.arrowTerminalWidth * 3))
        }
    }
}

struct PropertyFrame_Previews: PreviewProvider {
    static var previews: some View {
        PropertyFrame(width: 800)
            .stroke()
            .frame(width: 860)
    }
}
