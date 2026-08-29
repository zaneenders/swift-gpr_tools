#include "gpr.h"

#include <cstdio>
#include <cstdlib>
#include <cstring>

extern "C" {

int gpr_bridge_convert_gpr_to_dng(const char* gpr_path, const char* dng_path) {
    gpr_allocator allocator;
    allocator.Alloc = malloc;
    allocator.Free = free;

    gpr_parameters params;
    gpr_parameters_set_defaults(&params);

    gpr_buffer input_buffer = { NULL, 0 };
    if (read_from_file(&input_buffer, gpr_path, allocator.Alloc, allocator.Free) != 0) {
        return -1;
    }

    gpr_parse_metadata(&allocator, &input_buffer, &params);

    gpr_buffer output_buffer = { NULL, 0 };
    bool success = gpr_convert_gpr_to_dng(&allocator, &params, &input_buffer, &output_buffer);

    int result = -1;
    if (success && output_buffer.buffer && output_buffer.size > 0) {
        result = write_to_file(&output_buffer, dng_path);
    }

    if (output_buffer.buffer) allocator.Free(output_buffer.buffer);
    if (input_buffer.buffer) allocator.Free(input_buffer.buffer);
    gpr_parameters_destroy(&params, allocator.Free);

    return result;
}

const char* gpr_bridge_version(void) {
    return "1.0.0";
}

}  // extern "C"
