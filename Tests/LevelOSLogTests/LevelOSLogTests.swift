import XCTest
import OSLog
@testable import LevelOSLog

final class LevelOSLogTests: XCTestCase {
    func testExample() throws {
//        LLog.shared.logLevel = [.debug,.network]
        Log.debug("DebugMessage", 1)
        Log.info("Info Mesage ", 2)
        Log.network("Nework Message", 3)
        Log.error("Error Message", 4)
        Log.fault("Fault Messaage", 5)
        Log.custom(category: "LLogCustom", "Custom Message", 6)
    }
}
