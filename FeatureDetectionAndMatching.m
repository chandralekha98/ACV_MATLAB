function show_Matched_Features_Montage(grayImgLeft, grayImgRight,matchedPtsLeft, matchedPtsRight)
 % Show matched features in montage
 figure;
 ax = axes;
 showMatchedFeatures(grayImgLeft, grayImgRight, matchedPtsLeft,matchedPtsRight, 'montage', 'Parent', ax);
 title('Matched Features Montage');
 % Show matched features
 figure;
 showMatchedFeatures(grayImgLeft, grayImgRight, matchedPtsLeft,matchedPtsRight);
 title('Matched Features');
end

% Load the images
imgLeft = imread('viprectification_deskLeft.png');
imgRight = imread('viprectification_deskRight.png');
% Convert images to grayscale
grayLeft = im2gray(imgLeft);
grayRight = im2gray(imgRight);
% Detect Harris corners
cornersLeft = detectHarrisFeatures(grayLeft);
cornersRight = detectHarrisFeatures(grayRight);
% Extract features
[features1,valid_points1] = extractFeatures(grayLeft,cornersLeft);
[features2,valid_points2] = extractFeatures(grayRight,cornersRight);
% Match features
matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);
% Display original images
figure;
subplot(1,2,1);
imshow(imgLeft);
title('Original Left Image');
subplot(1,2,2);
imshow(imgRight);
title('Original Right Image');
show_Matched_Features_Montage(grayLeft, grayRight, matchedPoints1,matchedPoints2);