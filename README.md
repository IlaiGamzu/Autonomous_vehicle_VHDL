# Auto- Vehicle

-  This project deals with VHDL programming.
-   I was a head of vehicle propulsion and tracks
-   The Board that we work on: Altera DE2.
-   My mission was to cause the car to move in four tracks:
    1. circular.
    2. rectangle.
    3. backward- forward.
    4. hands-control.
    for each track has a state machine that the output of them connects to the mux that chooses the current track according to the user's input.

# The Entity and Architecture:



# State Machine

- For each track has a state machine that runs in infinity
- The dir is a hands-control and not has a state machine

# Mux
- The output of each state machine moves to Mux.
- The Mux arbitrator by the tracks that the user asked.

#  engine 
- The output of Mux moves to an 8 bit vector.
- Each 2 bits represents input to one engine (has 4 Engines).
- The engine changes the direction of the wheel (right/ left/ straight).
  
<img width="698" alt="image" src="https://github.com/IlaiGamzu/VHDL--Vehicle/assets/135164356/297eac76-dbfe-4f59-8c71-a73b0c0e345b">




