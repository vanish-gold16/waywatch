import SwiftUI
import SwiftData

@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(Waywatch.Palette.primary)
        }
        .modelContainer(for: WatchlistItem.self)
    }
}
