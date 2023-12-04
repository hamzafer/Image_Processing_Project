function[MSE, RMSE, PSNR] = metrics(img, tr)
    diff = double(img) - double(tr);
    MSE = mean(diff(:).^2);
    RMSE = sqrt(MSE);
    PSNR = 20 * log10(255 / sqrt(MSE));
end
