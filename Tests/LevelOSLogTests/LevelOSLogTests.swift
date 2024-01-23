import XCTest
import OSLog
@testable import LevelOSLog

final class LevelOSLogTests: XCTestCase {
    func testExample() throws {
//        LLog.shared.logLevel = [.debug,.network]
        Log.debug("Message", 1)
        Log.info("Message ", 2)
        Log.network("Message", 3)
        Log.error("Message", 4)
        Log.fault("Messaage", 5)
    }
}
