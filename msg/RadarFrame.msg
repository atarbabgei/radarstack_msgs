std_msgs/Header header
# Raw radar ADC frame (radar cube). See package README for data layout details.

# Radar cube dimensions
uint16 num_chirps        # number of chirps per frame
uint16 num_rx            # number of RX antennas
uint16 num_samples       # ADC samples per chirp

# ADC format
bool is_complex          # true = I/Q complex (two int16 per sample), false = real-only
bool interleaved         # valid only if is_complex == true
                         #   true  = [I0, Q0, I1, Q1, ...]
                         #   false = [I0, I1, ..., Q0, Q1, ...]
bool tdm_mimo            # true = TDM-MIMO (chirps interleaved by TX antennas), false = non-TDM-MIMO

# Flattened raw ADC samples (always int16)
int16[] data

