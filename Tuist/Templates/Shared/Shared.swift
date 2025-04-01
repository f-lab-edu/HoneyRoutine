//
//  template.swift
//  Config
//
//  Created by JUNHEE JO on 4/1/25.
//

import ProjectDescription

let template = Template(
    description: "Shared module scaffold",
    attributes: [.required("name")],
    items: [
        .file(path: "Shared/{{ name }}/Project.swift", templatePath: "project.stencil"),
        .file(path: "Shared/{{ name }}/Sources/Interface/{{ name }}Interface.swift", templatePath: "ModuleFile.swift"),
        .file(path: "Shared/{{ name }}/Sources/Implementation/{{ name }}Implementation.swift", templatePath: "ModuleFile.swift"),
        .file(path: "Shared/{{ name }}/Resources/Assets.xcassets/Contents.json", templatePath: "AssetsContents.json"),
        .file(path: "Shared/{{ name }}/Tests/UnitTests/{{ name }}Tests.swift", templatePath: "ModuleFile.swift"),
        .file(path: "Shared/{{ name }}/Tests/Testing/{{ name }}Testing.swift", templatePath: "ModuleFile.swift"),
        .file(path: "Shared/{{ name }}/scripts/create_structure.sh", templatePath: "scripts/create_structure.sh")
    ]
)
