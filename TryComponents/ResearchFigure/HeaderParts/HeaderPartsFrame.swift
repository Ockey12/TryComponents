//
//  HeaderPartsFrame.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/26.
//

import SwiftUI

struct HeaderPartsFrame: Shape {
    var width: CGFloat
    var widthFromLeftEdgeToConnection: CGFloat {
        (width - connectionWidth) / 2 + arrowTerminalWidth
    }
    
    let connectionWidth = HeaderPartsSettingValues.connectionWidth
    let connectionHeight = HeaderPartsSettingValues.connectionHeight
    let itemHeight = HeaderPartsSettingValues.itemHeight
    let oneVerticalLineWithoutArrow = HeaderPartsSettingValues.oneVerticalLineWithoutArrow
    let arrowTerminalWidth = HeaderPartsSettingValues.arrowTerminalWidth
    let arrowTerminalHeight = HeaderPartsSettingValues.arrowTerminalHeight
    let bottomPaddingForLastText = HeaderPartsSettingValues.bottomPaddingForLastText
    let borderWidth = HeaderPartsSettingValues.borderWidth
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            // left side
            // from top to bottom
            path.move(to: CGPoint(x: arrowTerminalWidth, y: 0))
            path.addLine(to: CGPoint(x: arrowTerminalWidth, y: oneVerticalLineWithoutArrow))
            path.addLine(to: CGPoint(x: 0, y: oneVerticalLineWithoutArrow))
            path.addLine(to: CGPoint(x: 0, y: oneVerticalLineWithoutArrow + arrowTerminalHeight))
            path.addLine(to: CGPoint(x: arrowTerminalWidth, y: oneVerticalLineWithoutArrow + arrowTerminalHeight))
            path.addLine(to: CGPoint(x: arrowTerminalWidth, y: oneVerticalLineWithoutArrow*2 + arrowTerminalHeight + bottomPaddingForLastText + connectionHeight))
            
            // bottom
            // from left to right
            path.addLine(to: CGPoint(x: widthFromLeftEdgeToConnection, y: oneVerticalLineWithoutArrow*2 + arrowTerminalHeight + bottomPaddingForLastText + connectionHeight))
            path.addLine(to: CGPoint(x: widthFromLeftEdgeToConnection, y: oneVerticalLineWithoutArrow*2 + arrowTerminalHeight + bottomPaddingForLastText))
            path.addLine(to: CGPoint(x: widthFromLeftEdgeToConnection + connectionWidth, y: oneVerticalLineWithoutArrow*2 + arrowTerminalHeight + bottomPaddingForLastText))
            path.addLine(to: CGPoint(x: widthFromLeftEdgeToConnection + connectionWidth, y: oneVerticalLineWithoutArrow*2 + arrowTerminalHeight + bottomPaddingForLastText + connectionHeight))
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: oneVerticalLineWithoutArrow*2 + arrowTerminalHeight + bottomPaddingForLastText + connectionHeight))
            
            // right side
            // from bottom to top
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: oneVerticalLineWithoutArrow + arrowTerminalHeight))
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth*2, y: oneVerticalLineWithoutArrow + arrowTerminalHeight))
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth*2, y: oneVerticalLineWithoutArrow))
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: oneVerticalLineWithoutArrow))
            path.addLine(to: CGPoint(x: width + arrowTerminalWidth, y: 0))
            path.closeSubpath()
        }
    }
}

struct HeaderPartsFrame_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPartsFrame(width: 800)
            .frame(width: 830, height: 300)
    }
}
