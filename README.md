# Hopfield network simulation in asynchronous and synchronous mode

The input vectors:

* [1, 1, 1, 0, 1, 0, 0, 1, 0]
* [1, 0, 1, 1, 0, 1, 1, 1, 1]
* [1, 0, 1, 0, 1, 0, 1, 0, 1]
* [0, 1, 0, 0, 1, 0, 1, 1, 1]
* [1, 0, 0, 1, 0, 0, 1, 1, 1]
* [1, 1, 1, 1, 0, 1, 1, 1, 1]

Represent 9x9 pixel images.

Exercise was asking the implementation of synchronous mode for the first 2 vectors and then with all 6 vectors, and the same for asynchronous mode.
Of course they can be replaced with custom vectors.
The software was implemented in Octave.
In each file (synch.m and asynch.m) user can change the initStates variable to define if the program should run with 2 vectors or 6 vectors.
Each .m file is printing the results to a synch.txt or asynch.txt file.
