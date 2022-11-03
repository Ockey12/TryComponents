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
    private var resultClassHolders = [ClassHolder]()
    private var resultEnumHolders = [EnumHolder]()
    private var resultProtocolHolders = [ProtocolHolder]()
    private var resultVariableHolders = [VariableHolder]()
    private var resultFunctionHolders = [FunctionHolder]()
//    private var resultExtensionHolders = []
    
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
    }
    
    mutating func parse(syntaxes: [String]) {
        var stackArray = [StackArrayElement]()
        var structHolders = [String: StructHolder]()
        var classHolders = [String: ClassHolder]()
        var enumHolders = [String: EnumHolder]()
        var protocolHolders = [String: ProtocolHolder]()
        var variableHolders = [String: VariableHolder]()
        var FunctionHolders = [String: FunctionHolder]()
    //    var extensionHolders = [String: ExtensionHolders]()
        
        var currentHolderTypeFlag: HolderType = .struct
        var currentStructHolder = StructHolder()
        var currentClassHolder = ClassHolder()
        var currentEnumHolder = EnumHolder()
        var currentProtocolHolder = ProtocolHolder()
        var currentVariableHolder = VariableHolder()
        var currentFunctionHolder = FunctionHolder()
//        var currentExtensionHolder: ExtensionHolder
        
        var positionInStack = -1
        var skipImportDeclFlag = false
//        var inheritedTypeSyntaxFlag = false
        
        let startDeclSyntaxKeyword = "DeclSyntax{"
        let endDeclSyntaxKeyword = "DeclSyntax}"
        let identifierKeyword = "identifier"
        let startImportDeclSyntax = "ImportDeclSyntax{"
        let endImportDeclSyntax = "ImportDeclSyntax}"
        let startInheritedTypeSyntax = "InheritedTypeSyntax{"
        let endInheritedTypeSyntax = "InheritedTypeSyntax}"
        
        enum syntaxNodeTypeForIdentifier {
            case structDeclSyntax
            case functionDeclSyntax
            case functionParameterSyntax
            case protocolDeclSyntax
            case inheritedTypeSyntax
            
            
            init?(type: String) {
                switch type {
                case "StructDeclSyntax":
                    self = .structDeclSyntax
                case "FunctionDeclSyntax":
                    self = .functionDeclSyntax
                case "FunctionParameterSyntax":
                    self = .functionParameterSyntax
                case "ProtocolDeclSyntax":
                    self = .protocolDeclSyntax
                case "InheritedTypeSyntax":
                    self = .inheritedTypeSyntax
                default:
                    return nil
                }
            }
        }
        
        for element in syntaxes {
            print(element)
            // Import文は必要じゃないので、ImportDeclSyntaxを抜けるまではスキップする
            if element == startImportDeclSyntax {
                skipImportDeclFlag = true
            } else if element == endImportDeclSyntax {
                skipImportDeclFlag = false
                continue
            } // end if
            
            if !skipImportDeclFlag {
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
                        currentProtocolHolder = ProtocolHolder()
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
                    // identifierContents[0]: "identifier"
                    // identifierContents[1]: syntaxNodeType
                    // identifierContents[2]: token.text
                    let identifierContents = element.components(separatedBy: " ")
                    for i in 0..<identifierContents.count {
                        print("identifierContents[" + "\(i)" + "]: " + identifierContents[i])
                    }
//                    print("identifierContents[0]: " + identifierContents[0])
//                    print("identifierContents[1]: " + identifierContents[1])
//                    print("identifierContents[2]: " + identifierContents[2])
                    guard let syntaxNodeType = syntaxNodeTypeForIdentifier(type: identifierContents[1]) else {
                        fatalError("ERROR: guard let syntaxNodeType = syntaxNodeTypeForIdentifier(type: identifierContents[1])")
                    }
                    let name = identifierContents[2]
                    // currentHolderTypeFlagを参照して、直近に初期化したHolderのnameプロパティを更新する
                    // HoldersにcurrentHolderを格納する
                    switch syntaxNodeType {
                    case .structDeclSyntax: // structの宣言中
                        currentStructHolder.name = name
                        structHolders[name] = currentStructHolder
                        // 全体のスタック配列にHolderの種類と名前を追加する
                        stackArray.append(StackArrayElement(holderType: currentHolderTypeFlag, name: name))
                        positionInStack += 1
                    case .functionDeclSyntax: // functionの宣言中
                        currentFunctionHolder.name = name
                        FunctionHolders[name] = currentFunctionHolder
                        // 全体のスタック配列にHolderの種類と名前を追加する
                        stackArray.append(StackArrayElement(holderType: currentHolderTypeFlag, name: name))
                        positionInStack += 1
                    case .functionParameterSyntax: // functionの引数の宣言中
                        var parameterHolder = FunctionParameterHolder(internalParameterName: identifierContents[3], type: identifierContents[2])
                        if identifierContents.count == 5 {
                            parameterHolder.externalParameterName = identifierContents[4]
                        }
                        let holderName = stackArray[positionInStack].name
                        FunctionHolders[holderName]?.parameters.append(parameterHolder)
                    case .protocolDeclSyntax: // protocolの宣言中
                        currentProtocolHolder.name = name
                        protocolHolders[name] = currentProtocolHolder
                        // 全体のスタック配列にHolderの種類と名前を追加する
                        stackArray.append(StackArrayElement(holderType: currentHolderTypeFlag, name: name))
                        positionInStack += 1
                    case .inheritedTypeSyntax: // protocolの宣言ではなく、protocolへの準拠
                        let holderName = stackArray[positionInStack].name
                        switch currentHolderTypeFlag {
                        case .struct:
                            structHolders[holderName]?.conformingProtocolNames.append(name)
                        case .class:
                            classHolders[holderName]?.conformingProtocolNames.append(name)
                        case .enum:
                            enumHolders[holderName]?.conformingProtocolNames.append(name)
                        case .protocol:
                            protocolHolders[holderName]?.inheritedProtocolNames.append(name)
                        case .variable:
                            break
                        case .function:
                            break
                        case .extension:
                            break
                        } // end switch
                    }
//                    if inheritedTypeSyntaxFlag { // protocolの宣言ではなく、protocolへの準拠
//                        let holderName = stackArray[positionInStack].name
//                        switch currentHolderTypeFlag {
//                        case .struct:
//                            structHolders[holderName]?.conformingProtocolNames.append(name)
//                        case .class:
//                            classHolders[holderName]?.conformingProtocolNames.append(name)
//                        case .enum:
//                            enumHolders[holderName]?.conformingProtocolNames.append(name)
//                        case .protocol:
//                            protocolHolders[holderName]?.inheritedProtocolNames.append(name)
//                        case .variable:
//                            break
//                        case .function:
//                            break
//                        case .extension:
//                            break
//                        } // end switch
//                    } else {
//                        switch currentHolderTypeFlag {
//                        case .struct:
//                            currentStructHolder.name = name
//                            structHolders[name] = currentStructHolder
//                        case .class:
//                            currentClassHolder.name = name
//                            classHolders[name] = currentClassHolder
//                        case .enum:
//                            currentEnumHolder.name = name
//                            enumHolders[name] = currentEnumHolder
//                        case .protocol:
//                            currentProtocolHolder.name = name
//                            protocolHolders[name] = currentProtocolHolder
//                        case .variable:
//                            currentVariableHolder.name = name
//                            variableHolders[name] = currentVariableHolder
//                        case .function:
//                            currentFunctionHolder.name = name
//                            FunctionHolders[name] = currentFunctionHolder
//                        case .extension:
//        //                    currentExtensionHolder.name = elementText
//                            break
//                        } // end switch
//                        // 全体のスタック配列にHolderの種類と名前を追加する
//                        stackArray.append(StackArrayElement(holderType: currentHolderTypeFlag, name: name))
//                        positionInStack += 1
//                    } // end if
                } else if element == "inoutKeyword" {
                    // functionで直前に抽出した引数がinoutキーワードを持っていたとき
                    let holderName = stackArray[positionInStack].name
                    let i = (FunctionHolders[holderName]?.parameters.count)! - 1
                    FunctionHolders[holderName]?.parameters[i].haveInoutKeyword = true
                } else if element.hasSuffix(endDeclSyntaxKeyword) {
                    // endDeclSyntaxKeywordを見つけたとき
                    // 全体のスタック配列から、直近に宣言中のHolderの名前を取得する
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
                        if let protocolHolder = protocolHolders[currentHolderName] {
                            currentProtocolHolder = protocolHolder
                        }
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
                            switch currentHolderTypeFlag { // 直近に宣言中のHolderType
                            case .struct:
                                break
                            case .class:
                                break
                            case .enum:
                                break
                            case .protocol:
                                break
                            case .variable:
                                protocolHolders[parentName]?.variables.append(currentVariableHolder)
                            case .function:
                                protocolHolders[parentName]?.functions.append(currentFunctionHolder)
                            case .extension:
                                break
                            }
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
                            resultClassHolders.append(currentClassHolder)
                        case .enum:
                            resultEnumHolders.append(currentEnumHolder)
                        case .protocol:
                            resultProtocolHolders.append(currentProtocolHolder)
                        case .variable:
                            resultVariableHolders.append(currentVariableHolder)
                        case .function:
                            resultFunctionHolders.append(currentFunctionHolder)
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
    
    func getResultClassHolders() -> [ClassHolder] {
        return resultClassHolders
    }
    
    func getResultEnumHolders() -> [EnumHolder] {
        return resultEnumHolders
    }
    
    func getResultProtocolHolders() -> [ProtocolHolder] {
        return resultProtocolHolders
    }
    
    func getResultVariableHolders() -> [VariableHolder] {
        return resultVariableHolders
    }
    
    func getResultFunctionHolders() -> [FunctionHolder] {
        return resultFunctionHolders
    }
    
//    func getResultExtensionHolders() -> [] {
//
//    }
}
