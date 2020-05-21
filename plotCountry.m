% This function plots individual country data, overlaid on each other. It
% plots onto the GRAPH tab in main.mlapp.
% main.mlapp data is inputted and modified.

function plotCountry(app)

% initialize Day number and number of countries to plot
index = round(app.DaySlider.Value);
top = app.topCountries.Value;   % Number of countries to plot
days = [1:index];               % Range of days to plot

% update date picker to match slider
app.AsofDatePicker.Value = datetime(app.dates(index),'InputFormat','M/d/yy','Format','dd-MMM-yyyy');

% update slider label
app.DaySliderLabel.Text = ['Day ',num2str(index)];

% sort total cases and country name
cases = table2array(app.globalCC(:,2));
totalCases = cases(:,index);
[~,I] = sort(totalCases,'descend'); % index of sorted total cases
sortCountry = table2array(app.globalCC(I,1));

% initialize country array for data tips
country = num2cell(zeros(1,index));

% set up color array
C = parula(top+1);   

% LOOP TO PLOT ON GRAPH AXES
for n = 1:top
    p(n) = plot(app.graphAxes,days,cases(I(n),days),'Color',C(n,:));
    country(:) = sortCountry(n);
    
    % rearrange and edit data tips
    p(n).DataTipTemplate.DataTipRows(1).Label = 'Day';
    p(n).DataTipTemplate.DataTipRows(2).Label = 'Cases';
    p(n).DataTipTemplate.DataTipRows(end+1) = p(n).DataTipTemplate.DataTipRows(2);
    p(n).DataTipTemplate.DataTipRows(2) = p(n).DataTipTemplate.DataTipRows(1);
    p(n).DataTipTemplate.DataTipRows(1) = dataTipTextRow('Country',country);
    
    % line width
    p(n).LineWidth = 1.3; 
    
    hold(app.graphAxes,'on');
end
hold(app.graphAxes,'off');


% legend properties
lgd = legend(app.graphAxes,sortCountry(1:top),'Location','northwest');
lgd.Title.String = ['Top ',num2str(top),' Highest Cases'];
lgd.Title.FontSize = 10;
lgd.Box = 'off';

end
