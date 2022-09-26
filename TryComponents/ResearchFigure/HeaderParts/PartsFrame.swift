//
//  PartsFrame.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/26.
//

import SwiftUI

struct PartsFrame: Shape {
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
            path.addLine(to: CGPoint(x: 480, y: 90))
            path.addLine(to: CGPoint(x: 480, y: 180))
            path.addLine(to: CGPoint(x: 570, y: 180))
            path.addLine(to: CGPoint(x: 570, y: 60))
            path.addLine(to: CGPoint(x: 600, y: 60))
            path.addLine(to: CGPoint(x: 600, y: 30))
            path.addLine(to: CGPoint(x: 570, y: 30))
            path.addLine(to: CGPoint(x: 570, y: 0))
            path.closeSubpath()
        }
    }
}

struct PartsFrame_Previews: PreviewProvider {
    static var previews: some View {
        PartsFrame(with: 600)
    }
}
