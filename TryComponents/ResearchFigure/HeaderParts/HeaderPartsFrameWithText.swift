//
//  HeaderPartsFrameWithText.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/26.
//

import SwiftUI

struct HeaderPartsFrameWithText: View {
    var body: some View {
        ZStack {
            HeaderPartsFrame(with: 600)
            
            HStack {
                Text("Counter")
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .font(.system(size: 50))
                
                Spacer()
            }
            .frame(width: 500, height: 90)
            .position(x: 300, y: 45)
            
            
                
        }
        .frame(width: 600, height: 180)
    }
}

struct HeaderPartsFrameWithText_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPartsFrameWithText()
    }
}
