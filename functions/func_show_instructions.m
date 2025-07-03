function func_show_instructions(app)
try
    num_items = 9;
    
    if strcmp(app.switch_instructions.Value,'On')
        for idx = 1:num_items
            txt_cmd = ['app.txt_instruction_',num2str(idx),'.Visible=1;'];
            eval(txt_cmd);
        end
    else
        for idx = 1:num_items
            txt_cmd = ['app.txt_instruction_',num2str(idx),'.Visible=0;'];
            eval(txt_cmd);
        end
    end
catch ME
    errordlg(ME.message, 'func_show_instructions');
end