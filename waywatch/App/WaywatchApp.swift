import SwiftUI
import SwiftData

@main struct WaywatchApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .tint(Waywatch.Palette.primary)
        }
        .modelContainer(for: LibraryItem.self)
    }
}
