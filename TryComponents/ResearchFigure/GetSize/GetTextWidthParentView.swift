//
//  GetTextWidthParentView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/12/14.
//

import SwiftUI

struct GetTextWidthParentView: View {
    @State private var maxTextWidth: Double = 0
    let strings = ["aaa", "bbbbbb", "cccccccccccc", "ddddddddd", "eee"]
    var body: some View {
        VStack {
            GetTextWidthView(strings: strings, maxWidth: $maxTextWidth)
        }
        
        Text("ZZZZZZ")
            .frame(width: maxTextWidth)
            .background(.green)
        
        Text("maxTextWidth: \(maxTextWidth)")
    }
}

struct GetTextWidthParentView_Previews: PreviewProvider {
    static var previews: some View {
        GetTextWidthParentView()
    }
}
