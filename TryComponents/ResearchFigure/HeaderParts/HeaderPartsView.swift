//
//  HeaderPartsView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/26.
//

import SwiftUI

struct HeaderPartsView: View {
    var width: CGFloat
    
    let indexWidth = HeaderPartsSettingValues.indexWidth
    let itemHeight = HeaderPartsSettingValues.itemHeight
    let connectionHeight = HeaderPartsSettingValues.connectionHeight
    let oneVerticalLineWithoutArrow = HeaderPartsSettingValues.oneVerticalLineWithoutArrow
    let arrowTerminalWidth = HeaderPartsSettingValues.arrowTerminalWidth
    let arrowTerminalHeight = HeaderPartsSettingValues.arrowTerminalHeight
    let bottomPaddingForLastText = HeaderPartsSettingValues.bottomPaddingForLastText
    
    var body: some View {
        ZStack(alignment: .topLeading) {
//            IndexFrameWithText()
//                .position(x: arrowTerminalWidth + indexWidth/2, y: itemHeight/2)
//
//            HeaderPartsFrameWithText(width: width)
//                .position(x: arrowTerminalWidth +  width/2, y: itemHeight + (oneVerticalLineWithoutArrow*2 + arrowTerminalHeight + bottomPaddingForLastText + connectionHeight)/2)
            
            IndexFrameWithText()
                .offset(x: arrowTerminalWidth, y: 0)
            
            HeaderPartsFrameWithText(width: width)
                .offset(x: 0, y: itemHeight)
        }
    }
}

struct HeaderPartsView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPartsView(width: 1200)
            .frame(width: 1500, height: 300)
    }
}
