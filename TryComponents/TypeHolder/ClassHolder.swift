//
//  ClassHolder.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/30.
//

import Foundation

struct ClassHolder {
    var accessLevel: AccessLevel
    var name: String
    var inheritedClass: String
    var conformingProtocols: [String]
    var propertys: [PropertyHolder]
    var functions: [FuncHolder]
    var nestedStructs: [StructHolder]
    var nestedClasses: [ClassHolder]
    var nestedEnums: [EnumHolder]
}