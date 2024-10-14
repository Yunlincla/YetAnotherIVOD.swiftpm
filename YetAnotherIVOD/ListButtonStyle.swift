//
//  ListButtonStyle.swift
//  YetAnotherIVOD
//
//  Created by Yunlincla on 2024/10/11.
//

import Foundation
import SwiftUI

struct ListButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.5 : 1)
            .contentShape(Rectangle())
    }
}

#Preview("ListButtonStyle") {
    Button(action: { print("Pressed") }) {
        Text("ListButton")
            .padding()
    }
    .buttonStyle(ListButtonStyle())
}
