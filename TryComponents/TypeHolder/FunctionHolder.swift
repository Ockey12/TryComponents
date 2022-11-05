//
//  FuncHolder.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/30.
//

import Foundation

struct FunctionHolder {
    var accessLevel: AccessLevel = .Internal
    var name = ""
    var genericParameters = [String]()
    var parameters = [FunctionParameterHolder]()
    var returnValueType: String?
}
