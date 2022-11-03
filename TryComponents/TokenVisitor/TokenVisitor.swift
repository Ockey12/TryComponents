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
    
    var functionParams = [String]()
    var haveInoutKeyword = false
    
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
        } else if (currentSyntaxNodeType == "InheritedTypeSyntax") ||
                  (currentSyntaxNodeType == "FunctionParameterSyntax") {
            syntaxNodeTypeStack.append(currentSyntaxNodeType)
            positionInStack += 1
        }
    }
    
    override func visit(_ token: TokenSyntax) -> Syntax {
        let tokenKind = "\(token.tokenKind)"
        if tokenKind.hasPrefix("identifier") {
            if syntaxNodeTypeStack[positionInStack] == "FunctionParameterSyntax" {
                // functionの引数を宣言中のとき
                // 外部引数名、内部引数名、型をまとめて1つのidentifier要素にしたいので別の配列に格納する
                functionParams.append(token.text)
            } else {
                syntaxArray.append("identifier " + "\(syntaxNodeTypeStack[positionInStack]) " + "\(token.text)")
            }
        } else if tokenKind == "inoutKeyword" {
            haveInoutKeyword = true
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
        } else if currentSyntaxNodeType == "FunctionParameterSyntax" {
            var identifierParams = "identifier " + "\(syntaxNodeTypeStack[positionInStack])"
            for param in functionParams.reversed() {
                identifierParams += " " + param
            }
            syntaxArray.append(identifierParams)
            functionParams = []
            syntaxNodeTypeStack.removeLast()
            positionInStack -= 1
            
            if haveInoutKeyword {
                syntaxArray.append("inoutKeyword")
            }
        }
    }
}
