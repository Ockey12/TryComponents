//
//  PropertyHeaderFrame.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/30.
//

import SwiftUI

struct PropertyHeaderFrame: Shape {
    var width: CGFloat
    var invisiblePaddingWith: CGFloat {
        (self.width - 350) / 2
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: invisiblePaddingWith, y: 0))
            path.addLine(to: CGPoint(x: invisiblePaddingWith, y: 90))
            path.addLine(to: CGPoint(x: width - invisiblePaddingWith, y: 90))
            path.addLine(to: CGPoint(x: width - invisiblePaddingWith, y: 0))
            path.closeSubpath()
        }
    }
}

struct PropertyHeaderFrame_Previews: PreviewProvider {
    static var previews: some View {
        PropertyHeaderFrame(width: 700)
    }
}
