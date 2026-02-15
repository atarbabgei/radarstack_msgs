# radarstack_msgs

Generic radar message definitions for ROS2.

## Overview

This package provides standard ROS2 message definitions for radar sensors, designed to be vendor-agnostic and reusable across different radar systems.

## Building

```bash
colcon build --packages-select radarstack_msgs
```

## Messages

### RadarFrame

Raw radar ADC frame using the **radar cube convention**. Represents a 3D tensor of ADC samples with shape:
```
[num_chirps x num_rx x num_samples]
```

Where:
- `num_chirps` — Doppler dimension (loops for TDM-MIMO, total chirps otherwise)
- `num_rx` — spatial channels (virtual antennas for MIMO, physical RX otherwise)
- `num_samples` — range dimension (ADC samples per chirp)

The data array is flattened in row-major order:

```
C = 1 if is_complex == false
C = 2 if is_complex == true  (I and Q)

idx = chirp  * (num_rx * num_samples * C)
    + rx     * (num_samples * C)
    + sample * C
    + c

where:
  chirp  in [0, num_chirps  - 1]
  rx     in [0, num_rx      - 1]
  sample in [0, num_samples - 1]
  c = 0 for I, c = 1 for Q (if is_complex == true)
```

TX/RX decomposition (needed for beamforming) is available from `RadarInfo` on the `/info` topic via the `tx_mask` and `rx_mask` arrays.

Length constraint:
```
len(data) = num_chirps * num_rx * num_samples * (is_complex ? 2 : 1)
```

### RadarInfo

Radar identification, RF parameters, and detection bounds. Published periodically on the `/info` topic. Fully self-contained -- includes radar cube dimensions and MIMO scheme so subscribers do not need to wait for a `RadarFrame`.

- **Identification**: `device` (e.g. `"1843"`, `"6843aop"`), `manufacturer`, `sdk_version`
- **Timing**: `frame_repetition_time_s`, `chirp_cycle_time_s` (single chirp idle + ramp duration, needed for velocity calculations)
- **RF parameters**: `sample_rate_hz`, `chirp_start_frequency_hz`, `center_frequency_hz` (= chirp_start + bandwidth/2), `bandwidth_hz`, `frequency_slope_hz_per_s` (FMCW chirp slope)
- **Antenna configuration**: `bool[]` arrays `rx_mask` and `tx_mask` (e.g. `[true, true, true, true]`), with convenience counts `num_rx_active` and `num_tx_active`, `tdm_mimo` flag, and `num_virtual_channels` (= tx*rx for TDM-MIMO, rx otherwise)
- **Radar cube dimensions**: `num_chirps` (Doppler), `num_samples` (range) -- also present in `RadarFrame` for convenience
- **Analog front-end**: `tx_power_dbm`, `rx_gain_db`, `hp_cutoff_hz`, `lp_cutoff_hz`, `noise_figure_db` (all 0.0 when not configured)
- **Derived performance**: `range_resolution_m` (= c / 2B), `velocity_resolution_m_s` (= lambda / 2NT), `max_unambiguous_velocity_m_s` (= lambda / 4T). Computed by the driver from RF + timing params; 0.0 when not computed.
- **On-board processing** (`onboard_` prefix): `onboard_enabled` flag indicates if on-chip detection is active. When enabled: `onboard_range_max`, `onboard_velocity_min/max`, `onboard_azimuth/elevation_fov_min/max`, and `onboard_clutter_removal` carry the detection bounds. All `onboard_` fields are 0/false when disabled.

## License

MIT
