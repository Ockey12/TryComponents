//
//  StructHolderToTextConverterView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/11/06.
//

import SwiftUI
import SwiftSyntax
import SwiftSyntaxParser

struct StructHolderToTextConverterView: View {
    @State private var importerPresented = false
    @State private var sourceCode: String = ""
    @State private var rightContent: String = ""
    @State private var ratio: CGFloat = 1.0
    @State private var structHolders = [StructHolder]()
    @State private var convertedToTextStructHolders = [ConvertedToStringStructHolder]()
    
    private var width: CGFloat {
        var maxWidth: CGFloat = DetailPartsSettingValues.minWidth
        if 0 < convertedToTextStructHolders.count {
            for string in convertedToTextStructHolders[0].allStrings {
                let tmpWidth = System50CharSize(string: string).getStringWidth()
                if maxWidth < tmpWidth {
                    maxWidth = tmpWidth
                }
            }
        }
        return maxWidth + DetailPartsSettingValues.textTrailPadding
    }
    
    var body: some View {
        VStack {
            ScrollView {
                if 0 < convertedToTextStructHolders.count {
                    let holder = convertedToTextStructHolders[0]
                    ZStack(alignment: .topLeading) {
                        HeaderPartsView(accessLevelIcon: holder.accessLevelIcon, headerPartsIndexType: .struct, name: holder.name, width: width)
                    }
                }
            }
            
            Divider()
            
            Text("拡大率:\(ratio, specifier: "%.2f")")
            Slider(value: $ratio, in: 0...10.0)
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
                let syntaxArray = visitor.syntaxArray
                var parser = SyntaxArrayParser()
                parser.parse(syntaxArray: syntaxArray)
                structHolders = parser.getResultStructHolders()
                if 0 < structHolders.count {
                    let converter = StructHolderToTextConverter()
                    for structHolder in structHolders {
                        convertedToTextStructHolders.append(converter.convertToText(structHolder: structHolder))
                    }
                }
            case .failure:
                print("failure")
            }
        }// .fileImporter
    }
}

struct StructHolderToTextConverterView_Previews: PreviewProvider {
    static var previews: some View {
        StructHolderToTextConverterView()
    }
}
