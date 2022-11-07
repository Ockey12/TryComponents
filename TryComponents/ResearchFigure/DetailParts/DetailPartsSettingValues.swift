//
//  PropertyFrameSettingValues.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/10/05.
//

import Foundation

struct DetailPartsSettingValues {
    static let minWidth: CGFloat = 600
    static let connectionWidth: CGFloat = 350
    static let connectionHeight: CGFloat = 90
    static let itemHeight: CGFloat = 90
    static var oneVerticalLineWithoutArrow: CGFloat {
        (self.itemHeight - self.arrowTerminalHeight)/2
    }
    static let arrowTerminalWidth: CGFloat = 15
    static let arrowTerminalHeight: CGFloat = 30
    static let bottomPaddingForLastText: CGFloat = 30
    static let textLeadingPadding: CGFloat = 30
    static let textTrailPadding: CGFloat = 0
    static let borderWidth: CGFloat = 5
}
