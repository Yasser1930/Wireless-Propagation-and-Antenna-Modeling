# Wireless Propagation and Antenna Modeling

## Project Overview
This project explores wireless signal behavior across different antenna types within indoor and urban environments. The focus is on modeling the signal loss gradient and propagation characteristics to optimize wireless communication systems. MATLAB simulations provide insight into the effects of omnidirectional and directional antennas, helping to understand how the environment and antenna setup impact signal strength and performance.

## Objectives
The primary goals of this project are:
- To examine how various antenna types (omnidirectional vs. directional) influence the gradient of signal strength over distance.
- To simulate and analyze wireless channel propagation using ray-tracing techniques in environments with reflective surfaces.
- To explore the effects of different antenna configurations and environmental factors on signal performance for optimized system design.

## Methodology
This project follows a two-phase approach:

1. **Phase 1 - Signal Loss Gradient Analysis**:
   - This phase focuses on calculating the gradient of signal loss (η) for both omnidirectional and directional antennas over varying distances.
   - Simulations utilize signal profiles to capture slow and rapid changes in signal strength, highlighting the impact of environmental factors and antenna configuration.
   - MATLAB scripts compute the loss gradient and residual variance, providing detailed insights into each configuration’s stability.

2. **Phase 2 - Propagation Channel Modeling**:
   - This phase models the wireless channel using ray-tracing to evaluate signal propagation in environments with reflective surfaces, such as floors and walls.
   - The model considers both two-ray and four-ray scenarios, with simulations taking into account dielectric constants to observe changes in signal distribution and power loss.
   - MATLAB visualizations allow for analysis of signal behavior in complex indoor environments, especially focusing on the effect of reflections and directivity.

## Results and Findings
### Phase 1 Results
- **Omnidirectional vs. Directional Antennas**:
  - Omnidirectional antennas offer stable signal coverage across larger areas but experience a steeper power loss over distance compared to directional antennas.
  - Directional antennas exhibit a faster signal loss gradient, focusing energy within a specific range, making them ideal for targeted applications.

- **Loss Gradient (η)**:
  - The computed loss gradient η was significantly higher for directional antennas, confirming their sensitivity to distance but also their strength within concentrated areas.

### Phase 2 Results
- **Impact of Reflections**:
  - Floor reflections contribute to increased signal strength in close-range setups, while additional wall reflections introduce multi-path interference, affecting signal stability.
  - Higher dielectric constants in reflective surfaces amplify signal power but cause rapid fluctuations due to interference patterns.

- **Directivity Effect**:
  - Antennas with higher directivity (n=3) concentrate signals more effectively, creating strong signals within a targeted direction but reducing coverage in non-targeted zones.
  - Signal profiles reveal that increased directivity leads to stronger but more focused signal distributions, which is advantageous in controlled, directional applications.

These findings suggest that optimizing antenna choice and placement based on the environmental setup and required coverage can significantly enhance wireless communication reliability and efficiency.
