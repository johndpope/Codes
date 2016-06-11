
function [baseline_params] = baseline_train(state_seqs, obs_seqs, n, m)
    assert (length(state_seqs) == length(obs_seqs));

    c_gamma = zeros(n, m);

    %% Your code goes here. Collecting the co-occurrence statistics.
for i=1:size(state_seqs,2)
    a=state_seqs{1,i} ;
    b=obs_seqs{1,i} ;
    for j=1:size(a,2)
        c_gamma(a(j),b(j)) = c_gamma(a(j),b(j)) + 1 ;
    end
end
    baseline_params.gamma = c_gamma ./ repmat(sum(c_gamma, 2), 1, m);
end
