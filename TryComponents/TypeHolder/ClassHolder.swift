//
//  ClassHolder.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/30.
//

import Foundation

struct ClassHolder {
    var accessLevel: AccessLevel = .internal
    var name = ""
    var inheritedClass = ""
    var conformingProtocolNames = [String]()
    var variables = [VariableHolder]()
    var functions = [FunctionHolder]()
    
    // For child types that are nested by this type
    var nestingStructs = [StructHolder]()
    var nestingClasses = [ClassHolder]()
    var nestingEnums = [EnumHolder]()
    
    // For the parent type that nests this type.
    var nestParentTypeName: String?
}
