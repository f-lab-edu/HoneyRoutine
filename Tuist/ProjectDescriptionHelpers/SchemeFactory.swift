//
//  SchemeFactory.swift
//  ProjectDescriptionHelpers
//
//  Created by JUNHEE JO on 4/3/25.
//

import Foundation
import ProjectDescription

// TODO: 파라미터를 String에서 변경하는것을 고려해보는게 좋습니다.
public enum SchemeFactory {
    public static func makeDev(name: String, mainTarget: String, testTarget: String? = nil) -> Scheme {
        Scheme.scheme(
            name: "\(name)-Dev",
            shared: true,
            buildAction: .buildAction(targets: [TargetReference(stringLiteral: mainTarget)]),
            testAction:  {
                guard let testTarget else { return nil }
                return .targets(
                    [TestableTarget(stringLiteral: testTarget)],
                    configuration: .debug
                )
            }(),
            runAction: .runAction(
                configuration: .debug,
                executable: TargetReference(stringLiteral: mainTarget)
            )
        )
    }

    public static func makeRelease(name: String, mainTarget: String) -> Scheme {
        Scheme.scheme(
            name: "\(name)",
            shared: true,
            buildAction: .buildAction(targets: [TargetReference(stringLiteral: mainTarget)]),
            runAction: .runAction(
                configuration: .release,
                executable: TargetReference(stringLiteral: mainTarget)
            )
        )
    }
}
