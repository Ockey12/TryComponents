//
//  StructHolderToTextConverter.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/11/06.
//

import Foundation

struct StructHolderToTextConverter {
    func convertToText(structHolder: StructHolder) -> ConvertedToStringStructHolder {
        var convertedToTextStructHolder = ConvertedToStringStructHolder()
        
        convertedToTextStructHolder.name = structHolder.name
//        convertedToTextStructHolder.allStrings.append(structHolder.name)
        convertedToTextStructHolder.accessLevelIcon = structHolder.accessLevel.icon
        convertedToTextStructHolder.conformingProtocolNames = structHolder.conformingProtocolNames
        
        if 0 < structHolder.variables.count {
            for variableHolder in structHolder.variables {
                var variableString = ""
                if variableHolder.accessLevel != .internal {
                    variableString += variableHolder.accessLevel.icon + " "
                }
                if let customAttribure = variableHolder.customAttribute {
                    variableString += customAttribure + " "
                }
                if variableHolder.isVariable {
                    variableString += "var "
                } else {
                    variableString += "let "
                }
                variableString += variableHolder.name
                if let type = variableHolder.type {
                    variableString += ": " + type
                }
                if let initialValue = variableHolder.initialValue {
                    variableString += " = " + initialValue
                }
                convertedToTextStructHolder.variables.append(variableString)
            } // end for
        } // end if
        
        if 0 < structHolder.functions.count {
            for functionHolder in structHolder.functions {
                var functionString = ""
                functionString += functionHolder.accessLevel.icon + " "
                functionString += functionHolder.name
                
                if 0 < functionHolder.genericParameters.count {
                    functionString += "<"
                    for (index, element) in functionHolder.genericParameters.enumerated() {
                        functionString += element
                        if index < functionHolder.genericParameters.count - 1 {
                            functionString += ", "
                        }
                    } // end for
                    functionString += ">"
                } // end if
                
                functionString += "("
                if 0 < functionHolder.parameters.count {
                    for (index, parameter) in functionHolder.parameters.enumerated() {
                        if let externalName = parameter.externalParameterName {
                            functionString += externalName + " "
                        }
                        functionString += parameter.internalParameterName + ": "
                        if parameter.haveInoutKeyword {
                            functionString += "inout "
                        }
                        functionString += parameter.type
                        if parameter.isVariadic {
                            functionString += "..."
                        }
                        if let defaultValue = parameter.defaultParameter {
                            functionString += " = " + defaultValue
                        }
                        if index < functionHolder.parameters.count - 1 {
                            functionString += ", "
                        }
                    } // end for
                } // end if
                functionString += ")"
                
                if let returnType = functionHolder.returnValueType {
                    functionString += " -> " + returnType
                }
                convertedToTextStructHolder.functions.append(functionString)
            } // end for
        } // end if
        
        return convertedToTextStructHolder
    }
}
