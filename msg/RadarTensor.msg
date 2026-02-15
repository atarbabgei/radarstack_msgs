std_msgs/Header header
# N-dimensional radar tensor (3D or 4D) for neural network consumption.
#
# Typical tensors:
#   RAD  3D: shape=[R, A, D],    dim_labels=["range","azimuth","doppler"]
#   RADE 4D: shape=[R, A, D, E], dim_labels=["range","azimuth","doppler","elevation"]
#
# Data is row-major (C-order) float32.

uint32[] shape              # tensor dimensions, e.g. [256, 128, 64]
string[] dim_labels         # human-readable axis names
float32[] data              # row-major flattened tensor
