//
//  HorizontalBorder?.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/03.
//

import SwiftUI

struct HorizontalBorder2: Shape {
    var width: CGFloat
    var borderThickness: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addRect(CGRect(x: 0, y: 0, width: self.width, height: self.borderThickness))
        }
    }
}

struct HorizontalBorder2_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalBorder2(width: 350, borderThickness: 5)
    }
}
