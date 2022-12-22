//
//  ArrowLineShape.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/12/22.
//

import SwiftUI

struct ArrowLineShape: View {
    let start: CGPoint
    let end: CGPoint
    
    var body: some View {
        Path { path in
            path.move(to: start)
            path.addLine(to: end)
        }
        .stroke(lineWidth: 10)
        .fill(.black)
    }
}

//struct ArrowLineShape_Previews: PreviewProvider {
//    static var previews: some View {
//        ArrowLineShape()
//    }
//}
