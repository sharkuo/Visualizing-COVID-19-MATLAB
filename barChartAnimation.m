% This function creates a timelapse animation of the pandemic through a
% racing bar chart. It plots it onto the timelapse axes in TIMELAPSE tab of
% main.mlapp. The 'update' input determines if the barchart needs animating 
% or just setup. main.mlapp app data is inputted and modified.

function barChartAnimation(app,update)
%% SET UP
% Set up variables
saveImage = strcmp(app.saveImage.Value,'On'); % save image on or off
nC = app.nC.Value;          % number of countries to display at once
nDays = length(app.dates);	% total number of days
cases = table2array(app.globalCC(:,2)); % country data

% Axes Properties
app.timelapseAxes.YLim = [0 app.nC.Value+1];

% Initialize data arrays
rank = zeros(size(cases));
sortCountry = cell(size(cases));
sortCase = zeros(size(cases));

% Sort and process data by country
for n = 1:nDays
  totalCases = cases(:,n);
  [sortCase(:,n),I] = sort(totalCases,'descend'); % index of sorted total cases
  sortCountry(:,n) = table2array(app.globalCC(I,1)); % sort country names
  rank(I,n) = 1:height(app.globalCC); % country rankings per day
end

% Plot initial data (horizontal bar)
bar = barh(app.timelapseAxes,sortCase(1:nC));

% Set up country labels
countryText = string(sortCountry(1:nC)); 
xTextPos = sortCase(1:nC) + max(sortCase(1:nC))*0.015;  % x and y pos
yTextPos = bar.XData(:);
label = text(app.timelapseAxes,xTextPos,yTextPos,countryText);

% Interpolation of rank and case data for smoother animation
times = linspace(1,nDays,nDays*5);
plotRank = interp1(1:nDays,transpose(rank),times);
plotCase = interp1(1:nDays,transpose(sortCase),times);

% Set up color
bar.FaceColor = 'flat';
colors = parula(height(app.globalCC));  % assign each country a color
bar.CData = colors(I(1:10),:); % set initial color data 

% Fix bar width
defaultWidth = 0.8; 


%% ANIMATE 
if update == 1  % no animation at startup
    
    % LOOP through timestamps to animate
    for n = 2:length(plotRank)  
        [bar.XData,i] = mink(plotRank(n,:),nC); % update XData
        bar.YData = maxk(plotCase(n,:),nC);     % update YData
        bar.CData = colors(i,:);                % update CData
        
        % update label string and position
        x = bar.YData + max(bar.YData)*0.015;
        y = bar.XData(:);
        c = round(n/5); % round to country index
        if c < 1
            c = 1;      % cannot have zero index
        end
        for m = 1:nC   % for each individual country
            label(m).String = string(sortCountry(m,c)); % update country label
            label(m).Position = [x(m) y(m)];            % update label position
        end
        
        % fix bar width
        scaleWidth = min(diff(sort(bar.XData)));
        bar.BarWidth = defaultWidth/scaleWidth;
        
        % update axes limits
        app.timelapseAxes.XLim = [0, max(bar.YData)*1.1];
        
        % update date label
        app.timelapseDate.Text = ['Day ',num2str(c)];
        app.timelapseDate2.Text = datestr(datetime(app.dates(c),'InputFormat','M/d/yy','Format','MMMM d, yyyy'));
             
        % update graphics
        drawnow limitrate
    end
    
    % save image if selected
    if saveImage
        exportgraphics(app.timelapseAxes,'COVID19_Bar_Chart.jpg','Resolution',300)
    end
end


end

