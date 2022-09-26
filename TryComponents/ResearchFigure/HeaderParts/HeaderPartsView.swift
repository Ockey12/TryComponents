//
//  HeaderPartsView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/26.
//

import SwiftUI

struct HeaderPartsView: View {
    var body: some View {
        ZStack {
            IndexFrameWithText(with: 150)
                .position(x: 105, y: 25)
            
            HeaderPartsFrameWithText()
                .frame(width: 600, height: 180)
                .position(x: 300, y: 140)
        }
        .frame(width: 600, height: 210)
    }
}

struct HeaderPartsView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPartsView()
    }
}
