//
//  DetailPartsWithText.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/05.
//

import SwiftUI

struct DetailPartsWithText: View {
    @State var maxTextWidth: CGFloat = 600
    
    let texts = ["var body",
                 "a",
                 ".frame(width: CGFloat(text.count)*characterWidth)",
                 "DetailPartsWithText"
                ]
    
    var body: some View {
        ZStack {
            DetailPartsFrame(width: maxTextWidth, numberOfItems: texts.count)
                .fill(.white)
            
            DetailPartsFrame(width: maxTextWidth, numberOfItems: texts.count)
                .stroke(lineWidth: DetailPartsSettingValues.borderWidth)
                .fill(.black)
            
            ForEach(0..<texts.count, id: \.self) { numberOfText in
                Text(texts[numberOfText])
                    .lineLimit(1)
                    .font(.system(size: 50))
                    .foregroundColor(.black)
                    .background(.blue)
                    .border(.pink, width: 1)
                    .background(GeometryReader{ geometry -> Text in
                        getTextWidth(width: geometry.size.width)
                        return Text("")
                    })
                    .position(x: maxTextWidth/2 + DetailPartsSettingValues.arrowTerminalWidth,
                              y: DetailPartsSettingValues.headerHeight + DetailPartsSettingValues.itemHeight*CGFloat(numberOfText) + DetailPartsSettingValues.itemHeight/2)
            }
        }
    }
    
    func getTextWidth(width: CGFloat) {
        if self.maxTextWidth < width {
            self.maxTextWidth = width
        }
    }
}

struct DetailPartsWithText_Previews: PreviewProvider {
    static var previews: some View {
        DetailPartsWithText()
            .frame(width: 2000, height: 1000)
    }
}
