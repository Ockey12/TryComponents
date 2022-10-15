//
//  DetailPartsWithText.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/05.
//

import SwiftUI

struct DetailPartsWithText: View {
    var width: CGFloat = DetailPartsSettingValues.minWidth
    var widthFromLeftEdgeToConnection: CGFloat {
        (width - headerWidth) / 2 + arrowTerminalWidth
    }
    
    @State private var maxTextWidth: CGFloat = 0
    
    let headerHeight = DetailPartsSettingValues.connectionHeight
    let headerWidth = DetailPartsSettingValues.connectionWidth
    let itemHeight = DetailPartsSettingValues.itemHeight
    let arrowTerminalWidth = DetailPartsSettingValues.arrowTerminalWidth
    let textLeadingPadding = DetailPartsSettingValues.textLeadingPadding
    let textTrailPadding = DetailPartsSettingValues.textTrailPadding
    let borderWidth = DetailPartsSettingValues.borderWidth
    
    let texts = ["var body",
                 "a",
                 ".frame(width: CGFloat(text.count)*characterWidth)",
                 "DetailPartsWithText",
                ]
    
    var body: some View {
        ZStack {
            DetailPartsFrame(width: width, numberOfItems: texts.count)
                .fill(.white)
            
            DetailPartsFrame(width: width, numberOfItems: texts.count)
                .stroke(lineWidth: borderWidth)
                .fill(.black)

            // connection header title
            Text("Rawvalue Type")
                .lineLimit(1)
                .font(.system(size:50))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .background(.clear)
                .frame(width: headerWidth, height: headerHeight)
                .multilineTextAlignment(.center)
                .position(x: width/2 + arrowTerminalWidth, y: headerHeight/2)
            
            // invisible View
            // get max width of texts
            ForEach(0..<texts.count, id: \.self) { numberOfText in
                Text(texts[numberOfText])
                    .lineLimit(1)
                    .font(.system(size: 50))
                    .foregroundColor(.clear)
                    .background(.clear)
                    .getMaxTextWidth(maxWidth: $maxTextWidth)
                    .position(x: width/2 + arrowTerminalWidth,
                              y: headerHeight + itemHeight*CGFloat(numberOfText) + itemHeight/2)
            }

            // visible View
            ForEach(0..<texts.count, id: \.self) { numberOfText in
                Text(texts[numberOfText])
                    .lineLimit(1)
                    .font(.system(size: 50))
                    .foregroundColor(.black)
                    .background(.white)
                    .frame(width: width, alignment: .leading)
                    .position(x: (width + textLeadingPadding )/2 + arrowTerminalWidth,
                              y: headerHeight + itemHeight*CGFloat(numberOfText) + itemHeight/2)
            }
        }
    }
    
    func getMaxWidth() -> CGFloat {
        return maxTextWidth
    }
}

struct DetailPartsWithText_Previews: PreviewProvider {
    static var previews: some View {
        DetailPartsWithText(width: 1500)
            .frame(width: 1530, height: 600)
    }
}
