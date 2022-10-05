//
//  DetailPartsWithText.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/05.
//

import SwiftUI

extension View {
    func getTextMaxWidth(maxWidth: Binding<CGFloat>) -> some View {
        background(GeometryReader { geometry -> Color in
            if maxWidth.wrappedValue < geometry.size.width {
                DispatchQueue.main.async {
                    maxWidth.wrappedValue = geometry.size.width
                }
            }
            return Color.clear
        })
    }
}

extension View {
    func getTextTmpWidth(tmpWidth: Binding<CGFloat>) -> some View {
        background(GeometryReader { geometry -> Color in
            DispatchQueue.main.async {
                tmpWidth.wrappedValue = geometry.size.width
            }
            return Color.clear
        })
    }
}

struct DetailPartsWithText: View {
    @State var maxTextWidth: CGFloat = 0
    @State var tmpTextWidth: CGFloat = 0
    
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
//                    .background(GeometryReader{ geometry -> Text in
//                        getMaxTextWidth(width: geometry.size.width)
//                        getTmpTextWidth(width: geometry.size.width)
//                        return Text("")
//                    })
                    .getTextMaxWidth(maxWidth: $maxTextWidth)
                    .getTextTmpWidth(tmpWidth: $tmpTextWidth)
                    .position(x: tmpTextWidth/2 + DetailPartsSettingValues.arrowTerminalWidth,
                              y: DetailPartsSettingValues.headerHeight + DetailPartsSettingValues.itemHeight*CGFloat(numberOfText) + DetailPartsSettingValues.itemHeight/2)
                let _ = print("\(numberOfText):tmp:\(tmpTextWidth)")
                let _ = print("\(numberOfText):max:\(maxTextWidth)")
            }
        }
    }
    
//    func getMaxTextWidth(width: CGFloat) {
//        if self.maxTextWidth < width {
//            self.maxTextWidth = width
//        }
//    }
//
//    func getTmpTextWidth(width: CGFloat) {
//        self.tmpTextWidth = width
//    }
}

struct DetailPartsWithText_Previews: PreviewProvider {
    static var previews: some View {
        DetailPartsWithText()
            .frame(width: 2000, height: 1000)
    }
}
