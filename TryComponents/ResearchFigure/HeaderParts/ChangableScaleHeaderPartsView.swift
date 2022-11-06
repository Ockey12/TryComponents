//
//  ChangableScaleHeaderPartsView.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/09/26.
//

import SwiftUI

struct ChangableScaleHeaderPartsView: View {
    
    @State private var ratio: CGFloat = 1.0
    @State private var with: CGFloat = 600
    
    var body: some View {
        ZStack {
//            HeaderPartsView(width: with)
//                .scaleEffect(ratio)
            
            VStack {
                Spacer()
                Text("拡大率:\(ratio, specifier: "%.2f")")
                Slider(value: $ratio, in: -3.0...5.0)
                
                Divider()
                
                Text("with:\(with)")
                Slider(value: $with, in: 300...1500)
            }
            .padding()
        }
        .frame(width: 1800, height: 1000)
    }
}

struct ChangableScaleHeaderPartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChangableScaleHeaderPartsView()
    }
}
