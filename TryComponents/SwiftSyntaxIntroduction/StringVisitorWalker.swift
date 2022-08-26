//
//  StringVisitorWalker.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/08/26.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxParser

//    pathURLプロパティの位置にあるファイル内のコードからSyntaxParserのparseメソッドで構文木を作り、
//    StringVisitor(SyntaxVisitor)クラスのwalkメソッドで構文木を検査する
//    StringVisitorクラスのstringsに保存された、ファイル内のコードの文字列を返す
struct StringVisitorWalker {
    
    var pathURL: URL
    
    func walkStringVisitor() -> [String] {
        do {
            let syntax = try SyntaxParser.parse(self.pathURL)
            let visitor = StringVisitor()
            visitor.walk(syntax)
            print(visitor.strings)
            return visitor.strings
        } catch {
            print("Error: \(error)")
        }
        
        return [""]
    }
}
