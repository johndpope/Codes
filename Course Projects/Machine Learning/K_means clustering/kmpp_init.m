function [C] = kmpp_init(X, k)
  n = size(X,1);
  sq_distances = ones(n,1);
  center_ixs = [];
  for i = 1:k
    % Choose a new center index using D^2 weighting
    ix = discrete_sample(sq_distances);
    % Update the squared distances for all points
    deltas = bsxfun(@minus, X, X(ix, :));
    sq_dist_to_ix = sum(deltas.^2, 2);
    sq_distances = min(sq_distances, sq_dist_to_ix);
    % Append this center to the list of centers
    center_ixs = [center_ixs ; ix];
  end
  % Output the chosen centers
  C = X(center_ixs, :);
end

function ix = discrete_sample(weights)
  total = sum(weights);
  t = rand() * total;
  p = 0;
  for i = 1:numel(weights)
    p = p + weights(i);
    if p > t
      ix = i;
      break;
    end
  end
end
