tic ;
% Load the training and test data. 
load data.mat

n = length(index_to_tag);
m = length(index_to_word);

% Train the baseline model.
baseline_params = baseline_train(train.tag_seqs, train.word_seqs, n, m);

bl_pred_tag_seqs_train = baseline_decode(baseline_params, train.word_seqs);
bl_pred_tag_seqs_test = baseline_decode(baseline_params, test.word_seqs);

bl_acc_train = accuracy(bl_pred_tag_seqs_train, train.tag_seqs)
bl_acc_test = accuracy(bl_pred_tag_seqs_test, test.tag_seqs)

% Train the hmm model.
alpha_words = 0.1;
alpha_tags = 0.0;
hmm_params = hmm_train(train.tag_seqs, train.word_seqs, n, m, alpha_words, alpha_tags);

hmm_pred_tag_seqs_train = hmm_decode(hmm_params, train.word_seqs);
hmm_pred_tag_seqs_test = hmm_decode(hmm_params, test.word_seqs);

hmm_acc_train = accuracy(hmm_pred_tag_seqs_train, train.tag_seqs)
hmm_acc_test = accuracy(hmm_pred_tag_seqs_test, test.tag_seqs)

toc ;