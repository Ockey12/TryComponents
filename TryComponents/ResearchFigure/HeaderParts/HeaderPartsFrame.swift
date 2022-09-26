//
//  HeaderPartsFrame.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/26.
//

import SwiftUI

struct HeaderPartsFrame: Shape {
    var with: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 30, y: 0))
            path.addLine(to: CGPoint(x: 30, y: 30))
            path.addLine(to: CGPoint(x: 0, y: 30))
            path.addLine(to: CGPoint(x: 0, y: 60))
            path.addLine(to: CGPoint(x: 30, y: 60))
            path.addLine(to: CGPoint(x: 30, y: 180))
            
            path.addLine(to: CGPoint(x: 120, y: 180))
            path.addLine(to: CGPoint(x: 120, y: 90))
            path.addLine(to: CGPoint(x: with - 60, y: 90))
            path.addLine(to: CGPoint(x: with - 60, y: 180))
            path.addLine(to: CGPoint(x: with + 30, y: 180))
            path.addLine(to: CGPoint(x: with + 30, y: 60))
            path.addLine(to: CGPoint(x: with + 60, y: 60))
            path.addLine(to: CGPoint(x: with + 60, y: 30))
            path.addLine(to: CGPoint(x: with + 30, y: 30))
            path.addLine(to: CGPoint(x: with + 30, y: 0))
            path.closeSubpath()
        }
    }
}

struct HeaderPartsFrame_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPartsFrame(with: 600)
            .frame(width: 660, height: 180)
    }
}
