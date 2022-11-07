//
//  SampleForTokenVisitor.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/29.
//

import Foundation
import SwiftUI

protocol Protocol1 {

}

protocol Protocol2 {

}

struct ViewStruct: Protocol1, Protocol2 {
    let typeInferenceVariable = 1111111111
    var nomalVariable: String = "2222222222"
    var childVariable: ChildStruct = ChildStruct()
    var dictionaryVariable: [String: Int?] = ["Key": 333333]
    var toupleVariable: (Double, Float) = (4.444, 5.55)
    @State var stateVariable: Int
    
    func genericsFunction<TTT: Equatable, UUU>(x: TTT, y: UUU) -> UUU {
        let returnValue = y
        return returnValue
    }
    func ExtParamNameFunction(out1 in1: Int, in2: String) {}
    func InoutFunction(num: inout Int) {}
    func VariadicFunction(num: Int...) {}
    func DefaultFunction1(out in: Int, num: inout Int, nums: Int... ,text: String = "sampleText") {}
    func DefaultFunction2(num: Int = 10000000000) {}
    func returnFunction(text: String) -> Int {
        return 0
    }
    func returnDectionaryFunction() -> [String: Int] {
        return ["Key": 100000]
    }
    func returnTupleFunction() -> (Double, Float) {
        return (3.3, 9.9)
    }
}

struct ChildStruct {}

struct VariableStruct: Protocol1 {
    let typeInferenceVariable = 1111111111
    var nomalVariable: String = "2222222222"
    var childVariable: ChildStruct = ChildStruct()
    var dictionaryVariable: [String: Int?] = ["Key": 333333]
    var toupleVariable: (Double, Float) = (4.444, 5.55)
    @State var stateVariable: Int
    
//    static var staticVariable: Int = 1111111111
//    lazy var lazyVariable: Int = {
//        return 2222222222
//    }()
//    private var privateVariable: String
//    let unchangeableVariable: Double
//    var observerVariable = 3333333333 {
//        willSet {
//            print("willSet willSet willSet")
//        }
//        didSet {
//            print("didSet didSet didSet")
//        }
//    }
//    var celsius: Double = 0.0
//    var fahrenheit: Double {
//        get {
//            return (9.0/5.0) * celsius + 32.0
//        }
//        set (newFahrenheit) {
//            celsius = (5.0/9.0) * (newFahrenheit - 32.0)
//        }
//    }
//
//    var omitSetterVariable: String {
//        return "omitSetter omitSetter omitSetter"
//    }
}

//struct FunctionStruct {
//    func genericsFunction<TTT: Equatable, UUU>(x: TTT, y: UUU) -> UUU {
//        let returnValue = y
//        return returnValue
//    }
//    func genericsFunction2<TTT: Equatable, UUU>(x: TTT, y: UUU) -> UUU {
//        let returnValue = y
//        return returnValue
//    }
//    var variable1 = 1
//    private func privateFunction() {}
//    func ExtParamNameFunction(out1 in1: Int, in2: String) {}
//    func InoutFunction(num: inout Int) {}
//    func VariadicFunction(num: Int...) {}
//    func DefaultFunction1(out in: Int, num: inout Int, nums: Int... ,text: String = "sampleText") {}
//    struct nestedStruct {
//        func nestedFunction(for name: String) {}
//    }
//    func DefaultFunction2(num: Int = 10000000000) {}
//    func returnFunction(text: String) -> Int {
//        return 0
//    }
//    func returnDectionaryFunction() -> [String: Int] {
//        return ["Key": 100000]
//    }
//    func returnTupleFunction() -> (Double, Float) {
//        return (3.3, 9.9)
//    }
//}

//struct SampleStruct {
//
//}
//
//
//
//struct ConformingStruct: Protocol1, Protocol2 {
//
//}
//struct SampleStruct: Protocol1 {
//    var variable1 = 1
//    var variable2 = 2
//    var variable3 = 3
//    static var StaticVariable = 100
//    struct NestedStruct1 {
//
//    }
//    struct NestedStruct2 {
//
//    }
//}

//private struct StructSample {
//    struct NestedStruct {
//        var num = 1
//    }
//    @State private var VariableSample: Int = 1
//    func ExtParamNameFunction(out in: Int) {
//
//    }
//    func InoutFunction(num: inout Int) {
//
//    }
//    func VariadicFunction(num: Int...) {
//
//    }
//    func DefaultFunction(num: Int = 1) {
//
//    }
//    func ReturnFunction() -> Int {
//        return 0
//    }
//}

//struct NotPrivateStruct {
//
//}
//
//private struct PrivateStruct {
//    func sampleFunction() {}
//}
//
//struct SampleStruct {
//    var variable1 = 1
//    var variable2 = 2
//    var variable3 = 3
//    static var StaticVariable = 100
//    struct NestedStruct1 {
//
//    }
//    struct NestedStruct2 {
//
//    }
//}

//extension SampleStruct {
//    func SampleFunction() {
//
//    }
//}
