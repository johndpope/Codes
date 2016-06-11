function C = update_centers(X, C, a)
  % Implement your function here.
  for i=1:size(C,1)
      C(i,:) = mean(X(find(a==i),:)) ;
  end
end
