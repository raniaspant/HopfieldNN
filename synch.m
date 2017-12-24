initialStates = [1, 1, 1, 0, 1, 0, 0, 1, 0;       # state 1
                 1, 0, 1, 1, 0, 1, 1, 1, 1;       # state 2
                 1, 0, 1, 0, 1, 0, 1, 0, 1;       # state 3
                 0, 1, 0, 0, 1, 0, 1, 1, 1;       # state 4
                 1, 0, 0, 1, 0, 0, 1, 1, 1;       # state 5
                 1, 1, 1, 1, 0, 1, 1, 1, 1];      # state 6
            
# initialStates(s,:).'  is vertical vector of s
W = zeros(9,9);
initStates = 6;         # change to 2 for (a), change to 6 for (b)
for i = 1:9
  for j = 1:9
    for s = 1:initStates
      W(i, j) += (2 * initialStates(s,i).' - 1) * (2 * initialStates(s,j).' - 1);
    end
    if i == j
      W(i, j) = 0;
    end
  end
end
fileID = fopen('synch.txt','w');
allStates = dec2bin(0:2^(9)-1)-'0';
fprintf(fileID,'Initial State \t\t Final State \t\t #Iterations\n');
c = 0;
finals = [];
for i = 1:512
  initialState = allStates(i,:);
  flag = 1;
  iterations = 0;
  while flag == 1 && iterations < 512
    iterations += 1;
    finalState = f(W * initialState.', initialState);
    if isequal(initialState, finalState)
      flag = 0;
    end
    initialState = finalState;
  end
  if iterations == 512        # if more than 512 iterations occur, assume oscillation
    printVar = "oscillation";
  else
    printVar = int2str(iterations);
  end
  fprintf(fileID,'%s \t\t\t %s \t\t\t %s\n', num2str(allStates(i,:)(:)), num2str(finalState(:)), printVar);
  finals(i,:) = finalState;   # size(unique(finals,'rows')) is the size of the final stable states that occured
end
fclose(fileID);