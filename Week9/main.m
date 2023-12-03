% Path to the image file
imagePath = 'image_gs.png';

% Call the converttToGrayscale function
grayImage = convertToGrayscale(imagePath);
doubleGrayImage = im2double(grayImage);
