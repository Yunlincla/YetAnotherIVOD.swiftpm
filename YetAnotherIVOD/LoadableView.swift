//
//  LoadableView.swift
//  YetAnotherIVOD
//
//  Created by Yunlincla on 2024/10/11.
//

import SwiftUI

struct LoadableView<Value, Content>: View where Content: View {
    @Binding var value: Value?
    var loader: () async -> Value
    var content: (Value) -> Content
    var body: some View {
        if let value {
            content(value)
        } else {
            ProgressView("加載中")
                .onAppear {
                    Task {
                        value = await loader()
                    }
                }
        }
    }
}

private struct TestLoadableView: View {
    @State var str: String?
    var body: some View {
        LoadableView(value: $str, loader: Loader) {
            Text($0)
        }
    }
    
    func Loader() -> String {
        return "!"
    }
}

#Preview("LoadableView") {
    TestLoadableView()
}
