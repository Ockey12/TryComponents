//
//  DetailPartsWithText.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/05.
//

import SwiftUI

struct DetailPartsView: View {
    let detailPartsType: PartsType
    let texts: [String]
    var width: CGFloat // = DetailPartsSettingValues.minWidth
    var widthFromLeftEdgeToConnection: CGFloat {
        (width - headerWidth) / 2 + arrowTerminalWidth
    }
    
    enum PartsType {
        case parentClass
        case rawvalueType
        case conform
        case `case`
        case nested
        case property
        case initializer
        case method
        case `extension`
        
        var string: String {
            switch self {
            case .parentClass:
                return "Parent Class"
            case .rawvalueType:
                return "Rawvalue Type"
            case .conform:
                return "Conform"
            case .case:
                return "Case"
            case .nested:
                return "Nested"
            case .property:
                return "Property"
            case .initializer:
                return "Initializer"
            case .method:
                return "Method"
            case .extension:
                return "Extension"
            }
        }
    }
    
//    @State private var maxTextWidth: CGFloat = 0
    
    let headerHeight = DetailPartsSettingValues.connectionHeight
    let headerWidth = DetailPartsSettingValues.connectionWidth
    let itemHeight = DetailPartsSettingValues.itemHeight
    let arrowTerminalWidth = DetailPartsSettingValues.arrowTerminalWidth
    let textLeadingPadding = DetailPartsSettingValues.textLeadingPadding
//    let textTrailPadding = DetailPartsSettingValues.textTrailPadding
    let borderWidth = DetailPartsSettingValues.borderWidth
    
//    let texts = ["var body",
//                 "a",
//                 ".frame(width: CGFloat(text.count)*characterWidth)",
//                 "DetailPartsWithText",
//                ]
    
    var body: some View {
        ZStack {
            DetailPartsFrame(width: width, numberOfItems: texts.count)
                .fill(.white)
            
            DetailPartsFrame(width: width, numberOfItems: texts.count)
                .stroke(lineWidth: borderWidth)
                .fill(.black)

            // connection header title
            Text(detailPartsType.string)
                .lineLimit(1)
                .font(.system(size:50))
//                .bold() 
//                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .background(.clear)
                .frame(width: headerWidth, height: headerHeight)
                .multilineTextAlignment(.center)
                .position(x: width/2 + arrowTerminalWidth, y: headerHeight/2)
            
            // invisible View
            // get max width of texts
//            ForEach(0..<texts.count, id: \.self) { numberOfText in
//                Text(texts[numberOfText])
//                    .lineLimit(1)
//                    .font(.system(size: 50))
//                    .foregroundColor(.clear)
//                    .background(.clear)
//                    .getMaxTextWidth(maxWidth: $maxTextWidth)
//                    .position(x: width/2 + arrowTerminalWidth,
//                              y: headerHeight + itemHeight*CGFloat(numberOfText) + itemHeight/2)
//            }

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
    
//    func getMaxWidth() -> CGFloat {
//        return maxTextWidth
//    }
}

struct DetailPartsWithText_Previews: PreviewProvider {
    static var previews: some View {
        DetailPartsView(detailPartsType: .rawvalueType, texts: ["aaaaaaaaaaaaaaaaa",
                                                                    "a",
                                                                    ".frame(width: CGFloat(text.count)*characterWidth)",
                                                                    "DetailPartsWithText",
                                                                    "DetailPartsWithText",
                                                                   ], width: 1200)
            .frame(width: 1230, height: 600)
    }
}
