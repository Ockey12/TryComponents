//
//  StringVisitorView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/08/26.
//

import SwiftUI

struct StringVisitorView: View {
    
//    @State private var strings = [String]()
//    
//    var body: some View {
//        List(strings, id: \.self) { string in
//            Text(string)
//        }
//        
//        Button {
//            let walker = StringVisitorWalker(pathURL: URL(fileURLWithPath: "StringVisitorSample.swift"))
//            self.strings = walker.walkStringVisitor()
//        } label: {
//            Text("Walk StringVisitor")
//        }
//    }
    @State private var importerPresented = false
    @State private var sourceCode: String = ""
    @State private var strings = [String]()
    
    var body: some View {
        VStack {
            HStack {
                CodeScrollView(displayedText: $sourceCode)
                
                List(strings, id: \.self) { string in
                    Text(string)
                }
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
                
                let walker = StringVisitorWalker(pathURL: url)
                strings = walker.walkStringVisitor()
                print(walker.walkStringVisitor())
//                print(mySyntasRewriter.getAST())
            case .failure:
                print("failure")
            }
        }// .fileImporter
    }
}

struct StringVisitorView_Previews: PreviewProvider {
    static var previews: some View {
        StringVisitorView()
    }
}
