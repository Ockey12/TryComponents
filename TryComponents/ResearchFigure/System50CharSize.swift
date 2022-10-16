//
//  System50CharSize.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/16.
//

import Foundation

struct System50CharSize {
    var string: String
    
    func getCharWidth(char: Character) -> CGFloat {
        switch char {
        case "a":
            return 25.5
        case "b":
            return 28.5
        case "c":
            return 25.5
        case "d":
            return 28.5
        case "e":
            return 26
        case "f":
            return 16
        case "g":
            return 28
        case "h":
            return 27.5
        case "i":
            return 11
        case "j":
            return 11
        case "k":
            return 25
        case "l":
            return 11
        case "m":
            return 41
        case "n":
            return 27
        case "o":
            return 27
        case "p":
            return 28
        case "q":
            return 28
        case "r":
            return 16
        case "s":
            return 24
        case "t":
            return 15.5
        case "u":
            return 27
        case "v":
            return 24.5
        case "w":
            return 36.5
        case "x":
            return 24
        case "y":
            return 25
        case "z":
            return 24
        case "A":
            return 32.5
        case "B":
            return 31
        case "C":
            return 35
        case "D":
            return 34.5
        case "E":
            return 28
        case "F":
            return 27
        case "G":
            return 36
        case "H":
            return 35.5
        case "I":
            return 12
        case "J":
            return 25.5
        case "K":
            return 30.5
        case "L":
            return 27
        case "M":
            return 42
        case "N":
            return 35.5
        case "O":
            return 37
        case "P":
            return 29.5
        case "Q":
            return 37
        case "R":
            return 30.5
        case "S":
            return 30.5
        case "T":
            return 29.5
        case "U":
            return 35.5
        case "V":
            return 32
        case "W":
            return 47
        case "X":
            return 32.5
        case "Y":
            return 31
        case "Z":
            return 31.5
        case "1":
            return 23
        case "2":
            return 29
        case "3":
            return 30
        case "4":
            return 31
        case "5":
            return 30
        case "6":
            return 31.5
        case "7":
            return 28
        case "8":
            return 30.5
        case "9":
            return 31.5
        case "0":
            return 31
        case "!":
            return 14
        case "@":
            return 44.5
        case "#":
            return 31
        case "$":
            return 31
        case "%":
            return 41
        case "^":
            return 31
        case "&":
            return 34
        case "*":
            return 20.5
        case "(":
            return 16.5
        case ")":
            return 16.5
        case "-":
            return 22
        case "_":
            return 27
        case "=":
            return 31
        case "+":
            return 31
        case "|":
            return 11.5
        case "`":
            return 25.5
        case "~":
            return 31
        case "[":
            return 16
        case "{":
            return 16.5
        case "]":
            return 16
        case "}":
            return 16.5
        case ";":
            return 11.5
        case ":":
            return 11.5
        case "'":
            return 13.5
        case ",":
            return 11.5
        case ".":
            return 11.5
        case "<":
            return 31
        case ">":
            return 31
        case "/":
            return 14.5
        case "?":
            return 25
        default:
            return 47
        }
    }
    
    func getStringWidth() -> CGFloat {
        var width: CGFloat = 0
        for char in string {
            width += getCharWidth(char: char)
        }
        return width
    }
}
