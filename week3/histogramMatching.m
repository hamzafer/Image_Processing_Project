function [matchedImg] = histogramMatching(img1, img2, options)
    if options == true
        [~, probs1] = histogramEq(histogramCalc(img1), img1, 8);
        [~, probs2] = histogramEq(histogramCalc(img2), img2, 8);
    else
        [~, probs1] = histogramEq(histogramCalc(img1), img1, 8);
        probs2 = img2;
    end
    % create a mapping for each intensity level
    map = zeros(256, 1, 'uint8');
    for i = 1:256 % intensity levels of source image
        min = inf;
        closestIndex = 1;
        for j = 1:256 % intensity levels of reference image
            diff = abs(probs1(i) - probs2(j)); 
            if diff < min
                min = diff;
                closestIndex = j; % finding closest corresponding intensity level
            end
        end
        map(i) = closestIndex - 1;
    end

    % apply mapping to img1
    matchedImg = map(double(img1) + 1);
end
