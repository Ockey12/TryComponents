//
//  FunctionParameterHolder.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/11/03.
//

import Foundation

struct FunctionParameterHolder {
    var externalParameterName: String?
    var internalParameterName: String
    var haveInoutKeyword = false
    var type: String
    var isVariadic = false
    var defaultParameter: String?
}
