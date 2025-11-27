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

Raw radar ADC frame (radar cube). Represents a 3D tensor of ADC samples with shape:
```
[num_chirps x num_rx x num_samples]
```

The data array is flattened in row-major order with the following indexing:

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

This message is intentionally generic and only assumes:
- ADC samples are stored as int16
- Layout is described by num_chirps, num_rx, num_samples, is_complex, interleaved

Length constraint:
```
len(data) = num_chirps * num_rx * num_samples * (is_complex ? 2 : 1)
```

### RadarConfig

Current mmWave radar configuration containing runtime settings:
- **Timing configuration**: frame and chirp repetition times, number of chirps, TDM-MIMO mode
- **Chirp/RF configuration**: sample rate, center frequency, bandwidth, frequency sweep range, number of samples
- **Active antenna masks**: RX/TX antenna selection and count
- **TX power and IF front-end**: power level, filter cutoff frequencies, IF gain

### RadarSpecifications

Hardware capabilities of a mmWave radar device (static or rarely changing information):
- **Basic identification**: manufacturer, model, radar type, SDK version
- **RF front-end limits**: min/max RF frequency range (capability, not current config)
- **Antenna configuration**: physical TX/RX antenna counts, max TX power
- **ADC capabilities**: max samples per chirp, ADC sampling rate range, ADC resolution
- **Available IF filter and gain options**: lists of supported cutoff frequencies and gains
- **Antenna geometry**: 3D positions of RX and TX antennas

### RadarInfo

Combined message containing both `RadarSpecifications` and `RadarConfig`, providing complete radar sensor information in a single timestamped message.

## License

MIT

