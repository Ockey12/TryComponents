//
//  ArrowHeadShape.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/12/22.
//

import SwiftUI

struct ArrowHeadShape: View {
    let position: CGPoint
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: position.x + 10, y: position.y + 10))
            path.addLine(to: CGPoint(x: position.x - 40, y: position.y + 10))
            path.addLine(to: CGPoint(x: position.x - 15, y: position.y - 40))
            path.addLine(to: CGPoint(x: position.x + 10, y: position.y + 10))
        }
        .fill(.black)
    }
}

//struct ArrowHeadShape_Previews: PreviewProvider {
//    static var previews: some View {
//        ArrowHeadShape()
//    }
//}
