//
//  IndexFrameWithText.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/26.
//

import SwiftUI

struct IndexFrameWithText: View {
    var with: CGFloat
    var height: CGFloat {
        return with / 3
    }
    
    var body: some View {
        ZStack {
            IndexFrame()
                .fill(.gray)
                .frame(width: with, height: height)
            
            Text("○protocol")
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .frame(width: with - 20, height: height * 0.9)
                .font(.system(size: height * 0.5))
                .foregroundColor(.black)
        }
    }
}

struct IndexFrameWithText_Previews: PreviewProvider {
    static var previews: some View {
        IndexFrameWithText(with: 300)
    }
}
