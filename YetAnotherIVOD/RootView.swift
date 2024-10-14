//
//  ContentView.swift
//  YetAnotherIVOD
//
//  Created by Yunlincla on 2024/10/6.
//

import SwiftUI
import LYFetcher

struct RootView: View {
    @State var searchLegislatorText: String = ""
    @State var sideBarSelection: SideBarSelection? = .Latest
    enum SideBarSelection: Hashable {
        // 最新、個別委員、院會、黨團、各大委員會
        // list.bullet.indent -> 程序委員會
        case Latest
//        case Legislators
        case Meeting
    }
    @State var selectedSpeechVideo: LegislatorSpeech?
    @State var selectedMeetingVideo: FullMeetingVideo?
    
    var body: some View {
        NavigationSplitView(sidebar: SideBar, content: Content, detail: Detail)
    }
    
    /// 側邊欄
    func SideBar() -> some View {
        List(selection: $sideBarSelection) {
            NavigationLink(value: SideBarSelection.Latest) {
                Label("最新發言片段", systemImage: "sparkles")
            }
            NavigationLink(value: SideBarSelection.Meeting) {
                Label("會議", systemImage: "person.2.fill")
            }
        }
    }
    
    /// 影片列表
    func Content() -> some View {
        Group {
            switch(sideBarSelection) {
            default:
                LatestSpeechList(selectedVideo: $selectedSpeechVideo)
            }
        }
#if os(iOS)
        .listStyle(.insetGrouped)
#endif
    }
    
    /// 播放器
    @ViewBuilder func Detail() -> some View {
        switch(sideBarSelection) {
        case .Meeting:
            VideoView(selectedVideo: selectedMeetingVideo)
        default:
            VideoView(selectedVideo: selectedSpeechVideo)
        }
    }
}

#Preview("RootView") {
    RootView()
}
