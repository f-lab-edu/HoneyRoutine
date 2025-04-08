//
//  Feature.swift
//  Config
//
//  Created by JUNHEE JO on 4/1/25.
//

import ProjectDescription

let featureTemplate = Template(
    description: "Feature module scaffold",
    attributes: [.required("name")],
    items: [
        .file(
            path: "Feature/{{ name }}/Project.swift",
            templatePath: "project.stencil"
        ),
        .file(
            path: "Feature/{{ name }}/Sources/Interface/{{ name }}Interface.swift",
            templatePath: "FeatureModuleFile.swift"
        ),
        .file(
            path: "Feature/{{ name }}/Sources/Implementation/{{ name }}Implementation.swift",
            templatePath: "FeatureModuleFile.swift"
        ),
        .file(
            path: "Feature/{{ name }}/Resources/Assets.xcassets/Contents.json",
            templatePath: "AssetsContents.json"
        ),
        .file(
            path: "Feature/{{ name }}/Tests/UnitTests/{{ name }}Tests.swift",
            templatePath: "FeatureModuleFile.swift"
        ),
        .file(
            path: "Feature/{{ name }}/Tests/SnapshotTests/{{ name }}SnapshotTests.swift",
            templatePath: "FeatureModuleFile.swift"
        ),
        .file(
            path: "Feature/{{ name }}/Tests/Testing/{{ name }}Testing.swift",
            templatePath: "FeatureModuleFile.swift"
        )
    ]
)
