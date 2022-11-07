//
//  IndexFrameWithText.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/26.
//

import SwiftUI

struct IndexPartsFrameWithText: View {
    let accessLevelIcon: String
    let headerPartsIndexType: IndexType
    
    var text: String {
        if accessLevelIcon == AccessLevel.internal.icon {
            return headerPartsIndexType.string
        } else {
            return accessLevelIcon + "  " + headerPartsIndexType.string
        }
    }
//    var with: CGFloat
//    var height: CGFloat {
//        return with / 3
//    }
    enum IndexType {
        case `struct`
        case `class`
        case `enum`
        case `protocol`
        
        var string: String {
            switch self {
            case .struct:
                return "Struct"
            case .class:
                return "Class"
            case .enum:
                return "Enum"
            case .protocol:
                return "Protocol"
            }
        }
    }
    
    let width = HeaderPartsSettingValues.indexWidth
    let height = HeaderPartsSettingValues.itemHeight
    let borderWidth = HeaderPartsSettingValues.borderWidth
    
    var body: some View {
        ZStack {
            IndexPartsFrame()
                .fill(.gray)
                .frame(width: width, height: height)
            
            IndexPartsFrame()
                .stroke(lineWidth: borderWidth)
                .fill(Color.black)
                .frame(width: width, height: height)
            
            Text(text)
                .lineLimit(1)
                .frame(width: width, height: height)
                .font(.system(size: 50))
                .foregroundColor(.black)
        }
    }
}

struct IndexFrameWithText_Previews: PreviewProvider {
    static var previews: some View {
        IndexPartsFrameWithText(accessLevelIcon: AccessLevel.open.icon, headerPartsIndexType: .protocol)
            .frame(width: 400, height: 400)
    }
}
