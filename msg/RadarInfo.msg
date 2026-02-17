std_msgs/Header header
# Radar information: identification, RF parameters, and detection bounds.
# Published periodically on the /info topic.

# Identification
string manufacturer              # e.g. "ti", "infineon"
string device                    # e.g. "1843", "1843aop", "6843aop"
string sdk_version               # e.g. "3.6.0"

# Timing
float64 frame_repetition_time_s
float64 chirp_cycle_time_s       # single chirp cycle (idle + ramp), needed for velocity calcs

# RF parameters (needed for range/velocity resolution calculation)
float64 sample_rate_hz
float64 chirp_start_frequency_hz # chirp start frequency (Hz)
float64 center_frequency_hz      # center frequency = chirp_start + bandwidth/2 (Hz)
float64 bandwidth_hz
float64 frequency_slope_hz_per_s # FMCW chirp slope (Hz/s)

# Antenna masks (per-channel enable, e.g. [true, true, true, true])
bool[] rx_mask
bool[] tx_mask
uint8 num_rx_active               # number of enabled RX antennas (= sum of rx_mask)
uint8 num_tx_active               # number of enabled TX antennas (= sum of tx_mask)
bool tdm_mimo                     # true = TDM-MIMO (TX channels time-multiplexed)
uint16 num_virtual_channels       # effective spatial channels (tx*rx for TDM-MIMO, rx otherwise)

# Radar cube dimensions (also in RadarFrame, included here for self-containedness)
uint16 num_chirps                 # Doppler dimension (loops for TDM-MIMO, total chirps otherwise)
uint16 num_samples                # range dimension (ADC samples per chirp)

# Analog front-end (0.0 = not configured / not applicable)
float64 tx_power_dbm              # TX conducted output power (dBm)
float64 rx_gain_db                # total RX chain gain (dB)
float64 hp_cutoff_hz              # high-pass filter cutoff (Hz)
float64 lp_cutoff_hz              # low-pass / anti-aliasing filter cutoff (Hz)
float64 noise_figure_db           # receiver noise figure (dB), 0.0 = not available

# Derived performance (computed by driver from RF + timing params, 0.0 = not computed)
float64 range_resolution_m           # c / (2 * bandwidth)
float64 velocity_resolution_m_s      # lambda / (2 * n_chirps * chirp_cycle_time)
float64 max_unambiguous_velocity_m_s # lambda / (4 * chirp_cycle_time)

# Per-channel calibration (from compRangeBiasAndRxChanPhase or similar)
float64 range_bias_m                 # range measurement bias (meters), 0.0 = uncalibrated
float64[] rx_phase_bias              # per-virtual-channel phase/gain bias, Re/Im interleaved
                                     # Length = 2 * n_tx * n_rx (pairs: Re0 Im0 Re1 Im1 ...)
                                     # Order: TX0RX0, TX0RX1, ..., TX(N-1)RX(M-1)
                                     # Empty = uncalibrated (identity assumed)

# On-board processing (For TI boards) — all fields 0/false when onboard_enabled == false
bool onboard_enabled                # true if on-chip detection is active
float64 onboard_range_max          # max detection range (meters)
float64 onboard_velocity_min       # min radial velocity (m/s)
float64 onboard_velocity_max       # max radial velocity (m/s)
float64 onboard_azimuth_fov_min    # azimuth FoV minimum (degrees)
float64 onboard_azimuth_fov_max    # azimuth FoV maximum (degrees)
float64 onboard_elevation_fov_min  # elevation FoV minimum (degrees)
float64 onboard_elevation_fov_max  # elevation FoV maximum (degrees)
bool onboard_clutter_removal       # clutter removal enabled
