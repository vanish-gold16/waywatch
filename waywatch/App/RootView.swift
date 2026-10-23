import SwiftUI
import Playgrounds

struct RootView: View {
       
    @State private var selectedTab: AppTab = .search
    @State private var libraryPath: NavigationPath = .init()
    @State private var searchPath: NavigationPath = .init()
    
    var body: some View {
        tabs
    }
    
    private var tabs: some View {
        TabView(selection: $selectedTab) {
            SwiftUI.Tab("Library", systemImage: "film.stack", value: AppTab.library) {
                LibraryView()
            }
            SwiftUI.Tab(value: AppTab.search, role: .search) {
                SearchView()
            }
        }
        .tint(Waywatch.Palette.textPrimary)
    }
}

enum AppTab: Hashable {
    case search, library
}

#Preview {
    RootView()
}
