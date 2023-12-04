%% Function for image segmentation

function [segmented] = f_segmentation(img)

segmented = img;
% Initialize cutoff points: 1-78, 79-125, 126-255
first_point = 78;
second_point = 125;
% Segment image into 3 parts
segmented(img < first_point) = 0;
segmented(first_point <= img & img < second_point) = 128;
segmented(img >= second_point) = 255;
% Save the result
imwrite(segmented, "segmented.png")

end
