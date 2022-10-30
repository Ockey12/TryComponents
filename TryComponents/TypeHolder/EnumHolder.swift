//
//  EnumHolder.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/30.
//

import Foundation

struct EnumHolder {
    var accessLevel: AccessLevel
    var name: String
    var rawvalueType: String
    var conformingProtocols: [String]
    var cases: [Case]
    
    struct Case {
        var caseName: String
        var rawvalue: String
        var associatedValue: String
    }
}
