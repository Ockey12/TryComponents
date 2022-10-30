//
//  AstVisitorView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/30.
//

import SwiftUI
import SwiftSyntax
import SwiftSyntaxParser

struct AstVisitorView: View {
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
                let visitor = AstVisitor()
                _ = visitor.visit(parsedContent)
                rightContent = visitor.getGetedTokenSyntax()
            case .failure:
                print("failure")
            }
        }// .fileImporter
    }
}

struct AstVisitorView_Previews: PreviewProvider {
    static var previews: some View {
        AstVisitorView()
    }
}
