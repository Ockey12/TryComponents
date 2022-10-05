//
//  GetTextSize.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/05.
//

import SwiftUI

struct GetTextSize: View {

    let text = ".frame(width: CGFloat(text.count)*characterWidth)"
    let characterWidth: CGFloat = 35.5
    @State var maxTextWidth: CGFloat = 0
    
    func getTextWidth(width: CGFloat) {
        if self.maxTextWidth < width {
            self.maxTextWidth = width
        }
    }
    
    var body: some View {
        Text(text)
            .lineLimit(1)
            .font(.system(size: 50))
            .foregroundColor(.black)
            .background(.white)
            .border(.pink, width: 1)
            .background(GeometryReader{ geometry -> Text in
                getTextWidth(width: geometry.size.width)
                return Text("")
            })
    }
}

struct GetTextSize_Previews: PreviewProvider {
    static var previews: some View {
        GetTextSize()
            .frame(width: 2000, height: 200)
    }
}
