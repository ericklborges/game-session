import SwiftUI

@main
struct GameSessionApp: App {

    init() {
        CoreDataStore.shared.loadStore()
    }

    var body: some Scene {
        WindowGroup {
            CounterView()
        }
    }
}
