//
//  HeaderPartsFrameWithText.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/26.
//

import SwiftUI

struct HeaderPartsFrameWithText: View {
    var with: CGFloat
    
    var body: some View {
        ZStack {
            HeaderPartsFrame(with: with)
            
            HeaderPartsFrame(with: with)
                .stroke(lineWidth: 5)
                .fill(Color.black)
            
            HStack {
                Text("Counter")
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .font(.system(size: 50))
                
                Spacer()
            }
            .frame(width: with - 60, height: 90)
            .position(x: with / 2 + 30, y: 45)
            
            
                
        }
        .frame(width: with + 60, height: 180)
    }
}

struct HeaderPartsFrameWithText_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPartsFrameWithText(with: 1000)
            .frame(width: 1200, height: 200)
            
    }
}
