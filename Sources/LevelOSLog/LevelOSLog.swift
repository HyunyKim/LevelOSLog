
import Foundation
import OSLog
import os.log
/**
로그를 선택적으로 보여 주기 위해서 Level 을 적용해서 어떤 Level만 보일지를 설정해 줄 수 있습니다.
 **/

extension OSLog {
    static let subsystem = Bundle.main.bundleIdentifier!
    static let network = OSLog(subsystem: subsystem, category: "Network")
    static let debug = OSLog(subsystem: subsystem, category: "Debug")
    static let info = OSLog(subsystem: subsystem, category: "Info")
    static let error = OSLog(subsystem: subsystem, category: "Error")
    static let fault = OSLog(subsystem: subsystem, category: "Fault")
}

public struct Log {
    /// 설정한 레벨 만 보임 : logLevel에 설정한 Level만 보임
    enum LevelValue : Int{
        case debug
        case custom
        case info
        case network
        case error
        case fault
    }
    /// Log를 보여줄 코드적인 레벨 기본값을 다 보여주는 All로 잡음
    static private var logLevel: [LevelValue] = [ .network, .debug, .custom, .info, .error, .fault]
    static func changeLogLevel(levels: [LevelValue]) {
        Log.logLevel = levels
    }
    enum Level {
        case debug
        case info
        case network
        case error
        case fault
        case custom(category: String)
        

        fileprivate var category: String {
            switch self {
            case .debug:
                return "[🟡Debug]"
            case .info:
                return "[🟠Info]"
            case .network:
                return "[🔵Network]"
            case .error:
                return "[🔴Error]"
            case .fault:
                return "[🔴Fault]"
            case .custom(let category):
                return "⚪️\(category)"
            }
        }

        fileprivate var osLog: OSLog {
            switch self {
            case .debug:
                return OSLog.debug
            case .info:
                return OSLog.info
            case .network:
                return OSLog.network
            case .error:
                return OSLog.error
            case .fault:
                return OSLog.fault
            case .custom:
                return OSLog.debug
            }
        }

        fileprivate var osLogType: OSLogType {
            switch self {
            case .debug:
                return .debug
            case .info:
                return .info
            case .network:
                return .default
            case .error:
                return .error
            case .fault:
                return .fault
            case .custom:
                return .debug
            }
        }
    }

    
    static private func log(_ message: Any, _ arguments: [Any], level: Level) {
        #if DEBUG
        let extraMessage: String = arguments.map({ String(describing: $0) }).joined(separator: " ")
        if #available(iOS 14.0, *) {
            
            let logger = Logger(subsystem: OSLog.subsystem, category: level.category)
            let logMessage = "\(message) \(extraMessage)"
            switch level {
            case .debug,
                 .custom:
                logger.debug("\(logMessage, privacy: .public)")
            case .info:
                logger.info("\(logMessage, privacy: .public)")
            case .network:
                logger.log("\(logMessage, privacy: .public)")
            case .error:
                logger.error("\(logMessage, privacy: .public)")
            case .fault:
                logger.fault("\(logMessage, privacy: .public)")
            }
        } else {
            os_log("%{public}@", log: level.osLog, type: level.osLogType, "\(message) \(extraMessage)")
        }
        #endif
    }
}

extension Log {
    public static func debug(_ message: Any, _ arguments: Any...) {
        guard logLevel.contains(.debug) else { return }
        log(message, arguments, level: .debug)
    }

    public static func info(_ message: Any, _ arguments: Any...) {
        guard logLevel.contains(.info) else { return }
        log(message, arguments, level: .info)
    }

    public static func network(_ message: Any, _ arguments: Any...) {
        guard logLevel.contains(.network) else { return }
        log(message, arguments, level: .network)
    }

    public static func error(_ message: Any, _ arguments: Any...) {
        guard logLevel.contains(.error) else { return }
        log(message, arguments, level: .error)
    }
    public static func fault(_ message: Any, _ arguments: Any...) {
        guard logLevel.contains(.fault) else { return }
        log(message, arguments,level: .fault)
    }

    public static func custom(category: String, _ message: Any, _ arguments: Any...) {
        guard logLevel.contains(.custom) else { return }
        log(message, arguments, level: .custom(category: category))
    }
    
}


