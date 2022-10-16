//
//  TypeView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/13.
//

import SwiftUI

struct TypeView: View {
    
    @State var maxWidth: CGFloat = DetailPartsSettingValues.minWidth
    
    let texts = ["var body",
                 "a",
                 ".frame(width: CGFloat(text.count)*characterWidth)",
                 "DetailPartsWithText",
                ]
    
    var maxStringCount: Int {
        var max = 0
        for string in texts {
            if max < string.count {
                max = string.count
            }
        }
        return max
    }
    
    var width: CGFloat {
        CGFloat(maxStringCount)*35.5
    }
    
    // common
    let connectionHeight = HeaderPartsSettingValues.connectionHeight
    let arrowTerminalWidth = HeaderPartsSettingValues.arrowTerminalWidth
    
    // header parts
    let headerItemHeight = HeaderPartsSettingValues.itemHeight
    let headerBottomPaddingForLastText = HeaderPartsSettingValues.bottomPaddingForLastText
    var headerPartsHeight: CGFloat {
        headerItemHeight*2 + headerBottomPaddingForLastText
    }
    
    // detail parts
    let detailItemHeight = DetailPartsSettingValues.connectionHeight
    let detailBottomPaddingForLastText = DetailPartsSettingValues.bottomPaddingForLastText
    // sample
    var detailPartsHeight: CGFloat {
        connectionHeight + detailItemHeight*4 + detailBottomPaddingForLastText
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            HeaderPartsView(width: width)
                .offset(x: 0, y: 0)
            
            DetailPartsWithText(width: width)
                .offset(x: 0, y: headerPartsHeight)
            
            DetailPartsWithText(width: width)
                .offset(x: 0, y: headerPartsHeight + detailPartsHeight)
            
            DetailPartsWithText(width: width)
                .offset(x: 0, y: headerPartsHeight + detailPartsHeight*2)
        }
        .frame(width: width + arrowTerminalWidth*2, height: headerPartsHeight + detailPartsHeight*3 + connectionHeight)
    }
}

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView()
            .frame(width: 2000, height: 2000)
    }
}
