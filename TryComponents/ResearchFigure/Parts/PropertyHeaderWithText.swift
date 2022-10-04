//
//  PropertyHeaderWithText.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/30.
//

import SwiftUI

struct PropertyHeaderWithText: View {
    var width: CGFloat
    let height: CGFloat = 90
    
    var body: some View {
        ZStack {
            PropertyHeaderFrame(width: self.width)
            
            Text("Rawvalue Type")
                .lineLimit(1)
                .foregroundColor(.black)
                .font(.system(size: 50))
                .position(x: self.width / 2, y: self.height / 2)
            
            HorizontalBorder2(width: 350, borderThickness: 5)
                .fill(.red)
                .position(x: 525, y: 45)
                
        }
        .frame(width: self.width, height: self.height)
    }
}

struct PropertyHeaderWithText_Previews: PreviewProvider {
    static var previews: some View {
        PropertyHeaderWithText(width: 700)
    }
}
