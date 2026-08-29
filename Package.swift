// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "swift-gpr_tools",
    products: [
        .library(name: "GprTools", targets: ["GprTools"]),
    ],
    targets: [
        .target(
            name: "Cgpr_tools",
            path: "Sources/Cgpr_tools",
            exclude: [
                "gpr/source/app",
                "gpr/source/lib/dng_sdk/dng_validate.cpp",
                "gpr/build",
                "gpr/data",
            ],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("gpr/source/lib/common/public"),
                .headerSearchPath("gpr/source/lib/common/private"),
                .headerSearchPath("gpr/source/lib/vc5_common"),
                .headerSearchPath("gpr/source/lib/vc5_decoder"),
                .headerSearchPath("gpr/source/lib/vc5_encoder"),
                .headerSearchPath("gpr/source/lib/dng_sdk"),
                .headerSearchPath("gpr/source/lib/gpr_sdk/public"),
                .headerSearchPath("gpr/source/lib/xmp_core/public/include"),
                .headerSearchPath("gpr/source/lib/md5_lib"),
                .headerSearchPath("gpr/source/lib/expat_lib"),
                .headerSearchPath("gpr/source/lib/tiny_jpeg"),
                .define("GPR_READING=1"),
                .define("GPR_WRITING=1"),
                .define("GPR_JPEG_AVAILABLE=1"),
                .define("XML_STATIC=1"),
                .define("GIT_COMMIT_HASH=\"\""),
                .define("GIT_BRANCH=\"\""),
            ]
        ),
        .target(
            name: "GprTools",
            dependencies: ["Cgpr_tools"],
            path: "Sources/GprTools"
        ),
        .testTarget(
            name: "GprToolsTests",
            dependencies: ["GprTools"],
            path: "Tests/GprToolsTests"
        ),
    ]
)
