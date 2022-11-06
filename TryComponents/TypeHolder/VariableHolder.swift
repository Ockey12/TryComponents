//
//  VariableHolder.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/30.
//

import Foundation

struct VariableHolder {
    var customAttribute: String?
    var haveStaticKeyword = false
    var accessLevel: AccessLevel = .internal
    var isVariable = true
    var name = ""
    var type: String?
    var initialValue: String?
}
