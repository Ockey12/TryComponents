//
//  SyntaxesParserView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/11/01.
//

import SwiftUI
import SwiftSyntax
import SwiftSyntaxParser

struct SyntaxArrayParserView: View {
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
                syntaxesParser.parse(syntaxes: visitor.syntaxArray)
                // protocol
                let protocolHolders = syntaxesParser.getResultProtocolHolders()
                for protocolHolder in protocolHolders {
                    rightContent += "protocolName: " + protocolHolder.name + "\n"
                    for variable in protocolHolder.variables {
                        rightContent += "variableName: " + variable.name + "\n"
                    }
                    for funct in protocolHolder.functions {
                        rightContent += "functionName: "  + funct.name + "\n"
                    }
                    
                    rightContent += "\n"
                }
                // struct
                let structHolders = syntaxesParser.getResultStructHolders()
                for structHolder in structHolders {
                    rightContent += "structName: " + structHolder.name + "\n"
                    for conformingProtocolName in structHolder.conformingProtocolNames {
                        print(conformingProtocolName)
                        rightContent += "conformingProtocolName: " + conformingProtocolName + "\n"
                    }
                    for nestStruct in structHolder.nestingStructs {
                        rightContent += "nestStructName: " + nestStruct.name + "\n"
                    }
                    for nestEnum in structHolder.nestingEnums {
                        rightContent += "nestEnumName: " + nestEnum.name + "\n"
                    }
                    for variable in structHolder.variables {
                        rightContent += "variableName: " + variable.name + "\n"
                    }
                    for funct in structHolder.functions {
                        rightContent += "functionName: "  + funct.name + "\n"
                        for param in funct.parameters {
                            rightContent += "parameter: ["
                            if let externalName = param.externalParameterName {
                                rightContent += "externalName: " + externalName + ", "
                            }
                            rightContent += "internalName: " + param.internalParameterName + ", "
                            if param.haveInoutKeyword {
                                rightContent += "inout, "
                            }
                            rightContent += "type: " + param.type + "]\n"
                        }
                    }
                    rightContent += "\n"
                } // end for
            case .failure:
                print("failure")
            }
        }// .fileImporter
    }
}

struct SyntaxesParserView_Previews: PreviewProvider {
    static var previews: some View {
        SyntaxArrayParserView()
    }
}
