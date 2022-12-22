//
//  ArrowHeadShape.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/12/22.
//

import SwiftUI

struct ArrowHeadShape: View {
    let centerOfRotation: CGPoint
    let rotate: Angle
    let arrowHeadFrameLength: CGFloat
    
//    let position: CGPoint
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: arrowHeadFrameLength, y: arrowHeadFrameLength/2))
            
            path.addLine(to: CGPoint(x: 0, y: arrowHeadFrameLength))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: arrowHeadFrameLength, y: arrowHeadFrameLength/2))
//            path.move(to: centerOfRotation)
//            path.addLine(to: CGPoint(x: centerOfRotation.x - 50, y: centerOfRotation.y + 25))
//            path.addLine(to: CGPoint(x: centerOfRotation.x - 50, y: centerOfRotation.y - 25))
//            path.addLine(to: centerOfRotation)
        }
        .fill(.black)
//        .frame(width: 50, height: 50)
        .rotationEffect(rotate)
    }
}

//struct ArrowHeadShape_Previews: PreviewProvider {
//    static var previews: some View {
//        ArrowHeadShape()
//    }
//}
