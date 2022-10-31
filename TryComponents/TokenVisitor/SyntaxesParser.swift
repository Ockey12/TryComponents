//
//  SyntaxesParser.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/31.
//

import Foundation

struct SyntaxesParser {
//    var syntaxes: [String]
    
    var stackArray = [StackArrayElement]()
    var structHolders: [String: StructHolder]
    var classHolders: [String: ClassHolder]
    var enumHolders: [String: EnumHolder]
//    var protocolHolders: [String: ProtocolHolders]
    var variableHolders: [String: VariableHolder]
    var FunctionHolders: [String: FunctionHolder]
//    var extensionHolders: [String: ExtensionHolders]
    
    struct StackArrayElement {
        var HolderType: String
        var name: String
    }
    
    func parse(syntaxes: [String]) {
        
    }
    
}
