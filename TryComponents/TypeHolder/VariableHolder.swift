//
//  VariableHolder.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/30.
//

import Foundation

struct VariableHolder {
    var havePropertyWrapper: Bool
    var haveStaticKeyword: Bool
    var accessLevel: AccessLevel
    var isVariable: Bool
    var name: String
    var type: String
    var initialValue: String
}
