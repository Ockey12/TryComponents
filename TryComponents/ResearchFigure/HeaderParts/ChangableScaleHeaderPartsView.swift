//
//  ChangableScaleHeaderPartsView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/26.
//

import SwiftUI

struct ChangableScaleHeaderPartsView: View {
    
    @State private var ratio: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            HeaderPartsView()
                .scaleEffect(ratio)
            
            VStack {
                Spacer()
                Text("拡大率:\(ratio, specifier: "%.2f")")
                Slider(value: $ratio, in: -3.0...5.0)
            }
            .padding()
        }
        .frame(width: 1000, height: 1000)
    }
}

struct ChangableScaleHeaderPartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChangableScaleHeaderPartsView()
    }
}
