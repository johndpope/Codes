
function [pred_state_seqs] = baseline_decode(baseline_params, obs_seqs)
    gamma = baseline_params.gamma;
    pred_state_seqs = cell(1, length(obs_seqs));

    %% Remove from here
    for k = 1:length(obs_seqs)
        ob_seq = obs_seqs{k};
        Tk = length(ob_seq);

        % Independent prediction for each symbol.
        pred_st_seq = zeros(1, Tk);

        %% Your code goes here. Independent prediction of each label.
        for i=1:Tk
        pred_st_seq(i)=find(gamma(:,ob_seq(i))==max(gamma(:,ob_seq(i)))) ;
        end
        pred_state_seqs{k} = pred_st_seq;
    end
end

