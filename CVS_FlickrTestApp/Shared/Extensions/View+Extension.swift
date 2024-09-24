//
//  View+Extension.swift
//  CVS_FlickrTestApp
//
//  Created by Igor Chernobai on 9/24/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func onlyIf(_ condition: Bool) -> some View {
        if condition {
            self
        } else {
            EmptyView()
        }
    }
}

enum AlignmentPreferrence {
    case top, bottom, center, leading, trailing
}

extension View {
    @ViewBuilder
    func align(by side: AlignmentPreferrence) -> some View {
        switch side {
        case .top:
            self.frame(maxHeight: .infinity, alignment: .top)
        case .bottom:
            self.frame(maxHeight: .infinity, alignment: .bottom)
        case .center:
            self.frame(maxWidth: .infinity, alignment: .center)
        case .leading:
            self.frame(maxWidth: .infinity, alignment: .leading)
        case .trailing:
            self.frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
