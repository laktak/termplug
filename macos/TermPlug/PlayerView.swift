import AppKit
import AVFoundation
import AVKit
import Combine
import Foundation
import SwiftUI

struct PlayerView: NSViewRepresentable {
    let player: AVPlayer

    init() {
        player = AVPlayer()
    }

    func updateNSView(_: AVPlayerView, context _: NSViewRepresentableContext<Self>) {}

    func makeNSView(context _: NSViewRepresentableContext<Self>) -> AVPlayerView {
        let playerView = AVPlayerView(frame: .zero)
        playerView.player = player
        return playerView
    }
}
