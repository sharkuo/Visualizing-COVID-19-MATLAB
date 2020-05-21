% This function loads and sorts downloaded data from the JHU COVID-19 repository.
% It modifies a number of public properties in main.mlapp, storing data in
% there.

function loadData(app)
addpath('data/COVID-19-master/csse_covid_19_data/csse_covid_19_time_series/');

% Import data from downloaded spreadsheets
CC = importdata('time_series_covid19_confirmed_global.csv');    % confirmed global cases
US = importdata('time_series_covid19_confirmed_US.csv');        % confirmed US cases
DD = importdata('time_series_covid19_deaths_global.csv');       % global deaths
RC = importdata('time_series_covid19_recovered_global.csv');    % global recovered

% Fix certain country names
CC.textdata{strcmp('Taiwan*',CC.textdata)} = 'Taiwan';
CC.textdata{strcmp('Korea, South',CC.textdata)} = 'South Korea';

% Import data in table format
app.fullGlobal = readtable('time_series_covid19_confirmed_global.csv'); 
app.fullUS = readtable('time_series_covid19_confirmed_US.csv');
app.fullUS(1,:) = [];

% Extract desired data (sorted by country/region)
app.dates = CC.textdata(1,5:end);             % timestamp dates
app.countries = CC.textdata(2:end,2);         % all countries
app.lat = CC.data(:,1);                       % latitude and longitude data
app.long = CC.data(:,2);

app.confirmed = CC.data(:,3:end);             % confirmed cases
app.deaths = DD.data(:,3:end);                % deaths
app.recov = RC.data(:,3:end);                 % recovered

% Aggregate data by COUNTRY only; sums data from regions of a country
t = table(app.countries,app.confirmed);
app.globalCC = groupsummary(t,'Var1','sum');  
app.globalCC(:,2)=[];

end