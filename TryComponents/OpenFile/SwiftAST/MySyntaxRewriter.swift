//
//  MySyntaxRewriter.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/08/11.
//

// swift-syntaxに入門してみた https://qiita.com/fuziki/items/9869ab54ba95e9fc3c3a

import Foundation
import SwiftSyntax
import SwiftSyntaxParser

// SwiftSyntaxを使って構文解析した結果の構文木をString型で返すメソッドを持つ
class MySyntaxRewriter: SyntaxRewriter {
    var sourceCode: String
    var ast: String = ""
    private var nestCount: Int = 0
    
    init(sourceCode: String) {
        self.sourceCode = sourceCode
    }
    
    func getAST() -> String {
        do {
            let sourceFile: SourceFileSyntax = try SyntaxParser.parse(source: sourceCode)
            _ = self.visit(sourceFile._syntaxNode)
        } catch {
            print("Error: \(error)")
        }
        
        return self.ast
    }
    
    override func visitPre(_ node: Syntax) {
        let space = Array(repeating: " ", count: nestCount).joined(separator: "|") + "+"
        
        if "\(node.syntaxNodeType)" == "TokenSyntax" { // 探索するnodeがTokenSyntaxの場合は、そのnodeの文字列をastプロパティに追加する
            let text = "\(node)".trimmingCharacters(in: .newlines).trimmingCharacters(in: .whitespaces)
            ast += "\(space)-> \(text)\n"
        } else {
            ast += "\(space)\(node.syntaxNodeType)\n"
        }
        
        nestCount += 1
    }
    
    override func visitPost(_ node: Syntax) {
        nestCount -= 1
    }
}
