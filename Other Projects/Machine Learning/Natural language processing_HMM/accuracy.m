
function [acc] = accuracy(pred_state_seqs, true_state_seqs)
    ncorrect = 0;
    ntotal = 0;

    for k = 1:length(true_state_seqs)
        pred_st_seq = pred_state_seqs{k};
        true_st_seq = true_state_seqs{k};
        Tk = length(pred_st_seq);

        ncorrect = ncorrect + sum(pred_st_seq == true_st_seq);
        ntotal = ntotal + Tk;
    end

    acc = ncorrect / ntotal;
end
