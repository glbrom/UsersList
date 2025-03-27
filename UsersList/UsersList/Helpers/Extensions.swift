//
//  Extensions.swift
//  UsersList
//
//  Created by Roman Golub on 25.03.2025.
//

import SwiftUI

extension View {
    func backgroundGradient() -> some View {
        self.background(
            LinearGradient(
                colors: [.bgColorBottom, .bgColorTop],
                startPoint: .bottom,
                endPoint: UnitPoint(x: 0.4, y: -0.4)
            )
        )
    }
}

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
