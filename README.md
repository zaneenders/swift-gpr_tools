# swift-gpr_tools

A Swift wrapper around GoPro's open-source
[GPR SDK](https://github.com/gopro/gpr). It converts GoPro `.GPR` files
(VC-5 compressed DNG payloads) into standard DNG that any RAW developer
(e.g. LibRaw) can decode.

The GPR SDK is vendored as a git submodule and compiled directly by Swift
Package Manager — no separate build step, no binary to locate. The same
package builds on **Linux and macOS**.

## Layout

```
Sources/
  Cgpr_tools/
    include/gpr_bridge.h     # public C API Swift imports
    include/module.modulemap
    shim.cpp                  # calls gpr_convert_gpr_to_dng() directly
    gpr/                      # gopro/gpr submodule — compiled by SwiftPM
  GprTools/
    GprTools.swift            # Swift API: GprTools.convert(...)
```

## Setup

```sh
git clone --recursive <this-repo>
cd swift-gpr_tools
swift build            # compiles GPR SDK + shim + Swift wrapper
swift test             # runs smoke tests
```

System dependencies: a C/C++ compiler (`gcc`/`clang`) and `cmake` (not needed
for the SwiftPM build, but useful if you want to build the standalone
`gpr_tools` binary separately). SwiftPM compiles the GPR SDK's ~130 C/C++
source files as part of the `Cgpr_tools` target, so the symbols are linked
automatically into any package that depends on `swift-gpr_tools`.

## Usage

```swift
import GprTools

try GprTools.convert(gprFile: "/media/G0012329.GPR",
                     toDNG: "/tmp/G0012329.dng")
```

The conversion calls the GPR SDK's `gpr_convert_gpr_to_dng()` C function
directly in-process — no subprocess, no binary path to manage.
