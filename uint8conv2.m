function result = uint8conv2(image_gray, filter)
result = uint8(conv2(double(image_gray), double(filter),'same'));
