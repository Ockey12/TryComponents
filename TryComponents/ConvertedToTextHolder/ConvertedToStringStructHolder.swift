//
//  ConvertedToTextStructHolder.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/11/06.
//

import Foundation

struct ConvertedToStringStructHolder {
    var name = ""
    var accessLevelIcon = ""
    var conformingProtocolNames = [String]()
    var variables = [String]()
    var functions = [String]()
    
    var allStrings: [String] {
        let array = [name]
        return array + conformingProtocolNames + variables + functions
    }
}
