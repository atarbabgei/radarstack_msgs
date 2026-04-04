# Radar configuration
#
# Describes the radar hardware, antenna layout, FMCW chirp parameters,
# analog front-end settings, calibration, and virtual array geometry.
# Published once on connection and periodically on the /info topic.

std_msgs/Header header

# Device identification
string manufacturer       # Vendor name, e.g. "ti", "infineon"
string device             # Board variant, e.g. "1843", "1843aop", "6843aop"
string sdk_version        # Firmware / SDK version string

# Antenna configuration
uint8   num_rx            # Number of active RX antennas
uint8   num_tx            # Number of active TX antennas
bool[]  rx_mask           # Per-RX-channel enable mask
bool[]  tx_mask           # Per-TX-channel enable mask

# MIMO mode
uint8 mimo_mode
uint8 MIMO_NONE = 0
uint8 MIMO_TDM  = 1
uint8 MIMO_BPM  = 2

# Antenna geometry (lambda/2 grids, row-major, top row = highest elevation)
# Cell values: -1 = empty, 0..N = antenna index
# n_rows = len(grid) / grid_cols
uint8   tx_grid_cols
int8[]  tx_grid
uint8   rx_grid_cols
int8[]  rx_grid
uint8[] chirp_order        # Maps chirp slot index to TX antenna index

# Virtual array geometry (per element, TX-major order, half-wavelength positions)
# Empty arrays = assume ULA along azimuth (positions 0..N-1, single elevation row)
uint8     virtual_array_elevation_bins  # Number of elevation grid rows (0 = derive from positions)
uint8     virtual_array_azimuth_bins    # Number of azimuth grid columns (0 = derive from positions)
float32[] virtual_array_position_x     # [lambda/2] Azimuth position per element
float32[] virtual_array_position_z     # [lambda/2] Elevation position per element

# FMCW chirp parameters
float64 chirp_start_freq_ghz       # [GHz] Chirp start frequency
float64 chirp_idle_time_us         # [us] Inter-chirp idle time
float64 chirp_adc_start_time_us    # [us] ADC sampling start offset
float64 chirp_ramp_end_time_us     # [us] Chirp ramp duration
float64 chirp_tx_start_time_us     # [us] TX start offset
float64 chirp_slope_mhz_per_us     # [MHz/us] Frequency slope
uint16  chirp_adc_samples          # Number of ADC samples per chirp (range bins)
float64 chirp_sample_rate_ksps     # [ksps] ADC sample rate
uint16  chirp_loops                # Chirp loops per frame (Doppler bins)
float64 frame_period_ms            # [ms] Frame repetition period

# Analog front-end (0.0 if unavailable)
float64 tx_power_dbm      # [dBm] TX output power
float64 rx_gain_db         # [dB] RX chain gain
float64 hpf_cutoff_hz     # [Hz] High-pass filter cutoff
float64 lpf_cutoff_hz     # [Hz] Low-pass filter cutoff
float64 noise_figure_db   # [dB] Receiver noise figure

# Calibration (0 or empty = uncalibrated)
float64   range_bias_m    # [m] Range measurement bias
float64[] rx_phase_bias   # Per-virtual-channel phase/gain bias, Re/Im interleaved, TX-major order

# On-chip detection
bool onchip_cfar_enabled  # True if on-chip CFAR point cloud is active
