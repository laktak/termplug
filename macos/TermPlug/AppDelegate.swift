
import Cocoa
import SwiftUI

var has_window = false
var window: NSWindow!

extension Notification.Name {
    static let openFile = Notification.Name("open_file")
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func application(_: NSApplication, openFile filename: String) -> Bool {
        openFile(url: URL(fileURLWithPath: filename))
        return true
    }

    func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool {
        true
    }

    @IBAction func openDocument(_sender _: NSMenuItem) {
        let panel = NSOpenPanel()
        let result = panel.runModal()
        if result == .OK {
            openFile(url: panel.url!)
        }
    }

    func applicationDidFinishLaunching(_: Notification) {
        _ = init_window()
    }

    func applicationWillTerminate(_: Notification) {}
}

func init_window() -> ContentView? {
    if has_window == false {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 2000, height: 3000),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false
        )
        window.level = NSWindow.Level.floating
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(true)

        has_window = true

        return contentView
    } else {
        return nil
    }
}

func openFile(url: URL) {
    if let view = init_window() {
        // neither viewFile nor posting immediately will show the first image
        // so we use a timer for now
        // view.viewFile(object: url)
        let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) {
            _ in
            NotificationCenter.default.post(name: .openFile, object: url)
        }
    } else {
        NotificationCenter.default.post(name: .openFile, object: url)
    }

    window.title = String(url.lastPathComponent)
}
