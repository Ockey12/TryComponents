//
//  TokenVisitor.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/27.
//

import Foundation
import SwiftSyntax

final class TokenVisitor: SyntaxRewriter {
    
    override func visitPre(_ node: Syntax) {
        
    }
    
    override func visit(_ token: TokenSyntax) -> Syntax {
        return token._syntaxNode
    }
    
    override func visitPost(_ node: Syntax) {
        
    }
}
