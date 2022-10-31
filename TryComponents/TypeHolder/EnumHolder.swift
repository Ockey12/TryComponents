//
//  EnumHolder.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/30.
//

import Foundation

struct EnumHolder {
    var accessLevel: AccessLevel = .Internal
    var name = ""
    var rawvalueType = ""
    var conformingProtocols = [String]()
    var cases = [Case]()
    var variables = [VariableHolder]()
    
    // For child types that are nested by this type
    var nestingStructs = [StructHolder]()
    var nestingClasses = [ClassHolder]()
    var nestingEnums = [EnumHolder]()
    
    // For the parent type that nests this type.
    var nestParentTypeName: String?
    
    struct Case {
        var caseName: String
        var rawvalue: String
        var associatedValue: String
    }
}
