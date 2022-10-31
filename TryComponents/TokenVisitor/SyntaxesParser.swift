//
//  SyntaxesParser.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/31.
//

import Foundation

// TokenVisitorクラスが出力したsyntaxes配列を解析し、Holderのインスタンスを生成する
struct SyntaxesParser {
//    var syntaxes: [String]
    
    struct StackArrayElement {
        var holderType: HolderType
        var name: String
    }
    
    enum HolderType: String {
        case `struct` = "Struct"
        case `class` = "Class"
        case `enum` = "Enum"
        case `protocol` = "Protocol"
        case variable = "Variable"
        case function = "Function"
        case `extension` = "Extension"
        
//        func getStringCase() -> String {
//            switch self {
//            case .struct:
//                return "Struct"
//            case .class:
//                return "Class"
//            case .enum:
//                return "Enum"
//            case .protocol:
//                return "Protocol"
//            case .variable:
//                return "Variable"
//            case .function:
//                return "Function"
//            case .extension:
//                return "Extension"
//            }
//        }
    }
    
    func parse(syntaxes: [String]) {
        var stackArray = [StackArrayElement]()
        var structHolders = [String: StructHolder]()
        var classHolders = [String: ClassHolder]()
        var enumHolders = [String: EnumHolder]()
    //    var protocolHolders = [String: ProtocolHolders]()
        var variableHolders = [String: VariableHolder]()
        var FunctionHolders = [String: FunctionHolder]()
    //    var extensionHolders = [String: ExtensionHolders]()
        
        var currentHolderTypeFlag: HolderType = .struct
        var currentStructHolder = StructHolder()
        var currentClassHolder = ClassHolder()
        var currentEnumHolder = EnumHolder()
//        var currentProtocolHolder: ProtocolHolder
        var currentVariableHolder = VariableHolder()
        var currentFunctionHolder = FunctionHolder()
//        var currentExtensionHolder: ExtensionHolder
        
        var positionInStack = -1
        var skipFlag = false
        
        let startDeclSyntaxKeyword = "DeclSyntax{"
        let endDeclSyntaxKeyword = "DeclSyntax}"
        let identifierKeyword = "identifier:"
        let startImportDeclSyntax = "ImportDeclSyntax{"
        let endImportDeclSyntax = "ImportDeclSyntax}"
        
        for element in syntaxes {
            // Import文は必要じゃないので、ImportDeclSyntaxを抜けるまではスキップする
            if element.hasPrefix(startImportDeclSyntax) {
                skipFlag = true
            } else if element.hasPrefix(endImportDeclSyntax) {
                skipFlag = false
            }
            
            if !skipFlag {
                if element.hasSuffix(startDeclSyntaxKeyword) {
                    // startDeclSyntaxKeywordを見つけたとき
                    // 宣言しているものの種類に合わせてcurrentHolderを初期化する
                    // 宣言しているものの種類に合わせてcurrentHolderFlagを更新する
                    let elementHolderType = element.dropLast(startDeclSyntaxKeyword.count)
                    switch elementHolderType {
                    case HolderType.struct.rawValue:
                        currentStructHolder = StructHolder()
                        currentHolderTypeFlag = .struct
                    case HolderType.class.rawValue:
                        currentClassHolder = ClassHolder()
                        currentHolderTypeFlag = .class
                    case HolderType.enum.rawValue:
                        currentEnumHolder = EnumHolder()
                        currentHolderTypeFlag = .enum
                    case HolderType.protocol.rawValue:
                        currentHolderTypeFlag = .protocol
                    case HolderType.variable.rawValue:
                        currentVariableHolder = VariableHolder()
                        currentHolderTypeFlag = .variable
                    case HolderType.function.rawValue:
                        currentFunctionHolder = FunctionHolder()
                        currentHolderTypeFlag = .function
                    case HolderType.extension.rawValue:
                        currentHolderTypeFlag = .extension
                    default:
                        break
                    }
                } else if element.hasSuffix(identifierKeyword) {
                    // identifierKeywordを見つけたとき
                    // elementTextは直近に初期化したHolderのnameプロパティに入る値を持っている
                    let elementText = String(element.dropFirst(identifierKeyword.count))
                    // currentHolderTypeFlagを参照して、直近に初期化したHolderのnameプロパティを更新する
                    // HoldersにcurrentHolderを格納する
                    switch currentHolderTypeFlag {
                    case .struct:
                        currentStructHolder.name = elementText
                        structHolders[elementText] = currentStructHolder
                    case .class:
                        currentClassHolder.name = elementText
                        classHolders[elementText] = currentClassHolder
                    case .enum:
                        currentEnumHolder.name = elementText
                        enumHolders[elementText] = currentEnumHolder
                    case .protocol:
    //                    currentProtocolHolder.name = elementText
                        break
                    case .variable:
                        currentVariableHolder.name = elementText
                        variableHolders[elementText] = currentVariableHolder
                    case .function:
                        currentFunctionHolder.name = elementText
                        FunctionHolders[elementText] = currentFunctionHolder
                    case .extension:
    //                    currentExtensionHolder.name = elementText
                        break
                    }
                    // 全体のスタック配列にHolderの種類と名前を追加する
                    stackArray.append(StackArrayElement(holderType: currentHolderTypeFlag, name: elementText))
                    positionInStack += 1
                } else if element.hasSuffix(endDeclSyntaxKeyword) {
                    
                }
            }
        }
    }
    
}
