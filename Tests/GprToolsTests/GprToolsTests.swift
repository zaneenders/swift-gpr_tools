import Testing
import Foundation
@testable import GprTools

@Suite("GprTools")
struct GprToolsTests {
    @Test("version string is non-empty")
    func versionNotEmpty() {
        #expect(!GprTools.version.isEmpty)
    }
}
