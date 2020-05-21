% This function plots the interactive world map and geobubble plot onto the
% map panel in main.mlapp. main.mlapp app data is inputted and modified.
% Given a date, the function sifts through data to update the statistics
% panel and plots it onto the map.

function plotMap(app)
%% Statistics Panel

% update date labels
app.DATELabel.Text = char(app.newdate);
app.DatePicker.Value = app.newdate;

% find and index the upper limit date
newdate = app.newdate;
newdate.Format = 'M/d/yy';
index = find(newdate == app.dates);

% compute global statistics (confirmed, deaths, recovered, active)
confirmed = sum(app.confirmed(:,index));
deaths = sum(app.recov(:,index));
recov = sum(app.recov(:,index));
active = confirmed - deaths - recov;

% update stats on panel in comma seperated format
jf = java.text.DecimalFormat; % comma for thousands, three decimal places
app.ConfirmedNum.Text = char(jf.format(confirmed));
app.DeathsNum.Text = char(jf.format(deaths));
app.ActiveNum.Text = char(jf.format(active));
app.RecoveredNum.Text = char(jf.format(recov));


%% Plot Map

% find US index in global dataset
US_index = find(strcmp('US',app.countries));

lat = app.lat;                      % latitude
long = app.long;                    % longitude
cases = app.confirmed(:,index);     % cases

% remove total US data (will replace with US data by PROVINCE)
lat(US_index) = [];
long(US_index) = [];
cases(US_index) = [];

% aggregate US lat, long, cases by PROVINCE/STATE
total = app.fullUS.Properties.VariableNames{index+11};   % rename var last column
byProvince = groupsummary(app.fullUS,'Var7',{'mean','sum'},{'Var9','Var10',total});

% add US data by province/state into full array
fullLat = [lat; byProvince{:,3}];
fullLong = [long; byProvince{:,5}];
app.cases = [cases; byProvince{:,8}];

% geobubble plot confirmed cases by REGION (including US by Province)
Cases = discretize(app.cases,10,'categorical');
app.gb = geobubble(app.mapPanel,fullLat,fullLong,app.cases,...
    'MapLayout','maximized','BubbleWidthRange',[1 20],...
    'BubbleColorList',app.gb.BubbleColorList,'ColorData',Cases,'LegendVisible','off',...
    'Basemap',app.gb.Basemap);


end