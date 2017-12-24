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
fileID = fopen('asynch.txt','w');
allStates = dec2bin(0:2^(9)-1)-'0';
fprintf(fileID,'Initial State \t\t Final State \t\t #Iterations\n');
finals = [];
for i = 1:512
  initialState = allStates(i,:).';
  flag = 1;
  iterations = 0;
  while flag == 1
    iterations += 1;
    for j = 1:9
      finalState(j) = f(W(j,:) * initialState, initialState(j));
      initialState(j) = finalState(j);
    end
    finalState = f(W * initialState, initialState);
    if isequal(initialState, finalState.')
      flag = 0;
    end
  end
  if iterations == 512
    printVar = "oscillation";
  else
    printVar = int2str(iterations);
  end
  fprintf(fileID,'%s \t\t\t %s \t\t\t %s\n', num2str(allStates(i,:)(:)), num2str(finalState(:)), printVar);
  finals(i,:) = initialState.';
end
fclose(fileID);