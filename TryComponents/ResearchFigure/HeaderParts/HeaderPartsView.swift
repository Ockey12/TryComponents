//
//  HeaderPartsView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/26.
//

import SwiftUI

struct HeaderPartsView: View {
    var with: CGFloat
    
    var body: some View {
        ZStack {
            IndexFrameWithText(with: 150)
                .position(x: 105, y: 25)
            
            HeaderPartsFrameWithText(width: with)
                .position(x: with / 2 + 30, y: 140)
        }
        .frame(width: with + 60, height: 230)
    }
}

struct HeaderPartsView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPartsView(with: 800)
            .frame(width: 1000, height: 300)
    }
}
