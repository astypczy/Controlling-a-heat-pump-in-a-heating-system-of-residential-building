# Controlling a heat pump in a heating system of residential building
The thesis was written in Polish at the Wrocław University of Science and Technology.  
## Overview
In the context of increasing demand for sustainable and energy-efficient technologies, effective control of heat pumps has become a critical aspect of residential heating systems. This project focuses on developing a heat pump control system based on a precisely defined object model created in Matlab Simulink.

The main goal is to simulate a residential building with different heating systems, such as radiator and floor heating, and compare various installations in terms of control efficiency and operating costs. External conditions, internal thermal disturbances, and setpoint changes will be considered to evaluate the system's performance.

## Project Objectives
The key objectives of this project include:

Modeling of Heating Systems:

    Develop models of different heating systems (radiator, floor heating) using Matlab Simulink.
    Simulate thermal dynamics within a residential building.
Control System Development:

    Implement a control system based on mathematical models.
    Optimize control strategies for heat pumps by analyzing different installation variants.
Simulation & Performance Evaluation:

    Conduct simulations of the control system under various operational conditions.
    Evaluate performance using quality metrics and cost-effectiveness.
Regulator Design:

    Implement a PID controller for regulating the heat pump system.
    Tune PID parameters for optimal performance in different heating scenarios.

##  Summary
The developed heat pump model successfully incorporated variable heating power, energy consumption, and efficiency factors. Additionally, safeguards were implemented to prevent the compressor from operating at extreme frequencies and to ensure minimum water flow. However, due to the system's constraints and variability, care was needed to avoid boundary values during simulation, as these could cause oscillations.

Three types of control strategies were implemented: open control based on weather curves, and room and weather-based closed-loop controls. Room-based controllers showed superior performance in dynamic regulation and responsiveness to disturbances, like window ventilation, but at the cost of higher energy consumption. Weather-based controls were effective but slower to react to sudden changes. 
