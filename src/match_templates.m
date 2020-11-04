function templates_ID=match_templates(templates,ids)
%Here we loop through the template structure to exctract 
%templates with the same ID
%----------------------------------------------------------

%first find templates with the same id
j=1; 
for ii=1:length(templates)
    if templates(ii).ID==ids;
        templates_ID(j)=templates(ii);
        j=j+1;
        
    end
    
end

end