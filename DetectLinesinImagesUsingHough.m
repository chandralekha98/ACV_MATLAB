% Read the "cameraman.tif" image
I = imread('cameraman.tif');
% Convert the image to grayscale if it is not already
if size(I, 3) > 1
 I = rgb2gray(I);
end
% Perform edge detection using the Canny method
BW = edge(I, 'canny', [0.1 0.2]);
% Display the original image and the detected edges
figure;
imshow(I);
title('Original Image');
figure;
imshow(BW);
title('Detected Edges');
% Perform the Hough Transform to detect lines
[H, T, R] = hough(BW);
figure
imshow(imadjust(rescale(H)),[],...
 'XData',T,...
 'YData',R,...
 'InitialMagnification','fit');
xlabel('\theta (degrees)')
ylabel('\rho')
axis on
axis normal
hold on
colormap(gca,pink)
% Find the peaks in the Hough Transform matrix
P = houghpeaks(H, 4, 'Threshold', ceil(0.3 * max(H(:))));
x = T(P(:, 2));
y = R(P(:, 1));
% Find the lines corresponding to the peaks
lines = houghlines(BW, T, R, P, 'FillGap', 9, 'MinLength', 9);
% Sort the lines by length
lineLengths = zeros(length(lines), 1);
for k = 1 : length(lines)
 lineLengths(k) = norm(lines(k).point1 - lines(k).point2);
end
[~, sortedIndices] = sort(lineLengths, 'descend');
sortedLines = lines(sortedIndices);
% Display the original image with the longest 4 lines (legs of the tripod)
figure;
imshow(I);
hold on;
for k = 1 : 4
 xy = [sortedLines(k).point1; sortedLines(k).point2];
 plot(xy(:, 1), xy(:, 2), 'LineWidth', 2, 'Color', 'red');
end
title('Longest 4 Lines (Legs of the Tripod)');