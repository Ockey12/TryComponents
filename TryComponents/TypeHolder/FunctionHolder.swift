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
    var parameters = [Parameter]()
    var returnValueType = ""
    
    struct Parameter {
        var externalParameterName: String?
        var internalParameterName: String
        var haveInoutKeyword: Bool
        var type: String
        var isVariadic: Bool
        var defaultParameter: String?
    }
}
