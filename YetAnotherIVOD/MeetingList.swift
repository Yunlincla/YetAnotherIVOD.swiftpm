//
//  MeetingList.swift
//  YetAnotherIVOD
//
//  Created by Yunlincla on 2024/10/15.
//

import SwiftUI
import LYFetcher

/// 最新會議列表
struct MeetingList: View {
    @State var searchText = ""
    @State var meetingList: [FullMeetingVideo]?
    @Binding var selectedVideo: FullMeetingVideo?
    var body: some View {
        LoadableView(value: $meetingList, loader: FetchNewestMeeting) { list in
            List(selection: $selectedVideo) {
                ForEach(list, id: \.self) { meeting in
                    Cell(meeting: meeting)
                }
            }
        }
        .navigationTitle("會議完整影片")
        .searchable(text: $searchText)
    }
    
    func Cell(meeting: FullMeetingVideo) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(meeting.meetingTypeName) // 會議類型
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            Text("\(meeting.meetingDate)  \(meeting.meetingTime)")
                .foregroundStyle(.tertiary)
            Text(meeting.meetingContent)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 5)
    }
}

#Preview {
    NavigationStack {
        MeetingList(selectedVideo: Binding<FullMeetingVideo?>.constant(nil))
    }
#if os(macOS)
    .frame(width: 400, height: 600)
#endif
}
