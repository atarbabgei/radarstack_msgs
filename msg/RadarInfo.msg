std_msgs/Header header
# Radar information: identification, RF parameters, and detection bounds.
# Published periodically on the /info topic.
# Per-frame dimensions (num_chirps, num_samples, tdm_mimo) are in RadarFrame.

# Identification
string manufacturer              # e.g. "ti", "infineon"
string device                    # e.g. "1843", "1843aop", "6843aop"
string sdk_version               # e.g. "3.6.0"

# Timing
float64 frame_repetition_time_s

# RF parameters (needed for range/velocity resolution calculation)
float64 sample_rate_hz
float64 start_frequency_hz
float64 bandwidth_hz

# Antenna masks (per-channel enable, e.g. [true, true, true, true])
bool[] rx_mask
bool[] tx_mask

# On-board processing — all fields 0/false when onboard_enabled == false
bool onboard_enabled                # true if on-chip detection is active
float64 onboard_range_max          # max detection range (meters)
float64 onboard_velocity_min       # min radial velocity (m/s)
float64 onboard_velocity_max       # max radial velocity (m/s)
float64 onboard_azimuth_fov_min    # azimuth FoV minimum (degrees)
float64 onboard_azimuth_fov_max    # azimuth FoV maximum (degrees)
float64 onboard_elevation_fov_min  # elevation FoV minimum (degrees)
float64 onboard_elevation_fov_max  # elevation FoV maximum (degrees)
bool onboard_clutter_removal       # clutter removal enabled
