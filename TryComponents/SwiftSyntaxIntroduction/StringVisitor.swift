//
//  StringVisitor.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/08/26.
//

// 『SwiftSyntax入門』p.29~

import Foundation
import SwiftSyntax

class Stringvisitor: SyntaxVisitor {
    
    // 検査対象の文字列を保持する配列
    var strings = [(String, AbsolutePosition)]()
    
    // 本ではStringLiteralExprsyntax.stringLiteral.textに文字列が入っている
    override func visit(_ node: StringSegmentSyntax) -> SyntaxVisitorContinueKind {
        let string = node.content.text
        let position = node.position
        strings.append((string, position))
        return .skipChildren
    }
}
