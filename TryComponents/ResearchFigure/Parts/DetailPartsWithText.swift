//
//  DetailPartsWithText.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/05.
//

import SwiftUI

extension View {
    func getMaxTextWidth(maxWidth: Binding<CGFloat>) -> some View {
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

//extension View {
//    func getTextTmpWidth(tmpWidth: Binding<CGFloat>) -> some View {
//        background(GeometryReader { geometry -> Color in
//            DispatchQueue.main.async {
//                tmpWidth.wrappedValue = geometry.size.width
//            }
//            return Color.clear
//        })
//    }
//}

struct DetailPartsWithText: View {
    @State private var maxTextWidth: CGFloat = 0
    let trailPadding: CGFloat = 100
    
    let texts = ["var body",
                 "a",
                 ".frame(width: CGFloat(text.count)*characterWidth)",
                 "DetailPartsWithText",
                ]
    
    var body: some View {
        ZStack {
            DetailPartsFrame(width: maxTextWidth + trailPadding, numberOfItems: texts.count)
                .fill(.white)
            
            DetailPartsFrame(width: maxTextWidth + trailPadding, numberOfItems: texts.count)
                .stroke(lineWidth: DetailPartsSettingValues.borderWidth)
                .fill(.black)
            
            // get max width of texts
            ForEach(0..<texts.count, id: \.self) { numberOfText in
                Text(texts[numberOfText])
                    .lineLimit(1)
                    .font(.system(size: 50))
                    .foregroundColor(.clear)
                    .background(.clear)
                    .border(.clear, width: 1)
                    .getMaxTextWidth(maxWidth: $maxTextWidth)
                    .position(x: maxTextWidth/2 + DetailPartsSettingValues.arrowTerminalWidth,
                              y: DetailPartsSettingValues.headerHeight + DetailPartsSettingValues.itemHeight*CGFloat(numberOfText) + DetailPartsSettingValues.itemHeight/2)
            }

            ForEach(0..<texts.count, id: \.self) { numberOfText in
                Text(texts[numberOfText])
                    .lineLimit(1)
                    .font(.system(size: 50))
                    .foregroundColor(.black)
                    .background(.white)
                    .border(.white, width: 1)
                    .frame(width: maxTextWidth + trailPadding, alignment: .leading)
                    .position(x: (maxTextWidth + trailPadding + 30)/2 + DetailPartsSettingValues.arrowTerminalWidth,
                              y: DetailPartsSettingValues.headerHeight + DetailPartsSettingValues.itemHeight*CGFloat(numberOfText) + DetailPartsSettingValues.itemHeight/2)
            }
        }
    }
    
    func getMaxWidth() -> CGFloat {
        return maxTextWidth
    }
}

struct DetailPartsWithText_Previews: PreviewProvider {
    static var previews: some View {
        DetailPartsWithText()
            .frame(width: 2000, height: 1000)
    }
}
