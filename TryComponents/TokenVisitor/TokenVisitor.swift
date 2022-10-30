//
//  TokenVisitor.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/27.
//

import Foundation
import SwiftSyntax

final class TokenVisitor: SyntaxRewriter {
    private var currentStruct: StructHolder?
    private var currentClass: ClassHolder?
    private var currentEnum: EnumHolder?
    private var currentTypeName: TypeName?
    private var getedTypes =  [String: Any]()
    
    private enum TypeName {
        case `struct`
        case `class`
        case `enum`
        case `protocol`
    }
    
    override func visitPre(_ node: Syntax) {
        let syntaxNodeType = "\(node.syntaxNodeType)"
    }
    
    override func visit(_ token: TokenSyntax) -> Syntax {
        return token._syntaxNode
    }
    
    override func visitPost(_ node: Syntax) {
        
    }
}
