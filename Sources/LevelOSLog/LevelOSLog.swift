
import Foundation
import OSLog
import os.log
/**
로그를 선택적으로 보여 주기 위해서 Level 을 적용해서 어떤 Level만 보일지를 설정해 줄 수 있습니다.
 다만 싱글턴을 하나 갖어야 한다는 점 떄문에 사용되지 안을것 같네요....
 기본 시스템 로그만 가져 갈지는 실무에서 써보면서 결정하겠습니다.
 **/

extension OSLog {
    static let subsystem = Bundle.main.bundleIdentifier!
    static let network = OSLog(subsystem: subsystem, category: "Network")
    static let debug = OSLog(subsystem: subsystem, category: "Debug")
    static let info = OSLog(subsystem: subsystem, category: "Info")
    static let error = OSLog(subsystem: subsystem, category: "Error")
    static let fault = OSLog(subsystem: subsystem, category: "Fault")
}

///  Display Level을 설정하기 위해서 어쩔수 없이 만든 부분인데
///  어쩌면 계륵 같아서 안 쓰게 될것 같습니다.
///   시스템의 설정 뿐아니라 로그의 레벨을 직접 적용하는게 목적이여서 진행해 봤습니다.
///   기본 값을 다 설정하도록 만들겠습니다.
open class LLog {

    public static let `shared` = LLog()
    /// Log를 보여줄 코드적인 레벨 기본값을 다 보여주는 All로 잡음
    fileprivate var logLevel: [Log.Level] = [.debug,.info,.network,.error,.fault]
    
    /// 개발자 로그 Filter를 위한 설정.
    /// - Parameter levels: Log.level을 Array로 전달한다 포함된 로그 카테고리만 표시 된다. 
    public func changeLevel(levels: [Log.Level]) {
        logLevel = levels
    }
}

public struct Log {
    public enum Level {
        case debug
        case info
        case network
        case error
        case fault
        
        /// 설정한 레벨 만 보임 : logLevel에 설정한 Level만 보임
        public var name: String {
            switch self {
            case .debug:   return "Debug"
            case .info:    return "Info"
            case .network: return "Network"
            case .error:   return "Error"
            case .fault:   return "fault"
            }
        }
        

        fileprivate var category: String {
            switch self {
            case .debug:
                return "🔵"
            case .info:
                return "⚪️"
            case .network:
                return "🟢"
            case .error:
                return "🔴"
            case .fault:
                return "🔴"
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
            }
        }
    }

    
    static private func log(_ message: Any,
                            _ arguments: [Any],
                            _ file: String = #fileID,
                            _ function: String = #function,
                            _ line: UInt = #line,
                            level: Level) {
        #if DEBUG
        if #available(iOS 14.0, *) {
            let logger = Logger(subsystem: OSLog.subsystem, category: level.name)
            let objects: String = arguments.map({ String(describing: $0) }).joined(separator: " ")
            let fileName = (file.split(separator:"/").last ?? "").split(separator: ".").first ?? ""
            let prefix = "\(fileName) \(function) (\(line))"
            let logMessage = "[\(level.category) \(prefix)]: \(message) \(objects)"
            switch level {
            case .debug:
                logger.debug("\(logMessage, privacy: .public)")
            case .info:
                logger.info("\(logMessage, privacy: .public)")
            case .network:
                logger.log("\(logMessage, privacy: .public)")
            case .error:
                logger.error("\(logMessage, privacy: .public)")
            case .fault:
                logger.error("\(logMessage, privacy: .public)")
            }
        } else {
            let extraMessage: String = arguments.map({ String(describing: $0) }).joined(separator: " ")
            os_log("%{public}@", log: level.osLog, type: level.osLogType, "\(message) \(extraMessage)")
        }
        #endif
    }
}

extension Log {
    public static func debug(_ message: Any,
                             _ arguments: Any...,
                             endArgument end: String = "",
                             _ file: String = #file,
                             _ function: String = #function,
                             _ line: UInt = #line
                            ) {
        guard LLog.shared.logLevel.contains(.debug) else { return }
        log(message, arguments, file, function, line, level: .debug)
    }

    public static func info(_ message: Any,
                            _ arguments: Any...,
                            endArgument end: String = "",
                            _ file: String = #file,
                            _ function: String = #function,
                            _ line: UInt = #line
                           ) {
        guard LLog.shared.logLevel.contains(.info) else { return }
        log(message, arguments, file, function, line, level: .info)
    }

    public static func network(_ message: Any,
                               _ arguments: Any...,
                               endArgument end: String = "",
                               _ file: String = #file,
                               _ function: String = #function,
                               _ line: UInt = #line
                              ) {
        guard LLog.shared.logLevel.contains(.network) else { return }
        log(message, arguments, file, function, line, level: .network)
    }

    public static func error(_ message: Any,
                             _ arguments: Any...,
                             endArgument end: String = "",
                             _ file: String = #file,
                             _ function: String = #function,
                             _ line: UInt = #line
                            ) {
        guard LLog.shared.logLevel.contains(.error) else { return }
        log(message, arguments, file, function, line, level: .error)
    }
    public static func fault(_ message: Any,
                             _ arguments: Any...,
                             endArgument end: String = "",
                             _ file: String = #file,
                             _ function: String = #function,
                             _ line: UInt = #line
                            ) {
        guard LLog.shared.logLevel.contains(.fault) else { return }
        log(message, arguments, file, function, line, level: .fault)
    }
}


