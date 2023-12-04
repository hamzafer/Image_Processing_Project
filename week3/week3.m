function[] = week3(image)
    % Read and process the original image
    ref = imread("week1_original.png"); % read the original image
    refGray = rgb2gray(ref); % transform to grayscale

    % Process the input image
    if size(image, 3) == 3 % check if the provided image is color
        image = rgb2gray(image); % Convert to grayscale
    end

    % Histogram matching
    result1 = histogramMatching(image, refGray, true); % Match to the original histogram

    % Create a random histogram
    randomHist = rand(256, 1);
    result2 = histogramMatching(image, floor(randomHist*255), false); % Match to the random histogram

    % Plotting
    % Original Image and Histogram
    figure;
    subplot(2, 2, 1);
    imshow(ref);
    title('Original Image');
    subplot(2, 2, 2);
    bar(histogramCalc(refGray)); % Using histogramCalc for histogram
    title('Histogram of Original Image');

    % Target Image and Histogram
    subplot(2, 2, 3);
    imshow(image);
    title('Target Image');
    subplot(2, 2, 4);
    bar(histogramCalc(image)); % Using histogramCalc for histogram
    title('Histogram of Target Image');

    % Matched Image and Histogram (to Original)
    figure;
    subplot(1, 2, 1);
    imshow(result1);
    title('Image Matched to Original Histogram');
    subplot(1, 2, 2);
    bar(histogramCalc(result1)); % Using histogramCalc for histogram
    title('Histogram of Matched Image (Original)');

    % Matched Image and Histogram (to Random)
    figure;
    subplot(1, 2, 1);
    imshow(result2);
    title('Image Matched to Random Histogram');
    subplot(1, 2, 2);
    bar(histogramCalc(result2)); % Using histogramCalc for histogram
    title('Histogram of Matched Image (Random)');
end
