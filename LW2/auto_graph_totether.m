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
    %Вот это чтобы не ругался н 1 файл
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


figure('Name', 'Сравнение данных из файлов', 'NumberTitle', 'off');
grid on; 
hold on; 


plot_labels = {};

for i = 1:length(file_paths)
    current_file = file_paths{i};
    try
        data_table = readtable(current_file, 'VariableNamingRule', 'preserve');
        if width(data_table) >= 2
            [~, filename, ext] = fileparts(current_file);
            
            plot(data_table{:, 1}, data_table{:, 2}, 'LineWidth', 1.5);            
            plot_labels{end+1} = [filename ext]; 
        else
            warning('Файл %s  менее 2 колонок', current_file);
        end
    catch ME
        warning(' файл %s хрень. Ошибка: %s', current_file, ME.message);
    end
end

hold off; 

if ~isempty(plot_labels)
    title('МНОГО ГРАФИКОВ');
    xlabel('ВЕЛИЧИНА, у.е.'); 
    ylabel('ВЕЛИЧИНА2, у.е.'); 
    legend(plot_labels, 'Interpreter', 'none', 'Location', 'best'); 
else
    close; 
    error('Не удалось построить ни одного графика.');
end
