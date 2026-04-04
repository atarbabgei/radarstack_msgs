# Raw radar ADC frame
#
# Contains ADC (IQ or I only) samples from a single radar frame
# Reshape using RadarInfo fields: chirp_loops, chirp_adc_samples, num_rx, num_tx, mimo_mode.

std_msgs/Header header

int16[] data # Raw ADC samples
