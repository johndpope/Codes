
function [seqs_str] = map_to_readable(seqs, index_to_str)

    N = length(seqs);
    seqs_str = cell(1, N);

    for k = 1:N
        sq = seqs{k};
        sq_str = index_to_str(sq);
        seqs_str{k} = sq_str;
    end
end
