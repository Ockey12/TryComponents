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
    
    // For child types that are nested by this type
    var nestingStructs: [StructHolder]
    var nestingClasses: [ClassHolder]
    var nestingEnums: [EnumHolder]
    
    // For the parent type that nests this type.
    var nestParentTypeName: String?
}
