# Current Work
A brief overview of what's been done, and what's on my plate. 

## UI Update
- [x] Implemented second draft at recording data UI
    I added a 2 second timer, and a toggle to switch between recording normal data, and recording a fall. 
- [x] Added display to see num samples Normal vs Fall

## Logic Update
- [x] added logic for the timer
- [x] Created fixed fixed size feature vectors
- [x] Uploaded feature vectors to Parse
- [x] Query Parse for num samples on update 

## Data Update
- [x] can now extract all data to a text file for processing

## Issues
- [MLPNeuralNet](https://github.com/nikolaypavlov/MLPNeuralNet/tree/master/MLPNeuralNet) is a bitch to get running as a MacOS / Terminal App
- Compatibility issues with certain libraries being in `Objective-C` and others in `Swift`

## Todo
- [ ] Train a perceptron or simple feed forward neural network to classify
    - [ ] Break up data into 80-20 Train-Test
    - [ ] Compute Accuracy
    - [ ] Save weights to external file
- [ ] Build Product App
    - [ ] Build UI
    - [ ] Load classifier into App with weights from that file
    - [ ] Real-time classify and notify user
         - Naive notification can just be text / color change. No need for push. 
