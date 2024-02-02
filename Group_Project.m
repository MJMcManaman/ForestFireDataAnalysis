% Dataset: Algerian Forest Fire Dataset
% Group members: Michelle McManaman, Dongwang Lang, Hang Yang, Ibrar Sandhu


% manually inserting the values for the missing delimiter on Bejaia region
data=readtable('Algerian_forest_fires_dataset.csv');
data{168,10}=14.6;
data{168,11}=9;
data{168,12}=12.5;
data{168,13}=10.4;
data{168,14}={'fire'};

% Grouping data
% applied varaible names, easier for us to see/understand
data=renamevars(data,["BejaiaRegionDataset","Var2","Var3","Var4","Var5","Var6","Var7","Var8","Var9","Var10","Var11","Var12","Var13","Var14"], ...
    ["DateNumber","Month","Year","Temperature","Relative Humidity","Wind Speed","Rain","Fine Fuel Moisture Code","Duff Moisture Code","Drought Code","Initial Spread","Buildup Index","Fire Weather Index","Result"]);

% whole data
t=data;
t.Result=categorical(t.Result); % categorized
head(t)
fire_data=t(t.Result == 'fire',:);
not_fire_data=t(t.Result == 'not fire',:);
fire_data.Properties.VariableUnits={' ',' ',' ','Celsius','percentage(%)','Km/h','mm',' ',' ',' ',' ',' ',' ',' '};
% summary for fire data
fire_data_summary=summary(fire_data(:,4:13));
% summary for non-fire data
not_fire_data_summary=summary(not_fire_data(:,4:13));

% summary displayed in the command window
% bejaia data
data_bejaia=data(1:122,:);
summary(data_bejaia(:,4:13));
% sidibel data
data_sidibel=data(125:end,:);
summary(data_sidibel(:,4:13));
% standard deviation for both region from temperature (var4) to FWI index (var13)
std_bejaia=varfun(@std,data_bejaia(:,4:13),'InputVariables',@isnumeric);
std_sidibel=varfun(@std,data_sidibel(:,4:13),'InputVariables',@isnumeric);
% standard deviation for fire and not fire of both region from temperature (var4) to FWI index (var13)
std_fire=varfun(@std,fire_data(:,4:13),'InputVariables',@isnumeric);
std_not_fire=varfun(@std,not_fire_data(:,4:13),'InputVariables',@isnumeric);

% Pie chart for each region whether it's fire or not fire
% a is'Bejaia Region Dataset', b is 'Sidi-Bel Abbes Region Dataset'
a =data((1:122),:) ; 
a.Result=categorical(a.Result);
fire_data_a=a(a.Result == 'fire',:);
not_fire_data_a=a(a.Result == 'not fire',:);
b = t((125:end),:) ;
b.Result=categorical(b.Result);
fire_data_b=b(b.Result == 'fire',:);
not_fire_data_b=b(b.Result == 'not fire',:);
r = a(:,14);
figure('Name','Pie chart for the whole dataset between fire & not fire','NumberTitle','off')
subplot(2,1,1)
% pie chart for bejaia region
pie(a.Result)
title("Bejaia Region Dataset")
subplot(2,1,2)
% pie chart for sidibel region
pie(b.Result)
title("Sidi-Bel Abbes Region Dataset")

% differentiate on one graph
figure('Name','Relations between attributes','NumberTitle','off')
subplot(2,5,1)
plot(fire_data,"Temperature",'Color','r')
hold on
plot(not_fire_data,"Temperature",'Color','g')
hold off
legend("fire","not fire")
xlabel("Days")
ylabel("Temperature(in Celcius)")
title("Temperature")

subplot(2,5,2)
plot(fire_data,"Relative Humidity",'Color','r')
hold on
plot(not_fire_data,"Relative Humidity",'Color','g')
hold off
legend("fire","not fire")
xlabel("Days")
ylabel("Percentage")
title("Relative Humidity")

subplot(2,5,3)
plot(fire_data,"Wind Speed",'Color','r')
hold on
plot(not_fire_data,"Wind Speed",'Color','g')
hold off
legend("fire","not fire")
xlabel("Days")
ylabel("Kilomoters/Hour(KM/H)")
title("Wind Speed")

subplot(2,5,4)
plot(fire_data,"Rain",'Color','r')
hold on
plot(not_fire_data,"Rain",'Color','g')
hold off
legend("fire","not fire")
xlabel("Days")
ylabel("Millimeter(mm)")
title("Rain")

subplot(2,5,5)
plot(fire_data,"Fine Fuel Moisture Code",'Color','r')
hold on
plot(not_fire_data,"Fine Fuel Moisture Code",'Color','g')
hold off
legend("fire","not fire")
xlabel("Days")
ylabel("Scale from FWI system")
title("Fine Fual Moisture Code")

subplot(2,5,6)
plot(fire_data,"Duff Moisture Code",'Color','r')
hold on
plot(not_fire_data,"Duff Moisture Code",'Color','g')
hold off
legend("fire","not fire")
xlabel("Days")
ylabel("Scale from FWI system")
title("Duff Moisture Code")

subplot(2,5,7)
plot(fire_data,"Drought Code",'Color','r')
hold on
plot(not_fire_data,"Drought Code",'Color','g')
hold off
legend("fire","not fire")
xlabel("Days")
ylabel("Scale from FWI system")
title("Drought Code")

subplot(2,5,8)
plot(fire_data,"Initial Spread",'Color','r')
hold on
plot(not_fire_data,"Initial Spread",'Color','g')
hold off
legend("fire","not fire")
xlabel("Days")
ylabel("Scale from FWI system")
title("Initial Spread")

subplot(2,5,9)
plot(fire_data,"Buildup Index",'Color','r')
hold on
plot(not_fire_data,"Buildup Index",'Color','g')
hold off
legend("fire","not fire")
xlabel("Days")
ylabel("Scale from FWI system")
title("Buildup Index")

subplot(2,5,10)
plot(fire_data,"Fire Weather Index",'Color','r')
hold on
plot(not_fire_data,"Fire Weather Index",'Color','g')
hold off
legend("fire","not fire")
xlabel("Days")
ylabel("Scale from FWI system")
title("Fire Weather Index")

% fire box plot
data(:,["DateNumber","Temperature","Relative Humidity","Wind Speed","Rain","Fine Fuel Moisture Code","Duff Moisture Code","Drought Code","Initial Spread","Buildup Index","Fire Weather Index","Result"])
unique(data.Result)
idx=contains(data.Result,'fire');
fire_region=data(idx,:);
% each plot
figure('Name','Box plot between fire classes and each attributes','NumberTitle','off')
subplot(2,5,1)
boxchart(fire_region.DateNumber,fire_region.Temperature)
xlabel('Days')
ylabel('Temperature')

subplot(2,5,2)
boxchart(fire_region.DateNumber,fire_region.("Relative Humidity"))
xlabel('Days')
ylabel('Relative Humidity')

subplot(2,5,3)
boxchart(fire_region.DateNumber,fire_region.("Wind Speed"))
xlabel('Days')
ylabel('Wind speed')

subplot(2,5,4)
boxchart(fire_region.DateNumber,fire_region.Rain)
xlabel('Days')
ylabel('Rain')

subplot(2,5,5)
boxchart(fire_region.DateNumber,fire_region.("Fine Fuel Moisture Code"))
xlabel('Days')
ylabel('Fine Fuel Moisture Code')

subplot(2,5,6)
boxchart(fire_region.DateNumber,fire_region.("Duff Moisture Code"))
xlabel('Days')
ylabel('Duff Moisture Code')

subplot(2,5,7)
boxchart(fire_region.DateNumber,fire_region.("Drought Code"))
xlabel('Days')
ylabel('Drought Code')

subplot(2,5,8)
boxchart(fire_region.DateNumber,fire_region.("Initial Spread"))
xlabel('Days')
ylabel('Initial spread')

subplot(2,5,9)
boxchart(fire_region.DateNumber,fire_region.("Buildup Index"))
xlabel('Days')
ylabel('Buildup Index')

subplot(2,5,10)
boxchart(fire_region.DateNumber,fire_region.("Fire Weather Index"))
xlabel('Days')
ylabel('Fire weather index')

% not fire box plot
figure('Name','Box plot between not fire classes and each attributes','NumberTitle','off')
subplot(2,5,1)
boxchart(fire_region.DateNumber,fire_region.Temperature)
xlabel('Days')
ylabel('Temperature')

subplot(2,5,2)
boxchart(fire_region.DateNumber,fire_region.("Relative Humidity"))
xlabel('Days')
ylabel('Relative Humidity')

subplot(2,5,3)
boxchart(fire_region.DateNumber,fire_region.("Wind Speed"))
xlabel('Days')
ylabel('Wind speed')

subplot(2,5,4)
boxchart(fire_region.DateNumber,fire_region.Rain)
xlabel('Days')
ylabel('Rain')

subplot(2,5,5)
boxchart(fire_region.DateNumber,fire_region.("Fine Fuel Moisture Code"))
xlabel('Days')
ylabel('Fine Fuel Moisture Code')

subplot(2,5,6)
boxchart(fire_region.DateNumber,fire_region.("Duff Moisture Code"))
xlabel('Days')
ylabel('Duff Moisture Code')

subplot(2,5,7)
boxchart(fire_region.DateNumber,fire_region.("Drought Code"))
xlabel('Days')
ylabel('Drought Code')

subplot(2,5,8)
boxchart(fire_region.DateNumber,fire_region.("Initial Spread"))
xlabel('Days')
ylabel('Initial spread')

subplot(2,5,9)
boxchart(fire_region.DateNumber,fire_region.("Buildup Index"))
xlabel('Days')
ylabel('Buildup Index')

subplot(2,5,10)
boxchart(fire_region.DateNumber,fire_region.("Fire Weather Index"))
xlabel('Days')
ylabel('Fire weather index')

% trend of each attribute between fire and not fire
figure('Name','trend between fire/not fire classes and each attributes','NumberTitle','off')
subplot(5,2,1)
plot(trenddecomp(fire_data.Temperature))
hold on
plot(trenddecomp(not_fire_data.Temperature))
hold off
legend("fire","not fire")
xlabel('Days')
ylabel('Temperature')

subplot(5,2,2)
plot(trenddecomp(fire_data.("Relative Humidity")))
hold on
plot(trenddecomp(not_fire_data.("Relative Humidity")))
hold off
legend("fire","not fire")
xlabel('Days')
ylabel('Relative Humidity')

subplot(5,2,3)
plot(trenddecomp(fire_data.("Wind Speed")))
hold on
plot(trenddecomp(not_fire_data.("Wind Speed")))
hold off
legend("fire","not fire")
xlabel('Days')
ylabel('Wind speed')

subplot(5,2,4)
plot(trenddecomp(fire_data.Rain))
hold on
plot(trenddecomp(not_fire_data.Rain))
hold off
legend("fire","not fire")
xlabel('Days')
ylabel('Rain')

subplot(5,2,5)
plot(trenddecomp(fire_data.("Fine Fuel Moisture Code")))
hold on
plot(trenddecomp(not_fire_data.("Fine Fuel Moisture Code")))
hold off
legend("fire","not fire")
xlabel('Days')
ylabel('Fine Fuel Moisture Code')

subplot(5,2,6)
plot(trenddecomp(fire_data.("Duff Moisture Code")))
hold on
plot(trenddecomp(not_fire_data.("Duff Moisture Code")))
hold off
legend("fire","not fire")
xlabel('Days')
ylabel('Duff Moisture Code')

subplot(5,2,7)
plot(trenddecomp(fire_data.("Drought Code")))
hold on
plot(trenddecomp(not_fire_data.("Drought Code")))
hold off
legend("fire","not fire")
xlabel('Days')
ylabel('Drought Code')

subplot(5,2,8)
plot(trenddecomp(fire_data.("Initial Spread")))
hold on
plot(trenddecomp(not_fire_data.("Initial Spread")))
hold off
legend("fire","not fire")
xlabel('Days')
ylabel('Initial spread')

subplot(5,2,9)
plot(trenddecomp(fire_data.("Buildup Index")))
hold on
plot(trenddecomp(not_fire_data.("Buildup Index")))
hold off
legend("fire","not fire")
xlabel('Days')
ylabel('Buildup Index')

subplot(5,2,10)
plot(trenddecomp(fire_data.("Fire Weather Index")))
hold on
plot(trenddecomp(not_fire_data.("Fire Weather Index")))
hold off
legend("fire","not fire")
xlabel('Days')
ylabel('Fire weather index')

% seperated regions' data
% Bejaia Region statistics
t1=data(1:122,:); % column for classes (fire/not fire)
t1.Result=categorical(t1.Result); % categorized
head(t1)
% fire
fire_bejaia=t1(t1.Result == 'fire',:);
fire_bejaia.Properties.VariableUnits={' ',' ',' ','Celsius','percentage(%)','Km/h','mm',' ',' ',' ',' ',' ',' ',' '};
fire_bejaia_summary=summary(fire_bejaia(:,4:13));
% not fire
notfire_bejaia=t1(t1.Result == 'not fire',:);
not_fire_bejaia.Properties.VariableUnits={' ',' ',' ','Celsius','percentage(%)','Km/h','mm',' ',' ',' ',' ',' ',' ',' '};
notfire_bejaia_summary=summary(notfire_bejaia(:,4:13));

% Sidi-Bel Abbes Region statistics
t2=data(125:end,:); % column for classes (fire/not fire)
t2.Result=categorical(t2.Result); % categorized
head(t2)
% fire
fire_sidibel=t2(t2.Result == 'fire',:);
fire_sidibel.Properties.VariableUnits={' ',' ',' ','Celsius','percentage(%)','Km/h','mm',' ',' ',' ',' ',' ',' ',' '};
fire_sidibel_summary=summary(fire_sidibel(:,4:13));
% not fire
not_fire_sidibel=t2(t2.Result == 'not fire',:);
not_fire_sidibel_summary=summary(not_fire_sidibel(:,4:13));
