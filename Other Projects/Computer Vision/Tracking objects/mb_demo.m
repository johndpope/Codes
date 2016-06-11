tracker = [400 50 200 100]         % TODO Pick a bounding box in the format [x y w h]
addpath ../data/landing
%% Initialize the tracker
figure;

% TODO run the Matthew-Baker alignment in both landing and car sequences
prev_frame = imread('../data/landing/frame0190_crop.jpg');
template = imread('../data/landing/frame0190_crop.jpg');  % TODO
Win = [1 0 0 ; 0 1 0 ; 0 0 1 ] ;        % TODO

context = initAffineMBTracker(prev_frame, tracker);
ve = VideoWriter('newfile.avi');
open(ve)

%% Start tracking
new_tracker = tracker;
for i = 191:308
    if exist(sprintf('frame0%03d_crop.jpg',i), 'file')==2
    im = imread(sprintf('../data/landing/frame0%03d_crop.jpg', i));
    Wout = affineMBTracker(im, template, tracker, Win, context) ;
%    new_tracker = [tracker(1)+Wout(1,3)  tracker(2)+Wout(2,3) tracker(3) tracker(4)] ; % TODO calculate the new bounding rectangle
    tt = Wout*[tracker(1) ; tracker(2) ; 1] ;
    new_tracker = [tt(1)  tt(2) tracker(3) tracker(4)] ;
    clf;
    hold on;
    imshow(im);   
    rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
    drawnow;
    A=getframe ;
    A1=(A.cdata) ;
    writeVideo(ve,A1) ;    

    prev_frame = im;
    tracker = new_tracker;
    end
end

close(ve)