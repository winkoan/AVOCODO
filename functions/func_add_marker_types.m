function func_add_marker_types(app)

% Get input for marker types
prompt = {'Enter marker types (multiple types separated by comma):'};
dlgtitle = 'Input';
fieldsize = [1 60];
%definput = {''};
if ~isempty(app.txt_marker_type.Items)
    definput = join(app.txt_marker_type.Items,',');
else
    definput = {''};
end

answer = inputdlg(prompt,dlgtitle,fieldsize,definput);%prompt to ask input
answer = strrep(answer,' ','');%remove space

types = split(answer{1},',');

try
    app.txt_marker_type.Items = types;
catch

end
