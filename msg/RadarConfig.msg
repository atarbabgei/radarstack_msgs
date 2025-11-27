# Current mmWave radar configuration (runtime settings).

# Timing configuration
float64 frame_repetition_time_s
float64 chirp_repetition_time_s
uint16 num_chirps
bool tdm_mimo

# Chirp / RF configuration
float64 sample_rate_hz
float64 center_frequency_hz
float64 bandwidth_hz
float64 start_frequency_hz
float64 end_frequency_hz
uint16 num_samples

# Active antenna masks
uint8 rx_mask
uint8 tx_mask
uint8 num_active_rx

# TX power and IF front-end
uint8 tx_power_level
float64 lp_cutoff_hz
float64 hp_cutoff_hz
uint8 if_gain_db
