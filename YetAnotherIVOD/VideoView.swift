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
    private var player = AVPlayer()
    @State private var playerItem: AVPlayerItem? = nil
    @State private var isPresentedWarning = false
    @State private var errorMessage = ""
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
            do {
                player.replaceCurrentItem(with: AVPlayerItem(url: try await ParseIvodURL(url: URL(string: video.videoUrl)!)))
            } catch let error as FetchDataError {
                switch(error) {
                case .urlFetchingError:
                    errorMessage = "連線錯誤！請檢察網路連線是否正常！\n若此情況持續發生，請聯絡開發者！"
                default:
                    errorMessage = "解析影片位址時發生錯誤，請聯絡開發者！"
                }
                player.replaceCurrentItem(with: nil)
            }
        }
    }
    
    init(selectedVideo: Video? = nil) {
        self.selectedVideo = selectedVideo
    }
}

// 241015: 目前會遇到VideoPlayer無法正常預覽的情況。
#Preview {
    VideoView<LegislatorSpeech>(selectedVideo: GetExample.GetLegislatorSpeech())
        .frame(width: 500, height: 400)
}
