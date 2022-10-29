//
//  ChangelableScaleTypeView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/29.
//

import SwiftUI

struct ChangelableScaleTypeView: View {
    @State private var ratio: CGFloat = 1.0
    var body: some View {
        VStack {
            ScrollView {
                TypeView()
                    .scaleEffect(ratio)
                    .frame(width: 1254*ratio, height: 1740*ratio)
            }
            
            VStack {
                Text("拡大率:\(ratio, specifier: "%.2f")")
                Slider(value: $ratio, in: 0...10.0)
            }
            .padding()
        }
        .frame(minWidth: 1000, maxWidth: .infinity, minHeight: 1000, maxHeight: .infinity)
    }
}

struct ChangelableScaleTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ChangelableScaleTypeView()
    }
}
