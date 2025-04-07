//
//  Core.swift
//  Config
//
//  Created by JUNHEE JO on 4/1/25.
//

import ProjectDescription

let coreTemplate = Template(
    description: "Core module scaffold",
    attributes: [.required("name")],
    items: [
        .file(
            path: "Core/{{ name }}/Project.swift",
            templatePath: "project.stencil"
        ),
        .file(
            path: "Core/{{ name }}/Sources/Interface/{{ name }}Interface.swift",
            templatePath: "CoreModuleFile.swift"
        ),
        .file(
            path: "Core/{{ name }}/Sources/Implementation/{{ name }}Implementation.swift",
            templatePath: "CoreModuleFile.swift"
        ),
        .file(
            path: "Core/{{ name }}/Tests/UnitTests/{{ name }}Tests.swift",
            templatePath: "CoreModuleFile.swift"
        ),
        .file(
            path: "Core/{{ name }}/Tests/Testing/{{ name }}Testing.swift",
            templatePath: "CoreModuleFile.swift"
        ),
        .file(
            path: "Core/{{ name }}/scripts/create_structure.sh",
            templatePath: "scripts/create_structure.sh"
        )
    ]
)
