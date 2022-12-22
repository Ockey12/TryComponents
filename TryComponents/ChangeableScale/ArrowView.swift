//
//  ArrowView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/12/22.
//

import SwiftUI

struct ArrowView: View {
    let start: CGPoint
    let end: CGPoint
    
    var body: some View {
        ZStack {
            ArrowLineShape(start: start, end: end)
            ArrowHeadShape(position: end)
        } // ZStack
    } // var body
}

//struct ArrowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArrowView()
//    }
//}
