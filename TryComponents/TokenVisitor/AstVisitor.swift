//
//  AstVisitor.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/30.
//

import Foundation
import SwiftSyntax

final class AstVisitor: SyntaxRewriter {
    private var getedSyntax = ""
    private var indentCount = 0
    let indentSpace = "  "
    
    override func visitPre(_ node: Syntax) {
        let space = Array(repeating: indentSpace, count: indentCount).joined(separator: "|")
        getedSyntax += "\(space)syntaxNodeType: \(node.syntaxNodeType)"
        
        let syntaxNodeType = "\(node.syntaxNodeType)"
        if syntaxNodeType == "StructDeclSyntax" {
            getedSyntax += ", parent: \(String(describing: node.parent?.syntaxNodeType))"
        }
        
        indentCount += 1
        getedSyntax += "\n"
    }
    
    override func visit(_ token: TokenSyntax) -> Syntax {
        let space = Array(repeating: indentSpace, count: indentCount).joined(separator: "|")
        getedSyntax += "\(space)--tokenKind: \(token.tokenKind), text: \(token.text)\n"
        return token._syntaxNode
    }
    
    override func visitPost(_ node: Syntax) {
        indentCount -= 1
        let space = Array(repeating: indentSpace, count: indentCount).joined(separator: "|")
        getedSyntax += "\(space)Post: \(node.syntaxNodeType)"
        
        let syntaxNodeType = "\(node.syntaxNodeType)"
        if syntaxNodeType == "StructDeclSyntax" {
            getedSyntax += ", parent: \(String(describing: node.parent?.syntaxNodeType))"
        }
        
        getedSyntax += "\n"
        
        if syntaxNodeType == "CodeBlockItemSyntax" {
            getedSyntax += "\n"
        }
    }
    
    func getGetedTokenSyntax() -> String {
        self.getedSyntax
    }
}
