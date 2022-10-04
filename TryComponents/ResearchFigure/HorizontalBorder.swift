//
//  HorizontalBorder.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/30.
//

import SwiftUI

struct HorizontalBorder: Shape {
    var borderThickness: CGFloat
    var width: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path(CGRect(x: 0,
                    y: 0,
                    width: self.width,
                    height: self.borderThickness))
    }
}

struct HorizontalBorder_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalBorder(borderThickness: 5, width: 300)
    }
}
