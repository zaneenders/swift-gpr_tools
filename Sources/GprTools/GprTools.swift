import Foundation
import Cgpr_tools

public enum GprToolsError: Error, CustomStringConvertible {
    case conversionFailed(String)

    public var description: String {
        switch self {
        case let .conversionFailed(path): "GPR to DNG conversion failed for \(path)"
        }
    }
}

/// Swift wrapper around GoPro's open-source GPR SDK.
///
/// Calls the C library directly (compiled by SwiftPM from the vendored
/// [gopro/gpr](https://github.com/gopro/gpr) submodule) to convert `.GPR`
/// files (VC-5 compressed DNG) into standard DNG that a RAW developer
/// such as LibRaw can read.
public enum GprTools {
    /// Convert a `.GPR` file to a standard DNG.
    /// - Parameters:
    ///   - gprFile: Path to the source `.GPR` file.
    ///   - dngFile: Path to the output `.dng` file.
    /// - Throws: `GprToolsError` if the conversion fails.
    public static func convert(gprFile: String, toDNG dngFile: String) throws {
        let rc = gprFile.withCString { gpr in
            dngFile.withCString { dng in
                gpr_bridge_convert_gpr_to_dng(gpr, dng)
            }
        }
        if rc != 0 {
            throw GprToolsError.conversionFailed(gprFile)
        }
    }

    /// GPR SDK version string.
    public static var version: String {
        String(cString: gpr_bridge_version())
    }
}
