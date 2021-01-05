function  plotin2D( mappedX,train_labels )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

for i=1:length(train_labels)
     gscatter(mappedX(i,1), mappedX(i,2), train_labels(i),'w');
    hold on

    strValues = strtrim(cellstr(num2str(train_labels(i))));
    if train_labels(i)==1
    text(mappedX(i,1), mappedX(i,2),strValues, 'HorizontalAlignment','center', 'VerticalAlignment','middle', 'fontsize', 12,'Color',[1 0 0] );
    elseif train_labels(i)==2
            text(mappedX(i,1), mappedX(i,2),strValues, 'HorizontalAlignment','center', 'VerticalAlignment','middle', 'fontsize', 12,'Color',[0.4 0.6 1]  );
     elseif train_labels(i)==3
             text(mappedX(i,1), mappedX(i,2),strValues, 'HorizontalAlignment','center', 'VerticalAlignment','middle', 'fontsize', 12,'Color' , [1 0.170 0]  );
         elseif train_labels(i)==4
                 text(mappedX(i,1), mappedX(i,2),strValues, 'HorizontalAlignment','center', 'VerticalAlignment','middle', 'fontsize', 12,'Color', [0 1 0] );
             elseif train_labels(i)==5
                     text(mappedX(i,1), mappedX(i,2),strValues, 'HorizontalAlignment','center', 'VerticalAlignment','middle', 'fontsize', 12,'Color',[1 0.1 0.8]  );
                 elseif train_labels(i)==6
                         text(mappedX(i,1), mappedX(i,2),strValues, 'HorizontalAlignment','center', 'VerticalAlignment','middle', 'fontsize', 12,'Color',[0.2 0.4 0.3]  );
                     elseif train_labels(i)==7
                             text(mappedX(i,1), mappedX(i,2),strValues, 'HorizontalAlignment','center', 'VerticalAlignment','middle', 'fontsize', 12,'Color',[0.1 0.4 0.6] );
   elseif train_labels(i)==8
            text(mappedX(i,1), mappedX(i,2),strValues, 'HorizontalAlignment','center', 'VerticalAlignment','middle', 'fontsize', 12,'Color',[0 0 1]  );
      elseif train_labels(i)==9
          text(mappedX(i,1), mappedX(i,2),strValues, 'HorizontalAlignment','center', 'VerticalAlignment','middle', 'fontsize', 12,'Color',[0.67 0.223 0.79]  );
    else
        text(mappedX(i,1), mappedX(i,2),strValues, 'HorizontalAlignment','center', 'VerticalAlignment','middle', 'fontsize', 12,'Color',[0.6 1 0.1]  );
    end

    
end
end

