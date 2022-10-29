//
//  TokenVisitor.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/27.
//

import Foundation
import SwiftSyntax

final class TokenVisitor: SyntaxRewriter {
    private var getedTokenText = ""
    
    override func visit(_ token: TokenSyntax) -> Syntax {
        getedTokenText += "\ntokenKind: \(token.tokenKind), text: \(token.text)"
        return token._syntaxNode
    }
    
    func getGetedTokenText() -> String {
        self.getedTokenText
    }
}
