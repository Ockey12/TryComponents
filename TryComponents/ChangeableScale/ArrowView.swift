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
    
    let arrowHeadFrameLength: CGFloat = 70
    
    var body: some View {
        ZStack {
            ZStack {
                ArrowHeadShape(centerOfRotation: endPoint(start: start, end: end), rotate: angle(a: start, b: end), arrowHeadFrameLength: arrowHeadFrameLength)
            }
            .frame(width: arrowHeadFrameLength, height: arrowHeadFrameLength)
//            .background(.pink)
            .position(x: endPoint(start: start, end: end).x, y: endPoint(start: start, end: end).y)
            ArrowLineShape(start: start, end: endPoint(start: start, end: end))
            
//            ForEach(0..<365) { num in
//                ArrowHeadShape(centerOfRotation: end, rotate: Angle(degrees: Double(num)))
//                    .background(.pink)
//            }
//            ArrowHeadShape(centerOfRotation: end, rotate: angle(a: start, b: end))
//                .rotationEffect(angle(a: start, b: end), anchor: UnitPoint(x: end.x, y: end.y))
//                .rotationEffect(Angle(degrees: 1), anchor: UnitPoint(x: end.x, y: end.y))
//                .rotationEffect(angle(a: start, b: end))
//            Path { path in
//                path.move(to: start)
//                // 線分
//                path.addLine(to: CGPoint(x: start.x + distance(a: start, b: end) - 50, y: start.y))
//            }
//            .stroke(lineWidth: 20)
//            .fill(.black)
//
//            Path { path in
//                path.move(to: CGPoint(x: start.x + distance(a: start, b: end) - 50, y: start.y))
//
//                // 三角形
//                path.addLine(to: CGPoint(x: start.x + distance(a: start, b: end) - 50, y: start.y - 25))
//                path.addLine(to: CGPoint(x: start.x + distance(a: start, b: end), y: start.y))
//                path.addLine(to: CGPoint(x: start.x + distance(a: start, b: end) - 50, y: start.y + 25))
//                path.addLine(to: CGPoint(x: start.x + distance(a: start, b: end) - 50, y: start.y))
//            }
//            .fill(.black)
        }
//        .rotationEffect(angle(a: start, b: end), anchor: UnitPoint(x: start.x, y: start.y))
//        Path { path in
//            path.move(to: start)
//
//            // 線分
//            path.addLine(to: CGPoint(x: start.x + distance(a: start, b: end) - 10, y: start.y))
//
//            // 三角形
//            path.addLine(to: CGPoint(x: start.x + distance(a: start, b: end) - 10, y: start.y - 25))
//            path.addLine(to: CGPoint(x: start.x + distance(a: start, b: end) + 40, y: start.y))
//            path.addLine(to: CGPoint(x: start.x + distance(a: start, b: end) - 10, y: start.y + 25))
//            path.addLine(to: CGPoint(x: start.x + distance(a: start, b: end) - 10, y: start.y))
//        }
//        .stroke(lineWidth: 20)
//        .fill(.black)
//        ZStack {
//            ArrowLineShape(start: start, end: end)
//            ArrowHeadShape(position: end)
//        } // ZStack
    } // var body
    
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
    
    private func distance(a: CGPoint, b: CGPoint) -> CGFloat {
        return sqrt(pow(b.x - a.x, 2) + pow(b.y - a.y, 2))
    }
    
    private func angle(a: CGPoint, b: CGPoint) -> Angle {
        var r = atan2(b.y - a.y, b.x - a.x)
        if r < 0 {
            r = r + 2*Double.pi
        }
        return Angle(degrees: floor(r*360 / (2*Double.pi)))
    }
}

//struct ArrowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArrowView()
//    }
//}
