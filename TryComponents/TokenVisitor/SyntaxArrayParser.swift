//
//  SyntaxesParser.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/31.
//

import Foundation

// TokenVisitorクラスが出力したsyntaxes配列を解析し、Holderのインスタンスを生成する
struct SyntaxArrayParser {
//    var syntaxes: [String]
    private var resultStructHolders = [StructHolder]()
    
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
    
    mutating func parse(syntaxes: [String]) {
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
            print(element)
            // Import文は必要じゃないので、ImportDeclSyntaxを抜けるまではスキップする
            if element.hasPrefix(startImportDeclSyntax) {
                skipFlag = true
            } else if element.hasPrefix(endImportDeclSyntax) {
                skipFlag = false
                continue
            } // end if
            
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
                    } // end switch
                } else if element.hasPrefix(identifierKeyword) {
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
                    } // end switch
                    // 全体のスタック配列にHolderの種類と名前を追加する
                    stackArray.append(StackArrayElement(holderType: currentHolderTypeFlag, name: elementText))
                    positionInStack += 1
                } else if element.hasSuffix(endDeclSyntaxKeyword) {
                    // endDeclSyntaxKeywordを見つけたとき
                    // 全体のスタック配列から、直近に宣言中のHolderの種類と名前を取得する
                    let currentHolderName = stackArray[positionInStack].name
                    // 取得した種類に応じたHoldersから、直近に宣言中のHolderを探す
                    switch currentHolderTypeFlag {
                    case .struct:
                        if let structHolder = structHolders[currentHolderName] {
                            currentStructHolder = structHolder
                        }
                    case .class:
                        if let classHolder = classHolders[currentHolderName] {
                            currentClassHolder = classHolder
                        }
                    case .enum:
                        if let enumHolder = enumHolders[currentHolderName] {
                            currentEnumHolder = enumHolder
                        }
                    case .protocol:
//                        if let protocolHolder =
                        break
                    case .variable:
                        if let variableHolder = variableHolders[currentHolderName] {
                            currentVariableHolder = variableHolder
                        }
                    case .function:
                        if let functionHolder = FunctionHolders[currentHolderName] {
                            currentFunctionHolder = functionHolder
                        }
                    case .extension:
//                        if let extension =
                        break
                    } // end switch
                    
                    if 0 < positionInStack {
                        // 親Holderがあるとき、親Holderのプロパティに追加する
                        let parentName = stackArray[positionInStack - 1].name
                        let parentHolderType = stackArray[positionInStack - 1].holderType
                        // 親のHolderType
                        switch parentHolderType {
                        case .struct: // 親がstructのとき
                            switch currentHolderTypeFlag { // 直近に宣言中のHolderType
                            case .struct:
                                structHolders[parentName]?.nestingStructs.append(currentStructHolder)
                            case .class:
                                structHolders[parentName]?.nestingClasses.append(currentClassHolder)
                            case .enum:
                                structHolders[parentName]?.nestingEnums.append(currentEnumHolder)
                            case .protocol:
                                break
                            case .variable:
                                structHolders[parentName]?.variables.append(currentVariableHolder)
                            case .function:
                                structHolders[parentName]?.functions.append(currentFunctionHolder)
                            case .extension:
                                break
                            } // end switch
                        case .class: // 親がclassのとき
                            switch currentHolderTypeFlag { // 直近に宣言中のHolderType
                            case .struct:
                                classHolders[parentName]?.nestingStructs.append(currentStructHolder)
                            case .class:
                                classHolders[parentName]?.nestingClasses.append(currentClassHolder)
                            case .enum:
                                classHolders[parentName]?.nestingEnums.append(currentEnumHolder)
                            case .protocol:
                                break
                            case .variable:
                                classHolders[parentName]?.variables.append(currentVariableHolder)
                            case .function:
                                classHolders[parentName]?.functions.append(currentFunctionHolder)
                            case .extension:
                                break
                            } // end switch
                        case .enum: // 親がenumのとき
                            switch currentHolderTypeFlag { // 直近に宣言中のHolderType
                            case .struct:
                                enumHolders[parentName]?.nestingStructs.append(currentStructHolder)
                            case .class:
                                enumHolders[parentName]?.nestingClasses.append(currentClassHolder)
                            case .enum:
                                enumHolders[parentName]?.nestingEnums.append(currentEnumHolder)
                            case .protocol:
                                break
                            case .variable:
                                enumHolders[parentName]?.variables.append(currentVariableHolder)
                            case .function:
                                enumHolders[parentName]?.functions.append(currentFunctionHolder)
                            case .extension:
                                break
                            }
                        case .protocol: // 親がprotocolのとき
                            break
                        case .variable: // 親がvariableのとき
                            break
                        case .function: // 親がfunctionのとき
                            break
                        case .extension: // 親がextensionのとき
                            break
                        } // end switch
                        
                        currentHolderTypeFlag = parentHolderType
                    } else {
                        // 親Holderがないとき、型全体の宣言が終わった
                        switch currentHolderTypeFlag {
                        case .struct:
                            resultStructHolders.append(currentStructHolder)
                        case .class:
                            break
                        case .enum:
                            break
                        case .protocol:
                            break
                        case .variable:
                            break
                        case .function:
                            break
                        case .extension:
                            break
                        }
                    } // end if
                    // 親HolderまたはresultHoldersに格納したものをスタック配列から削除する
                    stackArray.remove(at: positionInStack)
                    positionInStack -= 1
                }
            }
        }
    } // end func
    
    func getResultStructHolders() -> [StructHolder] {
        return resultStructHolders
    }
}
