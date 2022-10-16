//
//  System50CharSize.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/16.
//

import Foundation

struct System50CharSize {
    var string: String
    
    func getStringWidth() -> CGFloat {
        var width: CGFloat = 0
        for char in string {
            switch char {
            case "a":
                width += 25.5
            case "b":
                width += 28.5
            case "c":
                width += 25.5
            case "d":
                width += 28.5
            case "e":
                width += 26
            case "f":
                width += 16
            case "g":
                width += 28
            case "h":
                width += 27.5
            case "i":
                width += 11
            case "j":
                width += 11
            case "k":
                width += 25
            case "l":
                width += 11
            case "m":
                width += 41
            case "n":
                width += 27
            case "o":
                width += 27
            case "p":
                width += 28
            case "q":
                width += 28
            case "r":
                width += 16
            case "s":
                width += 24
            case "t":
                width += 15.5
            case "u":
                width += 27
            case "v":
                width += 24.5
            case "w":
                width += 36.5
            case "x":
                width += 24
            case "y":
                width += 25
            case "z":
                width += 24
            case "A":
                width += 32.5
            case "B":
                width += 31
            case "C":
                width += 35
            case "D":
                width += 34.5
            case "E":
                width += 28
            case "F":
                width += 27
            case "G":
                width += 36
            case "H":
                width += 35.5
            case "I":
                width += 12
            case "J":
                width += 25.5
            case "K":
                width += 30.5
            case "L":
                width += 27
            case "M":
                width += 42
            case "N":
                width += 35.5
            case "O":
                width += 37
            case "P":
                width += 29.5
            case "Q":
                width += 37
            case "R":
                width += 30.5
            case "S":
                width += 30.5
            case "T":
                width += 29.5
            case "U":
                width += 35.5
            case "V":
                width += 32
            case "W":
                width += 47
            case "X":
                width += 32.5
            case "Y":
                width += 31
            case "Z":
                width += 31.5
            default:
                width += 47
            }
        }
        return width
    }
}
