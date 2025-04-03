//
//  ModuleFactory.swift
//  Config
//
//  Created by JUNHEE JO on 3/27/25.
//

import ProjectDescription

public extension Project {
    static func makeModule(
        name: String,
        moduleLayer: ModuleLayer,
        targets: [ModuleTarget],
        dependencies: [ModuleTarget: [TargetDependency]] = [:],
        infoPlists: [ModuleTarget: InfoPlist] = [:],
        resources: [ModuleTarget: ResourceFileElements] = [:],
        scripts: [ModuleTarget: [TargetScript]] = [:],
        settings: [ModuleTarget: Settings] = [:],
        schemes: [Scheme] = []
    ) -> Project {
        let baseBundleId = "com.beepeach.honeyroutine.\(moduleLayer).\(name.lowercased())"

        let projectTargets: [Target] = targets.map { targetType in
            Target.target(
                name: "\(name)\(targetType.nameSuffix)",
                destinations: .iOS,
                product: targetType.product,
                productName: targetType.productName(for: name),
                bundleId: "\(baseBundleId).\(targetType.nameSuffix.lowercased())",
                deploymentTargets: .iOS("17.0"),
                infoPlist: infoPlists[targetType] ?? .default,
                sources: targetType.sources,
                resources: resources[targetType],
                scripts: scripts[targetType] ?? [],
                dependencies: dependencies[targetType] ?? [],
                settings: settings[targetType]
            )
        }

        return Project(name: name, targets: projectTargets, schemes: schemes)
    }
}
