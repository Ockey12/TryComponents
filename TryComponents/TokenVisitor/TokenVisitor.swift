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
    private var currentTypeFlag: TypeName?
    var getedTypes =  [String: Any]()
    var syntaxes = [String]()
    
    private enum TypeName {
        case `struct`
        case `class`
        case `enum`
        case `protocol`
    }
    
    override func visitPre(_ node: Syntax) {
        let currentSyntaxNodeType = "\(node.syntaxNodeType)"
        if currentSyntaxNodeType.hasSuffix("DeclSyntax") || (currentSyntaxNodeType == "InheritedTypeSyntax") {
            syntaxes.append(currentSyntaxNodeType + "{")
        }
    }
    
    override func visit(_ token: TokenSyntax) -> Syntax {
        let tokenKind = "\(token.tokenKind)"
        if tokenKind.hasPrefix("identifier") {
            syntaxes.append("identifier:" + "\(token.text)")
        }
        return token._syntaxNode
    }
    
    override func visitPost(_ node: Syntax) {
        let currentSyntaxNodeType = "\(node.syntaxNodeType)"
        if currentSyntaxNodeType.hasSuffix("DeclSyntax") || (currentSyntaxNodeType == "InheritedTypeSyntax") {
            syntaxes.append(currentSyntaxNodeType + "}")
        }
    }
}
