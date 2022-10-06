//
//  DetailPartsWithText.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/05.
//

import SwiftUI

struct DetailPartsWithText: View {
    var width: CGFloat = DetailPartsSettingValues.minWidth
    @State private var maxTextWidth: CGFloat = 0
    
    let headerHeight = DetailPartsSettingValues.headerHeight
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
            DetailPartsFrame(width: width + textTrailPadding, numberOfItems: texts.count)
                .fill(.white)
            
            DetailPartsFrame(width: width + textTrailPadding, numberOfItems: texts.count)
                .stroke(lineWidth: borderWidth)
                .fill(.black)
            
            // get max width of texts
            ForEach(0..<texts.count, id: \.self) { numberOfText in
                Text(texts[numberOfText])
                    .lineLimit(1)
                    .font(.system(size: 50))
                    .foregroundColor(.clear)
                    .background(.clear)
//                    .border(.clear, width: 1)
                    .getMaxTextWidth(maxWidth: $maxTextWidth)
                    .position(x: width/2 + arrowTerminalWidth,
                              y: headerHeight + itemHeight*CGFloat(numberOfText) + itemHeight/2)
            }

            ForEach(0..<texts.count, id: \.self) { numberOfText in
                Text(texts[numberOfText])
                    .lineLimit(1)
                    .font(.system(size: 50))
                    .foregroundColor(.black)
                    .background(.white)
//                    .border(.white, width: 1)
                    .frame(width: width + textTrailPadding, alignment: .leading)
                    .position(x: (width + textLeadingPadding + textTrailPadding)/2 + arrowTerminalWidth,
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
            .frame(width: 2000, height: 1000)
    }
}
