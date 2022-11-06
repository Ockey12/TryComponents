//
//  DetailPartsType.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/11/06.
//

import Foundation

enum DetailPartsType {
    case parentClass
    case rawvalueType
    case `protocol`
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
        case .protocol:
            return "Protocol"
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
