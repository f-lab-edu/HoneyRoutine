//
//  Shared.swift
//  Config
//
//  Created by JUNHEE JO on 4/1/25.
//

import ProjectDescription

let sharedTemplate = Template(
    description: "Shared module scaffold",
    attributes: [.required("name")],
    items: [
        .file(
            path: "Shared/{{ name }}/Project.swift",
            templatePath: "project.stencil"
        ),
        .file(
            path: "Shared/{{ name }}/Sources/Interface/{{ name }}Interface.swift",
            templatePath: "SharedModuleFile.swift"
        ),
        .file(
            path: "Shared/{{ name }}/Sources/Implementation/{{ name }}Implementation.swift",
            templatePath: "SharedModuleFile.swift"
        ),
        .file(
            path: "Shared/{{ name }}/Resources/Assets.xcassets/Contents.json",
            templatePath: "AssetsContents.json"
        ),
        .file(
            path: "Shared/{{ name }}/Tests/UnitTests/{{ name }}Tests.swift",
            templatePath: "SharedModuleFile.swift"
        ),
        .file(
            path: "Shared/{{ name }}/Tests/Testing/{{ name }}Testing.swift",
            templatePath: "SharedModuleFile.swift"
        )
    ]
)
