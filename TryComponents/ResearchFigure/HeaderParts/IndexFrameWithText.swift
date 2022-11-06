//
//  IndexFrameWithText.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/26.
//

import SwiftUI

struct IndexFrameWithText: View {
    let accessLevelIcon: AccessLevelIcon
    let headerPartsIndexType: HeaderPartsIndexType
//    var with: CGFloat
//    var height: CGFloat {
//        return with / 3
//    }
    let width = HeaderPartsSettingValues.indexWidth
    let height = HeaderPartsSettingValues.itemHeight
    let borderWidth = HeaderPartsSettingValues.borderWidth
    
    var body: some View {
        ZStack {
            IndexFrame()
                .fill(.gray)
                .frame(width: width, height: height)
            
            IndexFrame()
                .stroke(lineWidth: borderWidth)
                .fill(Color.black)
                .frame(width: width, height: height)
            
            Text(accessLevelIcon.icon + "  " + headerPartsIndexType.string)
                .lineLimit(1)
                .frame(width: width, height: height)
                .font(.system(size: 50))
                .foregroundColor(.black)
        }
    }
}

struct IndexFrameWithText_Previews: PreviewProvider {
    static var previews: some View {
        IndexFrameWithText(accessLevelIcon: .open, headerPartsIndexType: .protocol)
            .frame(width: 400, height: 400)
    }
}
