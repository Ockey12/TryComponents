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
//            path.addLine(to: endPoint(start: start, end: end))
            path.addLine(to: end)
        }
        .stroke(lineWidth: 20)
        .fill(.black)
    }
    
    private func endPoint(start: CGPoint, end: CGPoint) -> CGPoint {
        let tipMargin: CGFloat = 20
        var endX = end.x
        var endY = end.y
        
        if end.x < start.x {
            endX += tipMargin
        } else if start.x < end.x {
            endX -= tipMargin
        }
        
        if end.y < start.y {
            endY += tipMargin
        } else if start.y < end.y {
            endY -= tipMargin
        }
        
        return CGPoint(x: endX, y: endY)
    } // func endPoint(start: CGPoint, end: CGPoint) -> CGPoint
}

//struct ArrowLineShape_Previews: PreviewProvider {
//    static var previews: some View {
//        ArrowLineShape()
//    }
//}
