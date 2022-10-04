//
//  Property.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/04.
//

import SwiftUI

struct Property: View {
    var width: CGFloat
    var initialPositionY: CGFloat = 90
    var numberOfItems: Int
    var invisiblePaddingWidth: CGFloat {
        (self.width - self.headerWidth) / 2 + self.arrowTerminalWidth
    }
    let headerWidth: CGFloat = 350
    let arrowTerminalWidth: CGFloat = 30
    
    var body: some View {
        Path { path in
            // property.left
            path.move(to: CGPoint(x: arrowTerminalWidth, y: initialPositionY))
            path.addLine(to: CGPoint(x: arrowTerminalWidth, y: initialPositionY + arrowTerminalWidth))
            path.addLine(to: CGPoint(x: 0, y: initialPositionY + arrowTerminalWidth))
            path.addLine(to: CGPoint(x: 0, y: initialPositionY + arrowTerminalWidth*2))
            path.addLine(to: CGPoint(x: arrowTerminalWidth, y: initialPositionY + arrowTerminalWidth*2))
            path.addLine(to: CGPoint(x: arrowTerminalWidth, y: initialPositionY + arrowTerminalWidth*3))
            // fromLeftToRight
            path.move(to: CGPoint(x: width + arrowTerminalWidth, y: initialPositionY))
            // property.left
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: initialPositionY + arrowTerminalWidth))
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth*2, y: initialPositionY + arrowTerminalWidth))
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth*2, y: initialPositionY + arrowTerminalWidth*2))
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: initialPositionY + arrowTerminalWidth*2))
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: initialPositionY + arrowTerminalWidth*3))
        }
        .stroke(lineWidth: 5)
    }
}

struct Property_Previews: PreviewProvider {
    static var previews: some View {
        Property(width: 800, initialPositionY: 180, numberOfItems: 3)
            .frame(width: 860)
    }
}
