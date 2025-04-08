import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "HoneyRoutine",
    moduleLayer: .app,
    targets: [
        .app
    ],
    infoPlists: [
        .implementation: .file(path: Path(stringLiteral: HoneyRoutineModule.Paths.infoPlist))
    ],
    resources: [
        .implementation: ResourceFileElements(stringLiteral: HoneyRoutineModule.Paths.resources)
    ],
    dependencies: [
        .implementation: []
    ],
    settings: [
        .implementation: .settings(
            configurations: [
                .debug(
                    name: "Debug",
                    xcconfig: .relativeToRoot(HoneyRoutineModule.Paths.debugXCConfig)
                ),
                .release(
                    name: "Release",
                    xcconfig: .relativeToRoot(HoneyRoutineModule.Paths.releaseXCConfig)
                )
            ],
            defaultSettings: .recommended
        )
    ],
    schemes: [
        SchemeFactory.makeDev(name: "HoneyRoutine", mainTarget: "HoneyRoutine"),
        SchemeFactory.makeRelease(name: "HoneyRoutine", mainTarget: "HoneyRoutine")
    ]
)
