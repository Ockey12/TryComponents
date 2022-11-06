//
//  AccessLevelIcon.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/11/06.
//

import Foundation

enum AccessLevel {
    case `open`
    case `public`
    case `internal`
    case `fileprivate`
    case `private`
    
    var icon: String {
        switch self {
        case .open:
            return "○"
        case .public:
            return "●"
        case .internal:
            return " "
        case .fileprivate:
            return "△"
        case .private:
            return "▲"
        }
    }
}
