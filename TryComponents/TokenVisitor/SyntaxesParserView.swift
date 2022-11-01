//
//  SyntaxesParserView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/11/01.
//

import SwiftUI
import SwiftSyntax
import SwiftSyntaxParser

struct SyntaxesParserView: View {
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
                
                var syntaxesParser = SyntaxArrayParser()
                syntaxesParser.parse(syntaxes: visitor.syntaxes)
                let structHolders = syntaxesParser.getResultStructHolders()
                for structHolder in structHolders {
                    rightContent += "structName: " + structHolder.name + "\n"
                    for variable in structHolder.variables {
                        rightContent += "variableName: " + variable.name + "\n"
                    }
                }
            case .failure:
                print("failure")
            }
        }// .fileImporter
    }
}

struct SyntaxesParserView_Previews: PreviewProvider {
    static var previews: some View {
        SyntaxesParserView()
    }
}
