//
//  [Sample]instanceView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/13.
//

import SwiftUI

struct _Sample_instanceView: View {
    
//    var string1 = "var body"
//    var string2 = "a"
//    var string3 = ".frame(width: CGFloat(text.count)*characterWidth)"
//    var string4 = "DetailPartsWithText"
//    var stringsArray: [String] {
//        [string1, string2, string3, string4]
//    }
    
    let strings = ["var body", "a", ".frame(width: CGFloat(text.count)*characterWidth)", "DetailPartsWithText"]
    
    @State private var maxTextWidth: CGFloat = 0

//    func useGetMaxTextWidth() {
//        for string in strings {
//            Text(string)
//                .lineLimit(1)
//                .font(.system(size: 50))
//                .getMaxTextWidth(maxWidth: $maxTextWidth)
//        }
//    }
    
    
    
    var body: some View {
//        useGetMaxTextWidth()
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct _Sample_instanceView_Previews: PreviewProvider {
    static var previews: some View {
        _Sample_instanceView()
    }
}
