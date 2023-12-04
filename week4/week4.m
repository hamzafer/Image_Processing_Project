function[bests] = week4(image)

    salt_pepper = imnoise(image,'salt & pepper',rand(1));
    speckle = imnoise(image,'speckle',.2);
    windowWidth = round(10*rand(1));
    kernel = ones(windowWidth) / windowWidth ^ 2;
    blurredImage = imfilter(image, kernel); 
    name = {"Median", "Mean", "Laplacian", "Sharpening", "Laplacian", "Sharpening"};
    bests = {};

    medianF1 = medianFilter(salt_pepper, 3);
    diff1 = sum(sum((image - medianF1).^2));
    meanF1 = meanFilter(salt_pepper, 3);
    diff2 = sum(sum(abs(image - meanF1).^2));
    [sh11, sh12, sh13, sh14] = sharpening(salt_pepper);
    sh11 = image - sh11; 
    sh12 = image - sh12; 
    sh13 = image - sh13; 
    sh14 = image - sh14; 
    diff3 = sum(sum((image - sh11).^2));
    diff4 = sum(sum((image - sh12).^2));
    diff5 = sum(sum((image - sh13).^2));
    diff6 = sum(sum((image - sh14).^2));
    [~, idx] = min([diff1, diff2, diff3, diff4, diff5, diff6]);
    methods = {medianF1, meanF1, sh11, sh12, sh13, sh14};
    bests{1} = name{idx};
    best1 = methods{idx};

    medianF2 = medianFilter(speckle, 3);
    diff1 = sum(sum((image - medianF2).^2));
    meanF2 = meanFilter(speckle,3);
    diff2 = sum(sum((image - meanF2).^2).^2);
    [sh21, sh22, sh23, sh24] = sharpening(speckle);
    sh21 = image - sh21; 
    sh22 = image - sh22; 
    sh23 = image - sh23; 
    sh24 = image - sh24; 
    diff3 = sum(sum((image - sh21).^2));
    diff4 = sum(sum((image - sh22).^2));
    diff5 = sum(sum((image - sh23).^2));
    diff6 = sum(sum((image - sh24).^2));
    [~, idx] = min([diff1, diff2, diff3, diff4, diff5, diff6]);
    methods = {medianF2, meanF2, sh21, sh22, sh23, sh24};
    bests{2} = name{idx};
    best2 = methods{idx};

    medianF3 = medianFilter(blurredImage, 3);
    diff1 = sum(sum((image - medianF3).^2));
    meanF3 = meanFilter(blurredImage, 3);
    diff2 = sum(sum((image - meanF3).^2));
    [sh31, sh32, sh33, sh34] = sharpening(blurredImage);
    sh31 = image - sh31; 
    sh32 = image - sh32; 
    sh33 = image - sh33; 
    sh34 = image - sh34; 
    diff3 = sum(sum((image - sh31).^2));
    diff4 = sum(sum((image - sh32).^2));
    diff5 = sum(sum((image - sh33).^2));
    diff6 = sum(sum((image - sh34).^2));
    [~, idx] = min([diff1, diff2, diff3, diff4, diff5, diff6]);
    methods = {medianF3, meanF3, sh31, sh32, sh33, sh34};
    bests{3} = name{idx};
    best3 = methods{idx};

    [Gx, Gy] = gradientCalc(image);

    magnitude = Gx.^2 - Gy.^2;

    fig = figure;
    imshow(Gx); % showing results compared to the original image
    title('Gradient X');
    saveas(fig, 'gradientx2.jpg');
    
    fig = figure;
    imshow(Gy); % showing results compared to the original image
    title('Gradient Y');
    saveas(fig, 'gradienty2.jpg');

    fig = figure;
    imshow(magnitude); % showing results compared to the original image
    title('Magnitude');
    saveas(fig, 'magnitude.jpg');
    
    fig = figure;

    % Plot Gradient X
    subplot(1, 3, 1); % This means 1 row, 3 columns, and this plot is the 1st.
    imshow(Gx);
    title('Gradient X');
    
    % Plot Gradient Y
    subplot(1, 3, 2); % This plot is the 2nd.
    imshow(Gy);
    title('Gradient Y');
    
    % Plot Magnitude
    subplot(1, 3, 3); % This plot is the 3rd.
    imshow(magnitude);
    title('Magnitude');
    
    % Save the figure
    saveas(fig, 'combined_gradients.jpg');


    % Create subplots for salt & pepper denoising results
    fig1 = figure;
    subplot(1, 3, 1);
    imshow(salt_pepper);
    title('Distorted Image (Salt & Pepper)');

    subplot(1, 3, 2);
    imshow(best1);
    title(['Best Denoising: ' bests{1}']);

    subplot(1, 3, 3);
    imshow(image - best1);
    title('Difference (Original - Best Denoising)');

    % Create subplots for speckle denoising results
    fig2 = figure;
    subplot(1, 3, 1);
    imshow(speckle);
    title('Distorted Image (Speckle)');

    subplot(1, 3, 2);
    imshow(best2);
    title(['Best Denoising: ' bests{2}']);

    subplot(1, 3, 3);
    imshow(image - best2);
    title('Difference (Original - Best Denoising)');

    % Create subplots for deblurring results
    fig3 = figure;
    subplot(1, 3, 1);
    imshow(blurredImage);
    title('Blurred Image');

    subplot(1, 3, 2);
    imshow(best3);
    title(['Best Deblurring: ' bests{3}']);

    subplot(1, 3, 3);
    imshow(image - best3);
    title('Difference (Original - Best Deblurring)');

    % Save the figures
    saveas(fig1, 'saltpepper_denoising_comparison.jpg');
    saveas(fig2, 'speckle_denoising_comparison.jpg');
    saveas(fig3, 'deblurring_comparison.jpg');
end