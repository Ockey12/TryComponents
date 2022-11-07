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
    
    @State private var lastMagnificationValue = 1.0
    var magnification: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                // 前回の拡大率に対して今回の拡大率の割合を計算
                let changeRate = value / lastMagnificationValue
                // 前回からの拡大率の変更割合分を乗算する
                ratio *= changeRate
                // 前回の拡大率を今回の拡大率で更新
                lastMagnificationValue = value
            }
            .onEnded { value in
                // 次回のジェスチャー時に1.0から始まる為、終了時に1.0に変更する
                lastMagnificationValue = 1.0
            }
    }
    
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
    
    private func getVStackHeight(holder: ConvertedToStringStructHolder) -> CGFloat {
        var height: CGFloat = headerPartsHeight + connectionHeight + 2
        if 0 < holder.conformingProtocolNames.count {
            height += detailItemHeight*CGFloat(holder.conformingProtocolNames.count)
            height += detailBottomPaddingForLastText
            height += connectionHeight
        }
        if 0 < holder.variables.count {
            height += detailItemHeight*CGFloat(holder.variables.count)
            height += detailBottomPaddingForLastText
            height += connectionHeight
        }
        if 0 < holder.functions.count {
            height += detailItemHeight*CGFloat(holder.functions.count)
            height += detailBottomPaddingForLastText
            height += connectionHeight
        }
        return height
    }
    
    var body: some View {
        VStack {
            ScrollView([.vertical, .horizontal]) {
                if 0 < convertedToTextStructHolders.count {
                    let holder = convertedToTextStructHolders[0]
                    VStack(spacing: 0) {
                        HeaderPartsView(accessLevelIcon: holder.accessLevelIcon, headerPartsIndexType: .struct, name: holder.name, width: width)
                            .offset(x: 0, y: 2) // indexのborderが上にはみ出るため、はみ出る分だけ下げる
                            .frame(width: width + arrowTerminalWidth*2, height: headerPartsHeight)
                        
                        if 0 < holder.conformingProtocolNames.count {
                            DetailPartsView(detailPartsType: .conform, texts: holder.conformingProtocolNames, width: width)
                                .frame(width: width + arrowTerminalWidth*2, height: connectionHeight + detailItemHeight*CGFloat(holder.conformingProtocolNames.count) + detailBottomPaddingForLastText)
                        }

                        if 0 < holder.variables.count {
                            DetailPartsView(detailPartsType: .property, texts: holder.variables, width: width)
                                .frame(width: width + arrowTerminalWidth*2, height: connectionHeight + detailItemHeight*CGFloat(holder.variables.count) + detailBottomPaddingForLastText)
                        }
                        
                        if 0 < holder.functions.count {
                            DetailPartsView(detailPartsType: .method, texts: holder.functions, width: width)
                                .frame(width: width + arrowTerminalWidth*2, height: connectionHeight + detailItemHeight*CGFloat(holder.functions.count) + detailBottomPaddingForLastText)
                        }
                    }
                    .frame(width: width + arrowTerminalWidth*2 + 4, height: getVStackHeight(holder: holder), alignment: .top)
                    .background(.orange)
                    .scaleEffect(ratio)
                    .gesture(magnification)
                } // end if
            } // end ScrollView
            .background(.white)
            
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
