//
//  HeaderPartsFrameWithText.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/26.
//

import SwiftUI

struct HeaderPartsFrameWithText: View {
    var width: CGFloat
    @State private var maxTextWidth: CGFloat = 0
    
    let itemHeight = HeaderPartsSettingValues.itemHeight
    let arrowTerminalWidth = HeaderPartsSettingValues.arrowTerminalWidth
    let textLeadingPadding = HeaderPartsSettingValues.textLeadingPadding
    let textTrailPadding = HeaderPartsSettingValues.textTrailPadding
    let borderWidth = HeaderPartsSettingValues.borderWidth
    
    var body: some View {
        ZStack {
            HeaderPartsFrame(width: width)
                .foregroundColor(.white)
            
            HeaderPartsFrame(width: width)
                .stroke(lineWidth: borderWidth)
                .fill(Color.black)
            
            // invisible View
            // get max width of texts
            Text("Counter")
                .lineLimit(1)
                .font(.system(size: 50))
                .foregroundColor(.clear)
                .background(.clear)
                .getMaxTextWidth(maxWidth: $maxTextWidth)
                .position(x: width/2 + arrowTerminalWidth, y: itemHeight/2)
            
            // visible View
            Text("Counter")
                .lineLimit(1)
                .font(.system(size: 50))
                .foregroundColor(.black)
                .background(.white)
                .frame(width: width, alignment: .leading)
                .position(x: (width + textLeadingPadding)/2 + arrowTerminalWidth, y: itemHeight/2)
        }
    }
    
    func getMaxWidth() -> CGFloat {
        return maxTextWidth
    }
}

struct HeaderPartsFrameWithText_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPartsFrameWithText(width: 1000)
            .frame(width: 1030, height: 200)
            
    }
}
