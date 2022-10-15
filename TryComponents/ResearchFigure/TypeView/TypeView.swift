//
//  TypeView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/13.
//

import SwiftUI

struct TypeView: View {
    
    @State var maxWidth: CGFloat = DetailPartsSettingValues.minWidth
    
    // common
    let connectionHeight = HeaderPartsSettingValues.connectionHeight
    
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
            
//            maxWidth = DetailPartsWithText().getMaxWidth()
            
            HeaderPartsView(width: 1200)
                .offset(x: 0, y: 0)
            
            DetailPartsWithText(width: 1200)
                .offset(x: 0, y: headerPartsHeight)
            
            DetailPartsWithText(width: 1200)
                .offset(x: 0, y: headerPartsHeight + detailPartsHeight)
            
            DetailPartsWithText(width: 1200)
                .offset(x: 0, y: headerPartsHeight + detailPartsHeight*2)
        }
        .frame(width: 1230, height: headerPartsHeight + detailPartsHeight*3 + connectionHeight)
    }
}

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView()
            .frame(width: 1500, height: 2000)
    }
}
