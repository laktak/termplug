import AppKit
import AVKit
import Combine
import Foundation
import SwiftUI

let videoExtensions = ["mov", "mp4"]
let imageExtensions = ["heic", "png", "jpg", "jpeg", "tif", "tiff", "gif", "pdf"]

struct ContentView: View {
    @State var playVid = false
    @State var showAny = false
    @State var image: NSImage?
    let playerView = PlayerView()
    @State var anyView: AnyView?

    private let openFile = NotificationCenter.default.publisher(for: .openFile)

    var body: some View {
        VStack {
            if playVid {
                playerView
            } else if image != nil {
                // white is required for the PDF background
                Image(nsImage: image!).resizable().aspectRatio(contentMode: .fit).background(Color.white)
            } else if showAny {
                anyView
            } else {
                Text("TermPlug")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
        }.onReceive(openFile) { notification in

            if playVid {
                playerView.player.pause()
            }
            showAny = false
            playVid = false
            image = nil

            if let url = notification.object as? URL {
                if videoExtensions.contains(url.pathExtension.lowercased()) {
                    playVid = true
                    playerView.player.replaceCurrentItem(with: AVPlayerItem(url: url))
                    playerView.player.play()
                } else if imageExtensions.contains(url.pathExtension.lowercased()) {
                    image = NSImage(contentsOf: url)
                } else {
                    if anyView == nil {
                        anyView = AnyView()
                    }
                    showAny = true
                    anyView!.ql.previewItem = AnyPreviewItem(file: url, title: url.lastPathComponent)
                }
            }

            if !showAny, anyView != nil {
                // if we don't close the view it will crash with
                // internalState != QLPreviewDeactivatedInternalState
                anyView!.ql.close()
                anyView = nil
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
