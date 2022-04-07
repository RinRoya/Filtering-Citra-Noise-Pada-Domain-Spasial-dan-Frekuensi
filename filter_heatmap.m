function filter_heatmap(filter)
h = heatmap(filter,'ColorbarVisible','off','Colormap',gray,...
            'XDisplayLabels',nan(1,length(filter)),'YDisplayLabels',...
            nan(1,length(filter))); title('Filter');
if isequal(zeros(length(filter)),filter)
   title('Filter tidak tersedia');
   h.CellLabelColor = 'none';
end
