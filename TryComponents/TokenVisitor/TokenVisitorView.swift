//
//  TokenVisitorView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/29.
//

import SwiftUI
import SwiftSyntax
import SwiftSyntaxParser

struct TokenVisitorView: View {
    @State private var importerPresented = false
    @State private var sourceCode: String = ""
    @State private var rightContent: String = ""
    
    var body: some View {
        VStack {
            HStack {
                CodeScrollView(displayedText: $sourceCode)
                
                CodeScrollView(displayedText: $rightContent)
            }
            
            Button {
                importerPresented = true
            } label: {
                Text("Open")
            }
            .padding()
            
        }// VStack
        .frame(minWidth: 1200, maxWidth: .infinity, minHeight: 700, maxHeight: .infinity)
        // 指定したSwiftファイル内のソースコードをcode変数に格納する
        .fileImporter(isPresented: $importerPresented, allowedContentTypes: [.swiftSource]) { result in
            switch result {
            // urlは指定したファイルのURL
            case .success(let url):
                // URL先のファイルからソースコードを取得する
                guard let fileContent = try? String(contentsOf: url) else {
                    fatalError("failed to load contents")
                }
                sourceCode = fileContent
                
                let parsedContent = try! SyntaxParser.parse(url)
                let visitor = TokenVisitor()
                _ = visitor.visit(parsedContent)
                rightContent = visitor.getGetedTokenSyntax()
//                let mySyntasRewriter = MySyntaxRewriter(sourceCode: sourceCode)
//                ast = mySyntasRewriter.getAST()
//                print(mySyntasRewriter.getAST())
            case .failure:
                print("failure")
            }
        }// .fileImporter
    }
}

struct TokenVisitorView_Previews: PreviewProvider {
    static var previews: some View {
        TokenVisitorView()
    }
}
