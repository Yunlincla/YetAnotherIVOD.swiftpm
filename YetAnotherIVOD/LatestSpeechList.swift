//
//  LatestSpeechList.swift
//  YetAnotherIVOD
//
//  Created by Yunlincla on 2024/10/11.
//

import SwiftUI
import LYFetcher

/// 最新委員發言列表
struct LatestSpeechList: View {
    @State var searchText = ""
    @State var speechList: [LegislatorSpeech]?
    @Binding var selectedVideo: LegislatorSpeech?
    var body: some View {
        LoadableView(value: $speechList, loader: FetchNewestSpeech) { list in
            List(selection: $selectedVideo) {
                ForEach(list, id: \.self) { speech in
                    Cell(speech: speech)
                }
            }
        }
        .navigationTitle("最新委員發言片段")
        .searchable(text: $searchText)
    }
    
    func Cell(speech: LegislatorSpeech) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(speech.meetingTypeName) // 會議類型
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text("委員：\(speech.legislatorName)") // 委員名稱
            }
            Text("\(speech.meetingDate)  \(speech.meetingTime)")
                .foregroundStyle(.tertiary)
            Text(speech.meetingContent)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 5)
    }
}

#Preview("LatestSpeechList") {
    NavigationStack {
        LatestSpeechList(selectedVideo: .constant(GetExample.GetLegislatorSpeech()))
    }
#if os(macOS)
    .frame(width: 400, height: 600)
#endif
}
