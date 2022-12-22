//
//  GetTextWidthView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/12/14.
//

import SwiftUI

struct GetTextWidthView: View {
    var strings: [String]
    @Binding var maxWidth: Double
    @State private var textSize: CGSize = CGSize()
    
    var body: some View {
        VStack {
            ForEach(strings, id: \.self) { string in
                Text(string)
                    .background(.pink)
                    .background() {
                        GeometryReader { geometry in
                            Path { path in
                                let width = geometry.size.width
                                DispatchQueue.main.async {
                                    if maxWidth < width {
                                        maxWidth = width
                                    }
                                }
                            } // Path
                        } // GeometryReader
                    } // .background()
            } // ForEach(strings, id: \.self)
            
//            Text("Hello, Swift!")
//                .padding()
//                .background(Color.pink)
//                .background() {
//                    GeometryReader { geometry in
//                        Path { path in
//                            let size = geometry.size
//                            DispatchQueue.main.async {
//                                if self.textSize != size {
//                                    self.textSize = size
//                                }
//                            }
//                        }
//                    }
//                } // .background()
//
//            Text("")
//                .frame(width: textSize.width, height: textSize.height)
//                .background(.clear)
//                .foregroundColor(.clear)
//                .border(.green)
//
//            Text("Text Size: \(String(format: "%.0f x %.0f", textSize.width, textSize.height))")
            
        } // VStack
    }
}

//struct GetTextWidthView_Previews: PreviewProvider {
//    static var previews: some View {
//        GetTextWidthView(["aaa", "bbbbbb", "ccccccccc", "dddddd", "eee"])
//    }
//}
