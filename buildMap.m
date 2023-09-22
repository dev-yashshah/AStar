function map=buildMap(fileName,rows,cols)
    img=imread(fileName);
    img_x=size(img,1);
    img_y=size(img,2);
    
    if rows>img_x
        fprintf("Rows greater than image size_x. considering rows as "+img_x+"\n")
        rows=img_x;
    end
    if cols>img_y
        fprintf("Cols greater than image size_y. considering cols as "+img_y+"\n")
        cols=img_y;
    end

    if rows<=0
        fprintf("Rows less than / equal to 0. considering rows as "+img_x+"\n")
        rows=img_x;
    end
    if cols<=0
        fprintf("Cols less than / equal to 0. considering cols as "+img_y+"\n")
        cols=img_y;
    end
    
    map1=ones(img_y,img_x);
    for i=1:img_x
        for j=1:img_y
            map1(j,img_x-i+1)=img(i,j);
        end
    end

    map=ones(cols,rows);
    step_size_y=img_y/cols;
    step_size_x=img_x/rows;
    for i=1:cols
        for j=1:rows
            tmp=map1(floor((i-1)*step_size_y+1):floor(i*step_size_y),floor((j-1)*step_size_x+1):floor(j*step_size_x));
            if any(tmp(:)==0)
                map(i,j)=0;
            end
        end
    end
end