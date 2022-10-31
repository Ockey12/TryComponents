//
//  VariableHolder.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/30.
//

import Foundation

struct VariableHolder {
    var havePropertyWrapper = false
    var haveStaticKeyword = false
    var accessLevel: AccessLevel = .Internal
    var isVariable = true
    var name = ""
    var type = ""
    var initialValue = ""
}
