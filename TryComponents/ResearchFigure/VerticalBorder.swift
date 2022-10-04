//
//  VerticalBorder.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/30.
//

import SwiftUI

struct VerticalBorder: Shape {
    var borderThickness: CGFloat
    var height: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path(CGRect(x: rect.minX,
                    y: rect.minY,
                    width: self.borderThickness,
                    height: self.height))
    }
}

struct VerticalBorder_Previews: PreviewProvider {
    static var previews: some View {
        VerticalBorder(borderThickness: 5, height: 90)
    }
}
