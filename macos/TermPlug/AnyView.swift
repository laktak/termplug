import AppKit
import AVFoundation
import AVKit
import Cocoa
import Quartz
import SwiftUI

struct AnyView: NSViewRepresentable {
    let ql: QLPreviewView

    init() {
        ql = QLPreviewView()
    }

    func updateNSView(_: QLPreviewView, context _: NSViewRepresentableContext<Self>) {}

    func makeNSView(context _: NSViewRepresentableContext<Self>) -> QLPreviewView {
        ql
    }
}

class AnyPreviewItem: NSObject, QLPreviewItem {
    let previewItemURL: URL
    let previewItemTitle: String?

    init(file: URL, title: String?) {
        previewItemURL = file
        previewItemTitle = title
    }
}
