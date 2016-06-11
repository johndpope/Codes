track_cup = [ 135 152 41 55];
track_ball = [215 84 15 25 ];         % TODO Pick a bounding box in the format [x y w h]

%% Initialize the tracker
figure;

prev_frame = imread('../data/car/frame0020.jpg');

% Pick one of the above
tracker = track_cup(:);

%% Initialize the tracker
figure;

prev_frame = imread('../data/desk/frame001.png');
ve = VideoWriter('newfile.avi');
open(ve)
%% Start tracking
new_tracker = tracker;
for i = 2:145
    new_frame = imread(sprintf('../data/desk/frame%03d.png', i)) ;
    [u, v] = LucasKanade(prev_frame, new_frame, tracker);
    new_tracker(1) = tracker(1) + u
    new_tracker(2) = tracker(2) + v

%     new_tracker(1) = u
%     new_tracker(2) = v

    clf;
    hold on;
    imshow(new_frame);   
    rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
    drawnow;
    A=getframe ;
    A1=(A.cdata) ;
    writeVideo(ve,A1) ;
    prev_frame = new_frame;
    tracker = new_tracker;
end
close(ve)
