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
    
    // variableの宣言
    var variableCustomAttribute = ""
    var variableType = ""
    var variableInitialValue = ""
    
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
        if (1 < positionInStack) &&
           (syntaxNodeTypeStack[positionInStack] == "CodeBlockSyntax") &&
           (syntaxNodeTypeStack[positionInStack - 1] == "FunctionDeclSyntax"){
            // function宣言中のCodeBlockSyntax内の情報は無視する
        } else {
            if currentSyntaxNodeType.hasSuffix("DeclSyntax") {
                syntaxArray.append(currentSyntaxNodeType + "{")
                syntaxNodeTypeStack.append(currentSyntaxNodeType)
                positionInStack += 1
            } else if (currentSyntaxNodeType == "CustomAttributeSyntax") &&
                      (syntaxNodeTypeStack[positionInStack] == "VariableDeclSyntax") {
                // variable宣言中の@ Stateなど
                syntaxNodeTypeStack.append(currentSyntaxNodeType)
                positionInStack += 1
            } else if (currentSyntaxNodeType == "InheritedTypeSyntax") ||
                      (currentSyntaxNodeType == "FunctionParameterSyntax") ||
                      (currentSyntaxNodeType == "InitializerClauseSyntax") ||
                      (currentSyntaxNodeType == "ReturnClauseSyntax") ||
                      (currentSyntaxNodeType == "GenericParameterSyntax") ||
                      (currentSyntaxNodeType == "CodeBlockSyntax") ||
                      (currentSyntaxNodeType == "PatternBindingSyntax") ||
                      (currentSyntaxNodeType == "IdentifierPatternSyntax") ||
                      (currentSyntaxNodeType == "TypeAnnotationSyntax") {
                syntaxNodeTypeStack.append(currentSyntaxNodeType)
                positionInStack += 1
            }
        }
    } // end visitPre()
    
    override func visit(_ token: TokenSyntax) -> Syntax {
        let tokenKind = "\(token.tokenKind)"
        print(tokenKind)
        
        if tokenKind == "eof" {
            return token._syntaxNode
        }
        
        if (1 < positionInStack) &&
           (syntaxNodeTypeStack[positionInStack] == "CodeBlockSyntax") &&
           (syntaxNodeTypeStack[positionInStack - 1] == "FunctionDeclSyntax"){
            // functionのCodeBlockSyntax内の情報は無視する
            return token._syntaxNode
        }
        
        if (1 < positionInStack) &&
           (syntaxNodeTypeStack[positionInStack] == "CustomAttributeSyntax") &&
           (syntaxNodeTypeStack[positionInStack - 1] == "VariableDeclSyntax") {
            // variable宣言中の@ Stateなど
            variableCustomAttribute += token.text
        } else if tokenKind.hasPrefix("identifier") {
            if syntaxNodeTypeStack[positionInStack] == "FunctionParameterSyntax" {
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
            } else if (1 < positionInStack) &&
                      (syntaxNodeTypeStack[positionInStack - 1] == "PatternBindingSyntax") &&
                      (syntaxNodeTypeStack[positionInStack - 2] == "VariableDeclSyntax") {
                if syntaxNodeTypeStack[positionInStack] == "IdentifierPatternSyntax" {
                    // variable宣言中の変数名
                    syntaxArray.append("identifier " + "VariableName " + "\(token.text)")
                } else if syntaxNodeTypeStack[positionInStack] == "TypeAnnotationSyntax" {
                    // variable宣言中の型
                    variableType += token.text
                } else if syntaxNodeTypeStack[positionInStack] == "InitializerClauseSyntax" {
                    // variable宣言中の初期値
                    variableInitialValue += token.text
                }
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
        } else if (syntaxNodeTypeStack[positionInStack] == "InitializerClauseSyntax") &&
                  (syntaxNodeTypeStack[positionInStack - 1] == "FunctionParameterSyntax") {
            // functionのデフォルト引数を宣言しているとき
            if (tokenKind != "equal") && (tokenKind != "stringQuote") {
                haveDefaultValue = true
                defaultValue = token.text
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
                } // end if
            } // end if
        } else if syntaxNodeTypeStack[positionInStack] == "GenericParameterSyntax" {
            // functionのgenericParameterを宣言中のとき
            if tokenKind == "colon" {
                genericParameter += ": "
            }
        } else if (tokenKind == "varKeyword") ||
                  (tokenKind == "letKeyword") {
            // プロパティ宣言中のvar/letキーワード
            syntaxArray.append(tokenKind)
        } else if ((syntaxNodeTypeStack[positionInStack] == "TypeAnnotationSyntax") ||
                   (syntaxNodeTypeStack[positionInStack] == "InitializerClauseSyntax")
                  ) &&
                  (syntaxNodeTypeStack[positionInStack - 1] == "PatternBindingSyntax") &&
                  (syntaxNodeTypeStack[positionInStack - 2] == "VariableDeclSyntax") {
            if syntaxNodeTypeStack[positionInStack] == "TypeAnnotationSyntax" {
                // variableの型宣言中の":", ",", "[", "]", "(", ")"
                variableType += token.text
                if (tokenKind == "comma") ||
                   (tokenKind == "colon") {
                    variableType += " "
                }
            } else if syntaxNodeTypeStack[positionInStack] == "InitializerClauseSyntax" {
                // variableの宣言中の初期値
                // 初期値を代入する"="は無視する
                if tokenKind != "equal" {
                    variableInitialValue += token.text
                }
                if (tokenKind == "comma") ||
                   (tokenKind == "colon") {
                    variableInitialValue += " "
                }
            }
        } // end if
        return token._syntaxNode
    } // end visit()
    
    override func visitPost(_ node: Syntax) {
        let currentSyntaxNodeType = "\(node.syntaxNodeType)"
        
        if (1 < positionInStack) &&
           (syntaxNodeTypeStack[positionInStack] == "CodeBlockSyntax") &&
           (syntaxNodeTypeStack[positionInStack - 1] == "FunctionDeclSyntax") {
            // function宣言中のCodeBlockSyntax内の情報は、CodeBlockSyntaxを抜けること以外は無視する
            if currentSyntaxNodeType == "CodeBlockSyntax" {
                syntaxNodeTypeStack.removeLast()
                positionInStack -= 1
            }
        } else {
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
                if (syntaxNodeTypeStack[positionInStack - 1] == "PatternBindingSyntax") &&
                   (syntaxNodeTypeStack[positionInStack - 2] == "VariableDeclSyntax") {
                    syntaxArray.append("VariableInitialValue " + variableInitialValue)
                    variableInitialValue = ""
                }
                syntaxNodeTypeStack.removeLast()
                positionInStack -= 1
            } else if currentSyntaxNodeType == "GenericParameterSyntax" {
                syntaxArray.append("identifier GenericParameterSyntax " + genericParameter)
                genericParameter = ""
                syntaxNodeTypeStack.removeLast()
                positionInStack -= 1
            } else if currentSyntaxNodeType == "PatternBindingSyntax" {
                syntaxNodeTypeStack.removeLast()
                positionInStack -= 1
            } else if currentSyntaxNodeType == "IdentifierPatternSyntax" {
                syntaxNodeTypeStack.removeLast()
                positionInStack -= 1
            } else if currentSyntaxNodeType == "TypeAnnotationSyntax" {
                syntaxArray.append("VariableType " + variableType.dropFirst(2))
                variableType = ""
                syntaxNodeTypeStack.removeLast()
                positionInStack -= 1
            } else if (currentSyntaxNodeType == "CustomAttributeSyntax") &&
                      (syntaxNodeTypeStack[positionInStack - 1] == "VariableDeclSyntax") {
                // variable宣言中の@ Stateなど
                syntaxArray.append("VariableCustomAttribute " + variableCustomAttribute)
                variableCustomAttribute = ""
                syntaxNodeTypeStack.removeLast()
                positionInStack -= 1
            } // end if
        } // end if
    } // end visitPost()
}
