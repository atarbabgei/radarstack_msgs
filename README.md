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

Radar identification, RF parameters, and detection bounds. Published periodically on the `/info` topic. Per-frame dimensions (`num_chirps`, `num_samples`, `tdm_mimo`) are in `RadarFrame`.

- **Identification**: `device` (e.g. `"1843"`, `"6843aop"`), `sdk_version`
- **Timing**: `frame_repetition_time_s`
- **RF parameters**: `sample_rate_hz`, `start_frequency_hz`, `bandwidth_hz` (needed for range/velocity resolution)
- **Antenna masks**: `bool[]` arrays for RX and TX (e.g. `[true, true, true, true]`). Antenna counts are derived: `n_tx = sum(tx_mask)`, `n_rx = sum(rx_mask)`
- **On-board processing** (`onboard_` prefix): `onboard_enabled` flag indicates if on-chip detection is active. When enabled: `onboard_range_max`, `onboard_velocity_min/max`, `onboard_azimuth/elevation_fov_min/max`, and `onboard_clutter_removal` carry the detection bounds. All `onboard_` fields are 0/false when disabled.

## License

MIT
