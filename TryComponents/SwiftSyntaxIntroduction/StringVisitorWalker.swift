//
//  StringVisitorWalker.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/08/26.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxParser

struct StringVisitorWalker {
    
    var pathURL: URL
    
    func walkStringVisitor() {
        do {
            let syntax = try SyntaxParser.parse(self.pathURL)
            let visitor = Stringvisitor()
            visitor.walk(syntax)
            print(visitor.strings)
        } catch {
            print("Error: \(error)")
        }
    }
}
