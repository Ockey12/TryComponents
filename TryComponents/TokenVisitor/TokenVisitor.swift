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
    
    // functionの宣言
    var genericParameter = ""
    var functionParams = [String]()
    var haveInoutKeyword = false
    var isVariadic = false
    var haveDefaultValue = false
    var defaultValue = ""
    var haveReturnValue = false
    var returnType = ""
    
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
                  (currentSyntaxNodeType == "FunctionParameterSyntax") ||
                  (currentSyntaxNodeType == "InitializerClauseSyntax") ||
                  (currentSyntaxNodeType == "ReturnClauseSyntax") ||
                  (currentSyntaxNodeType == "GenericParameterSyntax") ||
                  (currentSyntaxNodeType == "CodeBlockSyntax"){
            syntaxNodeTypeStack.append(currentSyntaxNodeType)
            positionInStack += 1
        }
    }
    
    override func visit(_ token: TokenSyntax) -> Syntax {
        let tokenKind = "\(token.tokenKind)"
        print(tokenKind)
        
        if tokenKind == "eof" {
            return token._syntaxNode
        }
        
        if tokenKind.hasPrefix("identifier") {
            if syntaxNodeTypeStack[positionInStack] == "CodeBlockSyntax" {
                if syntaxNodeTypeStack[positionInStack - 1] == "FunctionDeclSyntax{" {
                    // functionのCodeBlockSyntax内の情報は無視する
                }
            } else if syntaxNodeTypeStack[positionInStack] == "FunctionParameterSyntax" {
                // functionの引数を宣言中のとき
                // 外部引数名、内部引数名、型をまとめて1つのidentifier要素にしたいので別の配列に格納する
                functionParams.append(token.text)
            } else if syntaxNodeTypeStack[positionInStack]  == "ReturnClauseSyntax" {
                // functionの返り値の型を宣言中のとき
                // "String"や"Int"を配列に格納する
                returnType += token.text
            } else if syntaxNodeTypeStack[positionInStack] == "GenericParameterSyntax" {
                // functionのgenericParameterを宣言中のとき
                genericParameter += token.text
            } else {
                syntaxArray.append("identifier " + "\(syntaxNodeTypeStack[positionInStack]) " + "\(token.text)")
            } // end if
        } else if tokenKind == "inoutKeyword" {
            // functionのinoutキーワードを宣言しているとき
            haveInoutKeyword = true
        } else if (tokenKind == "ellipsis") &&
                  (syntaxNodeTypeStack[positionInStack] == "FunctionParameterSyntax") {
            // functionの可変長引数を宣言しているとき
            isVariadic = true
        } else if syntaxNodeTypeStack[positionInStack] == "InitializerClauseSyntax" {
            if syntaxNodeTypeStack[positionInStack - 1] == "FunctionParameterSyntax" {
                // functionのデフォルト引数を宣言しているとき
                if (tokenKind != "equal") && (tokenKind != "stringQuote") {
                    haveDefaultValue = true
                    defaultValue = token.text
                }
            }
        } else if syntaxNodeTypeStack[positionInStack] == "ReturnClauseSyntax" {
            // functionの返り値の型を宣言しているとき
            if tokenKind != "arrow" { // "->"は返り値の型と関係ないので無視する
                if tokenKind == "comma" {
                    returnType += ", "
                } else if tokenKind == "colon" {
                    returnType += ": "
                } else {
                    returnType += token.text
                }
            }
        } else if syntaxNodeTypeStack[positionInStack] == "GenericParameterSyntax" {
            // functionのgenericParameterを宣言中のとき
            if tokenKind == "colon" {
                genericParameter += ": "
            }
        } // end if
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
                haveInoutKeyword = false
            }
            
            if isVariadic {
                syntaxArray.append("variadicParameter")
                isVariadic = false
            }
            
            if haveDefaultValue {
                syntaxArray.append("defaultValue " + defaultValue)
                haveDefaultValue = false
                defaultValue = ""
            }
        } else if currentSyntaxNodeType == "ReturnClauseSyntax" {
            syntaxArray.append("returnType " + returnType)
            returnType = ""
            syntaxNodeTypeStack.removeLast()
            positionInStack -= 1
        } else if currentSyntaxNodeType == "InitializerClauseSyntax" {
            syntaxNodeTypeStack.removeLast()
            positionInStack -= 1
        } else if currentSyntaxNodeType == "GenericParameterSyntax" {
            syntaxArray.append("identifier GenericParameterSyntax " + genericParameter)
            genericParameter = ""
            syntaxNodeTypeStack.removeLast()
            positionInStack -= 1
        }
    }
}
