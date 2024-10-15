//
//  LoadableView.swift
//  YetAnotherIVOD
//
//  Created by Yunlincla on 2024/10/11.
//

import SwiftUI
import LYFetcher

struct LoadableView<Value, Content>: View where Content: View {
    @Binding var value: Value?
    var loader: () async throws -> Value
    var content: (Value) -> Content
    @State private var isError = false
    
    var body: some View {
        if let value {
            content(value)
        } else {
            if !isError {
                ProgressView("加載中")
                    .onAppear(perform: Load)
            } else {
                VStack {
                    ContentUnavailableView("連線錯誤", systemImage: "network.slash", description: Text("請檢查網路連線！\n若此問題持續發生，請聯絡開發者！"))
                    Button("點我嘗試重新整理", action: Load)
                        .padding()
                    // 提示使用者缺乏網路連線
                    // 或解析錯誤，請聯絡開發者
                }
            }
        }
    }
    
    func Load() {
        isError = false
        Task {
            do {
                value = try await loader()
                isError = false
            } catch {
                isError = true
            }
        }
    }
}

#Preview("LoadableView") {
    MeetingList(selectedVideo: .constant(nil))
#if os(macOS)
        .frame(width: 400, height: 400)
#endif
}
