import SwiftUI

@main
struct midtermApp: App {
    @StateObject var dataStore = DataStore()
    var body: some Scene {
        WindowGroup {
            TabContainer()
        }
    }
}
