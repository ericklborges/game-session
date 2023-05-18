import Database_iOS
import SwiftUI

@main
struct GameSessionApp: App {

    init() {
        CoreDataStore.shared.loadStore()
    }

    var body: some Scene {
        WindowGroup {
            CounterListView()
        }
    }
}
