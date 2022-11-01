//
//  ProtocolHolder.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/11/01.
//

import Foundation

struct ProtocolHolder {
    var name = ""
    var variables = [VariableHolder]()
    var functions = [FunctionHolder]()
    var inheritedProtocols = [ProtocolHolder]()
}
