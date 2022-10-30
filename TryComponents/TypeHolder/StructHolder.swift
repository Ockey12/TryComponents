//
//  StructHolder.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/30.
//

import Foundation

struct StructHolder {
    var accessLevel: AccessLevel
    var name: String
    var conformingProtocols: [String]
    var propertys: [PropertyHolder]
    var functions: [FuncHolder]
    var nestedStructs: [StructHolder]
    var nestedClasses: [ClassHolder]
    var nestedEnums: [EnumHolder]
}
