//
//  HeaderPartsFrameWithText.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/26.
//

import SwiftUI

struct HeaderPartsFrameWithText: View {
    var width: CGFloat
    
    let itemHeight = HeaderPartsSettingValues.itemHeight
    
    var body: some View {
        ZStack {
            HeaderPartsFrame(width: width)
            
            HeaderPartsFrame(width: width)
                .stroke(lineWidth: 5)
                .fill(Color.black)
            
            HStack {
                Text("Counter")
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .font(.system(size: 50))
                
                Spacer()
            }
            .frame(width: width, height: itemHeight)
            .position(x: width / 2 + 30, y: itemHeight/2)
            
            
                
        }
        .frame(width: width + 60, height: 180)
    }
}

struct HeaderPartsFrameWithText_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPartsFrameWithText(width: 1000)
            .frame(width: 1200, height: 200)
            
    }
}
