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
    @State private var height = HeaderPartsSettingValues.itemHeight*2 + DetailPartsSettingValues.bottomPaddingForLastText
    
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
    
    // common
    let connectionHeight = HeaderPartsSettingValues.connectionHeight
    let arrowTerminalWidth = HeaderPartsSettingValues.arrowTerminalWidth
    
    // header parts
    let headerItemHeight = HeaderPartsSettingValues.itemHeight
    let headerBottomPaddingForLastText = HeaderPartsSettingValues.bottomPaddingForLastText
    var headerPartsHeight: CGFloat {
        headerItemHeight*2 + headerBottomPaddingForLastText
    }
    
    // detail parts
    let detailItemHeight = DetailPartsSettingValues.connectionHeight
    let detailBottomPaddingForLastText = DetailPartsSettingValues.bottomPaddingForLastText
    
    private func getVariablePartsOffsetY(holder: ConvertedToStringStructHolder) -> CGFloat {
        var offsetY: CGFloat = headerPartsHeight
        if 0 < holder.conformingProtocolNames.count {
            offsetY += connectionHeight
            offsetY += detailItemHeight*CGFloat(holder.conformingProtocolNames.count)
            offsetY += detailBottomPaddingForLastText
        }
        return offsetY
    }
    
    private func getMethodPartsOffsetY(holder: ConvertedToStringStructHolder) -> CGFloat {
        var offsetY: CGFloat = getVariablePartsOffsetY(holder: holder)
        if 0 < holder.variables.count {
            offsetY += connectionHeight
            offsetY += detailItemHeight*CGFloat(holder.variables.count)
            offsetY += detailBottomPaddingForLastText
        }
        return offsetY
    }
    
    var body: some View {
        VStack {
            ScrollView {
                if 0 < convertedToTextStructHolders.count {
                    let holder = convertedToTextStructHolders[0]
//                    GeometryReader { geometry in
//                        ZStack(alignment: .topLeading) {
//                            HeaderPartsView(accessLevelIcon: holder.accessLevelIcon, headerPartsIndexType: .struct, name: holder.name, width: width)
//                                .offset(x: 0, y: 0)
//
//                            if 0 < holder.conformingProtocolNames.count {
//                                DetailPartsView(detailPartsType: .conform, texts: holder.conformingProtocolNames, width: width)
//                                    .offset(x: 0, y: headerPartsHeight)
//                            }
//
//                            if 0 < holder.variables.count {
//                                DetailPartsView(detailPartsType: .property, texts: holder.variables, width: width)
//                                    .offset(x: 0, y: getVariablePartsOffsetY(holder: holder))
//                            }
//                            Text("width: \(geometry.size.width), height: \(geometry.size.height)")
//                                .offset(x: 0, y: getVariablePartsOffsetY(holder: holder))
//                                .foregroundColor(.red)
////                            Text("height: \(geometry.size.height)")
//
//                        }
//                        .scaleEffect(ratio)
//                        .frame(width: geometry.size.width, height: geometry.size.height)
//                        .border(.blue)
//                    }
                    ZStack(alignment: .topLeading) {
                        HeaderPartsView(accessLevelIcon: holder.accessLevelIcon, headerPartsIndexType: .struct, name: holder.name, width: width)
                            .offset(x: 0, y: 0)

                        if 0 < holder.conformingProtocolNames.count {
                            DetailPartsView(detailPartsType: .conform, texts: holder.conformingProtocolNames, width: width)
                                .offset(x: 0, y: headerPartsHeight)
                        }

                        if 0 < holder.variables.count {
                            DetailPartsView(detailPartsType: .property, texts: holder.variables, width: width)
                                .offset(x: 0, y: getVariablePartsOffsetY(holder: holder))
                        }
                        
                        if 0 < holder.functions.count {
                            DetailPartsView(detailPartsType: .method, texts: holder.functions, width: width)
                                .offset(x: 0, y: getMethodPartsOffsetY(holder: holder))
                        }
//                        Text("width: \(geometry.size.width), height: \(geometry.size.height)")
//                            .offset(x: 0, y: getVariablePartsOffsetY(holder: holder))
//                            .foregroundColor(.red)
//                            Text("height: \(geometry.size.height)")
                        
                    }
                    .scaleEffect(ratio)
//                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .border(.blue)
                }
            }
            .background(.white)
            
            Divider()
            
            Text("拡大率:\(ratio, specifier: "%.2f")")
            Text("width: \(width)")
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
