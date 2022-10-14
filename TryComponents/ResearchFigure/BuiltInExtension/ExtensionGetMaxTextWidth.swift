//
//  ExtensionGetMaxTextWidth.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/06.
//

import SwiftUI

extension View {
    func getMaxTextWidth(maxWidth: Binding<CGFloat>) -> some View {
        background(GeometryReader { geometry -> Color in
            if maxWidth.wrappedValue < geometry.size.width {
                DispatchQueue.main.async {
                    maxWidth.wrappedValue = geometry.size.width
                }
            }
            return Color.clear
        })
    }
}
