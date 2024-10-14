//
//  VideoView.swift
//  YetAnotherIVOD
//
//  Created by Yunlincla on 2024/10/12.
//

import SwiftUI
import AVKit
import LYFetcher

struct VideoView<Video>: View where Video: VideoInfo {
    var selectedVideo: Video?
    @State private var player: AVPlayer?
    
    var body: some View {
        let _ = Self._printChanges()
        if let selectedVideo {
            Content(selectedVideo)
        } else {
            ContentUnavailableView("請先選擇影片", systemImage: "questionmark.circle")
        }
    }
    
    func Content(_ selectedVideo: Video) -> some View {
        NavigationStack {
            VideoPlayer(player: player)
                .aspectRatio(16/9, contentMode: .fit)
                .padding()
                .shadow(radius: 5)
                .onAppear {
                    FetchData(video: selectedVideo)
                }
                .onChange(of: selectedVideo) {
                    FetchData(video: selectedVideo)
                }
            Spacer()
            Text("\(selectedVideo.meetingDate) \(selectedVideo.meetingTypeName)")
        }
        .navigationTitle("\(selectedVideo.meetingDate)  \(selectedVideo.meetingTypeName)")
        .toolbarTitleDisplayMode(.inline)
    }
    
    func FetchData(video: some VideoInfo) {
        Task {
            print("FetchingData......")
            player = AVPlayer(url: await ParseIvodURL(url: URL(string: video.videoUrl)!))
        }
    }
}

#Preview {
    VideoView(selectedVideo: GetExample.GetLegislatorSpeech())
        .frame(width: 500, height: 400)
}
