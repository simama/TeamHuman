# Current Work
A brief overview of what's been done, and what's on my plate. 

## Data Collection App
- [x] Implemented second draft at recording data UI
    I added a 2 second timer, and a toggle to switch between recording normal data, and recording a fall. 
- [x] Added display to see num samples Normal vs Fall
- [x] added logic for the timer
- [x] Created fixed fixed size feature vectors
- [x] Uploaded feature vectors to Parse
- [x] Query Parse for num samples on update 

## Neural Network Processing
- [x] can now extract all data to a text file for processing
- - [x] Train a perceptron or simple feed forward neural network to classify
    - [x] Break up data into 80-20 Train-Test
    - [x] Compute Accuracy
    - [x] Save weights to external file

## User App
- [x] Train a perceptron or simple feed forward neural network to classify
    - [x] Break up data into 80-20 Train-Test
    - [x] Compute Accuracy
    - [x] Save weights to external file
- [x] Build Product App
    - [x] Build UI
    - [ ] Clean UI
    - [x] Load classifier into App with weights from that file
    - [ ] Real-time classify and notify user
         - Naive notification can just be text / color change. No need for push. 

## Issues
- [MLPNeuralNet](https://github.com/nikolaypavlov/MLPNeuralNet/tree/master/MLPNeuralNet) is a pain to get running as a MacOS / Terminal App
- Compatibility issues with certain libraries being in `Objective-C` and others in `Swift`
