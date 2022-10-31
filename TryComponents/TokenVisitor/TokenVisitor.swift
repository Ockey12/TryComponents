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
    var getedText = [String]()
    
    private enum TypeName {
        case `struct`
        case `class`
        case `enum`
        case `protocol`
    }
    
    override func visitPre(_ node: Syntax) {
        let currentSyntaxNodeType = "\(node.syntaxNodeType)"
        if currentSyntaxNodeType.hasSuffix("DeclSyntax") {
            getedText.append("->" + currentSyntaxNodeType)
        }
//        var parentSyntaxNodeType = ""
//        if let parent = node.parent?.syntaxNodeType {
//            parentSyntaxNodeType = "\(parent)"
//        }
        
        // Struct/Class/Enum/ProtocolDeclSyntaxのとき
        // currentStruct/Class/Enumを初期化する
        // currentTypeFlagを、宣言している型に更新する
//        switch currentSyntaxNodeType {
//        case SyntaxNodeType.structDeclSyntax:
//            if parentSyntaxNodeType == SyntaxNodeType.codeBlockItemSyntax {
////                currentStruct = StructHolder()
//                currentTypeFlag = .struct
//                getedText.append("->StructDeclSyntax")
//            }
//        case SyntaxNodeType.classDeclSyntax:
//            if parentSyntaxNodeType == SyntaxNodeType.codeBlockItemSyntax {
//                currentClass = ClassHolder()
//                currentTypeFlag = .class
//            }
//        case SyntaxNodeType.enumDeclSyntax:
//            if parentSyntaxNodeType == SyntaxNodeType.codeBlockItemSyntax {
//                currentEnum = EnumHolder()
//                currentTypeFlag = .enum
//            }
//        case SyntaxNodeType.protocolDeclSyntax:
//            if parentSyntaxNodeType == SyntaxNodeType.codeBlockItemSyntax {
//                currentTypeFlag = .protocol
//            }
//        default:
//            break
//        }
    }
    
    override func visit(_ token: TokenSyntax) -> Syntax {
        getedText.append(token.text)
        return token._syntaxNode
    }
    
    override func visitPost(_ node: Syntax) {
        let currentSyntaxNodeType = "\(node.syntaxNodeType)"
        if currentSyntaxNodeType.hasSuffix("DeclSyntax") {
            getedText.append("<-" + currentSyntaxNodeType)
        }
        
        // CodeBlockItemSyntaxのとき
        // 型の宣言が終わる
        // currentStruct/Class/EnumをgetedTypesに格納する
        // currentStruct/Class/Enumにnilを代入して初期状態に戻す
//        if currentSyntaxNodeType == SyntaxNodeType.codeBlockItemSyntax {
//            switch currentTypeFlag {
//            case .struct:
////                if let structHolder = currentStruct {
////                    getedTypes["\(structHolder.name)"] = ["\(structHolder.name)": structHolder]
////                }
////                currentStruct = nil
//                getedText.append("<-StructDeclSyntax")
//            case .class:
//                if let classHolder = currentClass {
//                    getedTypes["\(classHolder.name)"] = ["\(classHolder.name)": classHolder]
//                }
//                currentClass = nil
//            case .enum:
//                if let enumHolder = currentEnum {
//                    getedTypes["\(enumHolder.name)"] = ["\(enumHolder.name)": enumHolder]
//                }
//                currentEnum = nil
//            case .protocol:
//                break
//            default:
//                break
//            }
//        }
    }
}
