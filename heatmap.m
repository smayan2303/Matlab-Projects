
function [ img ] = heatmap( img, rad )
    %heatmap Generates a heatmap image by using values from rad to set
    %  values in the hue channel for img. Hue values vary smoothly
    %  depending on the corresponding radiation level.
    %     img: a 3-dimensional matrix of numbers representing an image in
    %          RGB (red-green-blue) format, which forms the background
    %          to which the heatmap colors are applied.
    %     rad: a matrix of numbers representing the radiation
    %          measurements, between 0 and 100 millisieverts.
    %          It is has the same width and height as the img parameter.


    % TODO your code here

    %convert the image into hsv format 
    hsvimg = rgb2hsv(img);
    %copy in the hue and saturation channels into other variables
    hue = hsvimg(: , : , 1);
    sat = hsvimg(:,:,2);
    %change the hue and saturation based on the guidelines
    hue = 0.7 - 0.7 .* rad./100.0;
    sat = 1;
    %copy the hue and saturation back into the original image and then
    %convert it back into an rgb format
    hsvimg(:,:,1) = hue;
    hsvimg(:,:,2) = sat;
    img = hsv2rgb(hsvimg);
end

