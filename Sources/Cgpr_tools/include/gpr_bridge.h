#ifndef GPR_BRIDGE_H
#define GPR_BRIDGE_H

#ifdef __cplusplus
extern "C" {
#endif

/* Convert a .GPR file to a standard DNG file.
   Returns 0 on success, -1 on failure. */
int gpr_bridge_convert_gpr_to_dng(const char* gpr_path, const char* dng_path);

/* GPR SDK version string (static). */
const char* gpr_bridge_version(void);

#ifdef __cplusplus
}
#endif

#endif /* GPR_BRIDGE_H */
