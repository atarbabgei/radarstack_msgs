std_msgs/Header header
# Raw radar ADC frame (radar cube).
#
# Radar cube dimensions: [num_chirps x num_rx x num_samples]
#   num_chirps  = Doppler dimension (loops for TDM-MIMO, total chirps otherwise)
#   num_rx      = spatial channels (virtual antennas for MIMO, physical RX otherwise)
#   num_samples = range dimension (ADC samples per chirp)
#
# TX/RX decomposition (needed for beamforming) is available from RadarInfo
# on the /info topic (num_tx_antennas, num_rx_antennas fields).

uint16 num_chirps        # Doppler dimension
uint16 num_rx            # spatial channels (virtual for MIMO)
uint16 num_samples       # range dimension

# ADC format
bool is_complex          # true = I/Q complex (two int16 per sample), false = real-only
bool interleaved         # I/Q layout (only when is_complex == true)
                         #   true  = per-chirp interleaved (e.g. IIQQ from DCA1000)
                         #   false = separated [I0, I1, ..., Q0, Q1, ...]
bool tdm_mimo            # true = TDM-MIMO (chirps were TX-interleaved)

# Flattened raw ADC samples (always int16)
# Reshape: data.reshape(num_chirps, num_rx, num_samples * (2 if is_complex else 1))
int16[] data
