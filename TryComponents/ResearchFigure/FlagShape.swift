//
//  FlagShape.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/25.
//

import SwiftUI

struct FlagShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.width/2, y: rect.height/2))
            path.addLine(to: CGPoint(x: 0, y: rect.height * 1/4))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height * 1/4))
            path.closeSubpath()
        }
    }
}

struct FlagShape_Previews: PreviewProvider {
    static var previews: some View {
        FlagShape()
            .stroke(lineWidth: 3)
    }
}
