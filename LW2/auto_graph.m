choose = questdlg('Продолжить выполнение скрипта в автоматическом режиме?', 'Подтверждение выбора', 'Да', 'Нет', 'Да');
file_paths = {};

if strcmp(choose, 'Да')
    disp('Вы выбрали авто режим');    
    excel_files = dir(fullfile('LW2', 'Data', '*.xlsx'));
    csv_files = dir(fullfile('LW2', 'Data', '*.csv'));
    all_files = [excel_files; csv_files];    
    for i = 1:length(all_files)
        file_paths{end+1} = fullfile(all_files(i).folder, all_files(i).name);
    end
else
    disp('Вы выбрали ручной режим');    

    [files, path] = uigetfile({'*.xlsx;*.csv', 'Файлы данных (*.xlsx, *.csv)'}, 'Выберите файлы', 'MultiSelect', 'on');    
    if isequal(files, 0) || isequal(path, 0)
        error('Выбор отменен. Выполнение скрипта прекращено.');
    end
    if ischar(files)
        files = {files}; 
    end
    for i = 1:length(files)
        file_paths{end+1} = fullfile(path, files{i});
    end
end

if isempty(file_paths)
    error('Файлы не найдены.');
end

disp(' ');
disp('---------- Список файлов -----------');
for i = 1:length(file_paths)
    fprintf('%d. %s\n', i, file_paths{i});
end
disp('------------------------------------');


confirm = questdlg('Список файлов сформирован. Начать построение графиков?','Подтверждение', 'Начать', 'Отмена', 'Начать');

if strcmp(confirm, 'Отмена')
    disp('Выполнение отменено пользователем.');
    return;
end


for i = 1:length(file_paths)
    current_file = file_paths{i};
   
    try
        
        data_table = readtable(current_file, 'VariableNamingRule', 'preserve');
        
        
        if width(data_table) >= 2
            
  
            [~, filename, ext] = fileparts(current_file);
            
           
            figure('Name', ['График: ' filename ext], 'NumberTitle', 'off');
            
            
            plot(data_table{:, 1}, data_table{:, 2}, 'LineWidth', 1.5);
            
            title(['Данные из: ' filename ext], 'Interpreter', 'none');
            xlabel(data_table.Properties.VariableNames{1}, 'Interpreter', 'none'); % Имя 1-й колонки на ось X
            ylabel(data_table.Properties.VariableNames{2}, 'Interpreter', 'none'); % Имя 2-й колонки на ось Y
            grid on;
            
        else
            warning(['В файле ' current_file ' хрень.']);
        end
    catch Error
        warning(['этот файл хрень ' current_file '. Ошибка: ' Error.message]);
    end
end