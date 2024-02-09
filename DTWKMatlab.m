function logkernel= DTWKMatlab(seq1 ,seq2, sigma)
% Implementation of the global alignment kernel which generalizes the DTW algorithm */
% seq1 is a first sequence represented as a matrix of real elements. Each line i corresponds to the vector of observations at time i. */
% seq2 is the second sequence formatted in the same way.
% sigma stands for the bandwidth of the Gaussian kernel */

LOG0=-10000 ;

nX=size(seq1,1);
nY=size(seq2,1);
dimvect=size(seq1,2); % note that we assume that seq1.dim2() and seq2.dim2() are the same.

grammat=zeros(nX,nY);
S_=1/(sigma*sigma);

%*********************************************************/
%* Computation of the Gram matrix with a Gaussian kernel */
%*********************************************************/

% gram is nX \times nY

% compute square norms
normX= kron(ones(1,nY),sum(seq1.*seq1,2));
normY= kron(ones(nX,1),sum(seq2.*seq2,2)');

grammat= exp(-S_*(normX+normY-2*seq1*seq2'));
% Initialization of the arrays */
% Each array stores two successive columns of the (nX+1)x(nY+1) table used in dynamic programming */
cl = nY+1;           % each column stores the positions in the aaY sequence, plus a position at zero */
logM=zeros(1,2*cl);

%***********************************************/
% First iteration : initialization of column 0 */
%***********************************************/
% The log=proabilities of each state are initialized for the first column (x=0,y=0..nY) */

for j=1:cl,
    logM(j)=LOG0;
end
logM(1)=0;

% Update column order */
cur = 1;      % Indexes [0..cl-1] are used to process the next column */
old = 0;      % Indexes [cl..2*cl-1] were used for column 0 */


%***********************************************/
% Next iterations : processing columns 1 .. nX */
%***********************************************/

% Main loop to vary the position in aaX : i=1..nX */
for i=1:nX,
    % Special update for positions (i=1..nX,j=0) */
    curpos = cur*cl+1;                  % index of the state (i,0) */
    logM(curpos) = LOG0;
    % Secondary loop to vary the position in aaY : j=1..nY */
    for j=1:nY,
        curpos = (cur*cl+1) + j;            % index of the state (i,j) */
        frompos1 = (old*cl+1) + j;            % index of the state (i-1,j) */
        frompos2 = (cur*cl+1) + j-1;          % index of the state (i,j-1) */
        frompos3 = (old*cl+1) + j-1;          % index of the state (i-1,j-1) */

        % Doing the updates, in two steps
        aux= LOGP (logM(frompos1),logM(frompos2) );
        logM(curpos) = LOGP( aux , logM(frompos3) ) + grammat(i,j);
    end  % end of j=1:nY loop */
    % Update the culumn order */
    cur = 1-cur;
    old = 1-old;
end
logkernel=logM(curpos);

function t= LOGP(x,y) 
if x>y,
    t=x+log1p(exp(y-x));
else
    t=y+log1p(exp(x-y));
end
