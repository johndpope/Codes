
function [pred_state_seqs] = hmm_decode(hmm_params, obs_seqs)
    % Working directly in log domain, as it is more numerically stable.
    log_theta = log(hmm_params.theta);
    log_theta_start = log(hmm_params.theta_start);
    log_theta_stop = log(hmm_params.theta_stop);
    log_gamma = log(hmm_params.gamma);
    [n, m] = size(log_gamma); 

    pred_state_seqs = cell(1, length(obs_seqs));

    for i = 1:length(obs_seqs)
%         ob_seq = obs_seqs{i};
%         Tk = length(ob_seq);
% 
%         pred_st_seq = zeros(1, Tk);
% 
%         % Tables for keeping the scores and backpointers.
%         scores = zeros(n, Tk);
%         back_pts = zeros(n, Tk);
% 
%         % Your code goes here. Maintain the Viterbi table and the 
%         % backpointer table. Recover the most probable assignment.
%         for k=1:n
%             scores(k,1)= log_theta_start(k)+ log_gamma(k,ob_seq(1));
%         end
%         [val,idx]=max(scores(:,1)') ;
%         back_pts(:,1)= idx ;
%         for k=1:n
%             for j=2:Tk
%                 [val,idx]=max(log_theta(:,k) + scores(:,j-1)) ;
%                 scores(k,j)= log_gamma(k,ob_seq(j)) + val;
%                 back_pts(k,j) = idx ;
%             end
%         end
%        pred_state_seqs{i} = pred_st_seq;
        pred_state_seqs{i} = hmmviterbi(obs_seqs{1,i},hmm_params.theta,hmm_params.gamma) ;
    end
end

function [currentState, logP] = hmmviterbi(seq,tr,e,varargin)

numStates = size(tr,1);
checkTr = size(tr,2);
if checkTr ~= numStates
    error(message('stats:hmmviterbi:BadTransitions'));
end

% number of rows of e must be same as number of states

checkE = size(e,1);
if checkE ~= numStates
    error(message('stats:hmmviterbi:InputSizeMismatch'));
end

numEmissions = size(e,2);
customStatenames = false;

% deal with options
if nargin > 3
    okargs = {'symbols','statenames'};
    [symbols,statenames] = ...
        internal.stats.parseArgs(okargs, {[] []}, varargin{:});
    
    if ~isempty(symbols)
        numSymbolNames = numel(symbols);
        if ~isvector(symbols) || numSymbolNames ~= numEmissions
            error(message('stats:hmmviterbi:BadSymbols'));
        end
        [~, seq]  = ismember(seq,symbols);
        if any(seq(:)==0)
            error(message('stats:hmmviterbi:MissingSymbol'));
        end
    end
    if ~isempty(statenames)
        numStateNames = length(statenames);
        if numStateNames ~= numStates
            error(message('stats:hmmviterbi:BadStateNames'));
        end
        customStatenames = true;
    end
end


% work in log space to avoid numerical issues
L = length(seq);
if any(seq(:)<1) || any(seq(:)~=round(seq(:))) || any(seq(:)>numEmissions)
     error(message('stats:hmmviterbi:BadSequence', numEmissions));
end
currentState = zeros(1,L);
if L == 0
    return
end
logTR = log(tr);
logE = log(e);

% allocate space
pTR = zeros(numStates,L);
% assumption is that model is in state 1 at step 0
v = -Inf(numStates,1);
v(1,1) = 0;
vOld = v;

% loop through the model
for count = 1:L
    for state = 1:numStates
        % for each state we calculate
        % v(state) = e(state,seq(count))* max_k(vOld(:)*tr(k,state));
        bestVal = -inf;
        bestPTR = 0;
        % use a loop to avoid lots of calls to max
        for inner = 1:numStates 
            val = vOld(inner) + logTR(inner,state);
            if val > bestVal
                bestVal = val;
                bestPTR = inner;
            end
        end
        % save the best transition information for later backtracking
        pTR(state,count) = bestPTR;
        % update v
        v(state) = logE(state,seq(count)) + bestVal;
    end
    vOld = v;
end

% decide which of the final states is post probable
[logP, finalState] = max(v);

% Now back trace through the model
currentState(L) = finalState;
for count = L-1:-1:1
    currentState(count) = pTR(currentState(count+1),count+1);
    if currentState(count) == 0
        error(message('stats:hmmviterbi:ZeroTransitionProbability', currentState( count + 1 )));
    end
end
if customStatenames
    currentState = reshape(statenames(currentState),1,L);
end

end

