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
    var syntaxArray = [String]()
    
    private var syntaxNodeTypeStack = [String]()
    private var positionInStack = -1
    
    enum syntaxNodeType {
        case inheritedTypeSyntax
        
        func getString() -> String {
            switch self {
            case .inheritedTypeSyntax:
                return "InheritedTypeSyntax"
            }
        }
    }
    
    private enum TypeName {
        case `struct`
        case `class`
        case `enum`
        case `protocol`
    }
    
    override func visitPre(_ node: Syntax) {
        let currentSyntaxNodeType = "\(node.syntaxNodeType)"
        if currentSyntaxNodeType.hasSuffix("DeclSyntax") {
            syntaxArray.append(currentSyntaxNodeType + "{")
            syntaxNodeTypeStack.append(currentSyntaxNodeType)
            positionInStack += 1
        } else if currentSyntaxNodeType == "InheritedTypeSyntax" {
            syntaxNodeTypeStack.append(currentSyntaxNodeType)
            positionInStack += 1
        }
    }
    
    override func visit(_ token: TokenSyntax) -> Syntax {
        let tokenKind = "\(token.tokenKind)"
        if tokenKind.hasPrefix("identifier") {
            syntaxArray.append("identifier " + "\(syntaxNodeTypeStack[positionInStack]) " + "\(token.text)")
        }
        return token._syntaxNode
    }
    
    override func visitPost(_ node: Syntax) {
        let currentSyntaxNodeType = "\(node.syntaxNodeType)"
        if currentSyntaxNodeType.hasSuffix("DeclSyntax") {
            syntaxArray.append(currentSyntaxNodeType + "}")
            syntaxNodeTypeStack.removeLast()
            positionInStack -= 1
        } else if currentSyntaxNodeType == "InheritedTypeSyntax" {
            syntaxNodeTypeStack.removeLast()
            positionInStack -= 1
        }
    }
}
