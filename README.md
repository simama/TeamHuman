# Gera
We are designing **Gera** to leverage device motion, and biometeric data to give real time alerts and aid our users in times of need.
Be it a bad bike accident, a fall, or a panic attack. Gera will ask you if you are okay, and notify a local hospital otherwise.
I calls the authorities with your GPS location, and can pass critical health information to medical professionals.

It's a tall call for a single product, and there is a lot that needs to happen to make this idea a reality. This repo is a prototype at a concept.
Our prototype is a single fall-detector iPhone App.

We break this up into 3 bodies of work.

## Data Collection App
This app let's user record and produce labeled motion data for training

## Training App
This trains our fall detection model (given the data collection with the Data Collection App) and outputs the learned weights to an external file.

## Gera Alert App
Tracks motion data, and notifies you if it thinks you fell. 

### Who are we? 
This work is part of an MIT entrenpeneurship experiment. The Gera is being developed by Adam Yala, Martin Simic, and Larissa Senatus. 
