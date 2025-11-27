# Hardware capabilities of a mmWave radar device.
# Intended to be static (or rarely changing) information.

# Basic identification
string manufacturer
string model
string radar_type
string sdk_version

# RF front-end limits (capability range, not current config)
float64 min_rf_frequency_hz
float64 max_rf_frequency_hz

# Antenna configuration (physical RX/TX count)
uint8 num_tx_antennas
uint8 num_rx_antennas
uint8 max_tx_power

# ADC capabilities
uint16 max_num_samples_per_chirp
float64 min_adc_sampling_rate
float64 max_adc_sampling_rate
uint8 adc_resolution_bits

# Available IF filter and gain options
uint32[] lp_cutoff_list
uint32[] hp_cutoff_list
uint8[] if_gain_list

# Antenna geometry
float32[] rx_pos_x
float32[] rx_pos_y
float32[] rx_pos_z
float32[] tx_pos_x
float32[] tx_pos_y
float32[] tx_pos_z
