//
//  LevelLogTestPlan.swift
//  
//
//  Created by JeongHyun Kim on 2/7/24.
//

import XCTest
@testable import LevelOSLog

final class LevelLogTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        Log.debug  ("Message", 1)
        Log.info   ("Message", 2)
        Log.network("Message", 3)
        Log.error  ("Message", 4)
        Log.fault  ("Message", 5)
    }
    
    func testFilterSet() throws {
        LLog.shared.changeLevel(levels: [.debug,.network])
        Log.debug  ("Filter Message", 1)
        Log.info   ("Filter Message", 2)
        Log.network("Filter Message", 3)
        Log.error  ("Filter Message", 4)
        Log.fault  ("Filter Message", 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
