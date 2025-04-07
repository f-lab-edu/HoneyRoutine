//
//  ModuleTargetType.swift
//  ProjectDescriptionHelpers
//
//  Created by JUNHEE JO on 4/1/25.
//

import Foundation
import ProjectDescription

/// 모듈에서 생성될 세부 타겟 유형을 정의하는 열거형입니다.
public enum ModuleTarget {
    /// 실행 가능한 앱 타겟 (App의 진입점)
    case app

    /// 외부 모듈에서 참조할 수 있는 인터페이스 (예: 프로토콜, DTO 등)
    case interface

    /// 기능의 실제 구현 로직을 담는 타겟
    case implementation

    /// 기능을 독립적으로 실행하거나 테스트하기 위한 데모 앱 타겟
    case demo

    /// 구현 타겟에 대한 단위 테스트 타겟
    case tests

    /// 스냅샷 기반의 UI 테스트 타겟
    case snapshotTests

    /// 테스트에서 사용되는 mock, stub 등을 포함한 테스트 헬퍼 타겟
    case testing

    public var product: Product {
        switch self {
        case .app, .demo:
            return .app
        case .interface, .implementation, .testing:
            return .framework
        case .tests, .snapshotTests:
            return .unitTests
        }
    }

    public func productName(for moduleName: String) -> String? {
        switch self {
        case .app, .implementation:
            return moduleName
        case .demo:
            return "\(moduleName)Demo"
        default:
            return nil
        }
    }

    public var sources: SourceFilesList {
        switch self {
        case .app:
            return "Sources/**"
        case .interface:
            return "Sources/Interface/**"
        case .implementation:
            return "Sources/Implementation/**"
        case .demo:
            return "Sources/Demo/**"
        case .tests:
            return "Tests/UnitTests/**"
        case .snapshotTests:
            return "Tests/SnapshotTests/**"
        case .testing:
            return "Tests/Testing/**"
        }
    }

    public var nameSuffix: String {
        switch self {
        case .app: return ""
        case .interface: return "Interface"
        case .implementation: return "Implementation"
        case .demo: return "Demo"
        case .tests: return "Tests"
        case .snapshotTests: return "SnapshotTests"
        case .testing: return "Testing"
        }
    }
}
