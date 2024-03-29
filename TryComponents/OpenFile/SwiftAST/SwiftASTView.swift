//
//  SwiftASTView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/08/11.
//

// swift-syntaxに入門してみた https://qiita.com/fuziki/items/9869ab54ba95e9fc3c3a

// 指定したSwiftファイルのソースコードとASTを表示する
import SwiftUI
import UniformTypeIdentifiers

struct SwiftASTView: View {
    
    @State private var importerPresented = false
    @State private var sourceCode: String = ""
    @State private var ast: String = ""
    
    var body: some View {
        VStack {
            
//            ScrollView {
//                Text(code)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//            }
//            .frame(minWidth: 650, maxWidth: .infinity, minHeight: 650, maxHeight: .infinity)
            
            HStack {
                CodeScrollView(displayedText: $sourceCode)
                
                CodeScrollView(displayedText: $ast)
            }
            
            Button {
                importerPresented = true
            } label: {
                Text("Open")
            }
            .padding()
            
        }// VStack
        .frame(minWidth: 1200, maxWidth: .infinity, minHeight: 700, maxHeight: .infinity)
        // 指定したファイル内のソースコードをcode変数に格納する
        .fileImporter(isPresented: $importerPresented, allowedContentTypes: [.swiftSource]) { result in
            switch result {
            // urlは指定したファイルのURL
            case .success(let url):
                print(url)
                print("-------------------------------------------")
                
                guard let fileContents = try? String(contentsOf: url) else {
                    fatalError("failed to load contents")
                }
                print(fileContents)
                print("-------------------------------------------")
                sourceCode = fileContents
                
                let mySyntasRewriter = MySyntaxRewriter(sourceCode: sourceCode)
                ast = mySyntasRewriter.getAST()
//                print(mySyntasRewriter.getAST())
            case .failure:
                print("failure")
            }
        }// .fileImporter
    }
}

struct SwiftASTView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftASTView()
    }
}
