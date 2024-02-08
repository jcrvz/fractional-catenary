% Defining parameters
x0= 0;                      % central point [m]
xl= 20;                     % x-length
h = 5;                      % height h [m]
a = 10;                     % parameter ?

% h = h0 + a * (cosh((- x0)/a) - 1);

% x-axis variable
x = linspace(x0 - xl,x0 + xl,100);

% fractional orders
%alpha_list = 0.7 : 0.05 : 1.00;     % only for 2d plots
alpha_list = linspace(0.7,1,100);   % only for 3d plots

% fractional catenary models
models = {'CD','ABC','CF','Conformable','Traditional'};

[X,A] = meshgrid(x,alpha_list);

line_colours = hsv(numel(alpha_list));
colours = hsv(numel(models));
Y_FULL = nan(length(alpha_list),length(x),numel(models)+1);

%% Traditional model

Y_TRADITIONAL = Traditional(a,h,x);
Y_FULL(:,:,end) = repmat(Y_TRADITIONAL,numel(alpha_list),1);

%% For all models
for jj = 1 : numel(models)-1
    % Get the model name
    model_string = models{jj};
    
    % Initialise the graphic object
    Gr1 = Graphics(model_string);
    Fi1     = Gr1.objID;
    Ax1     = axes(Gr1.objID,'NextPlot','add');
    
    % Initialise matrix of data
    Y_VALUES = nan(length(alpha_list),length(x));
    
    % For all fractional orders
    for ii = 1 : numel(alpha_list)
        
        % Eval the correspoding models
        Y_VALUES(ii,:) = real(feval(model_string,alpha_list(ii),a,h,abs(x)));
        Y_FULL(ii,:,jj) = Y_VALUES(ii,:);
        plot(Ax1,(x - x0)/a ,(Y_VALUES(ii,:) - h)/a,'LineWidth',1.0,'DisplayName',...
            sprintf('$$\\alpha = %.2f$$',alpha_list(ii)),...
            'Color',line_colours(ii,:));
        
    end
    
    plot(Ax1,(x - x0)/a,(Y_TRADITIONAL - h)/a,'--k','LineWidth',1.0,'DisplayName',...
           sprintf('Traditional'));
    
    Le1 = legend('show'); set(Le1,'Interpreter','LaTeX','box','off', ...
        'Location','best');
    xlabel(Ax1,'$$\tilde{x} = (x - x_{0})/a$$','Interpreter','LaTeX'); 
    ylabel(Ax1,'$$\tilde{y} = (y - h)/a$$','Interpreter','LaTeX');
    xlim([-2 2]), ylim([0 3.5])
    set(Ax1,'LineWidth',1,'TickLabelInterpreter','LaTeX','Box','on');
    setall(Gr1,1,[2,1],16,1)   
    
end

%%
for jj = 1 : numel(models)-1
    % Get the model name
    model_string = models{jj};
    
    % Initialise the graphic object
    Gr1 = Graphics([model_string,'diff']);
    Fi1     = Gr1.objID;
    Ax1     = axes(Gr1.objID,'NextPlot','add');
        
    % For all fractional orders
    for ii = numel(alpha_list) : -1 : 1
        
        % Eval the correspoding models
        plot(Ax1,(x - x0)/a,reshape((Y_FULL(ii,:,end) - Y_FULL(ii,:,jj))/a,1,[]),...
            'LineWidth',1.0,'DisplayName',...
            sprintf('$$\\alpha = %.2f$$',alpha_list(ii)),...
            'Color',line_colours(ii,:));
    end
       
    Le1 = legend('show'); set(Le1,'Interpreter','LaTeX','box','off', ...
        'Location','best');
    xlabel(Ax1,'$$\tilde{x} = (x - x_{0})/a$$','Interpreter','LaTeX'); 
    ylabel(Ax1,'$$\Delta\tilde{y} = (y - y_{*})/a$$','Interpreter','LaTeX');
    xlim([-2 2]), ylim([-0.5 0.1])
    set(Ax1,'LineWidth',1,'TickLabelInterpreter','LaTeX','Box','on');
    setall(Gr1,1,[2,1],16,1)   
    
end

%%
Gr2 = Graphics('Summary_plots');
Fi2     = Gr2.objID;
Ax2     = axes(Gr2.objID,'NextPlot','add');

for jj = 1 : numel(models)-1
    % Summary curve
    for ii = 1 : numel(alpha_list)
        Pl2 = plot3(Ax2,(X(ii,:) - x0)/a,A(ii,:),(Y_FULL(ii,:,jj) - h)/a,...
            'Color',colours(jj,:), ...
            'DisplayName', sprintf('%s',models{jj}), 'LineWidth',1.5);
        if ii ~= 1, Pl2.HandleVisibility = 'off'; end
    end
end

%surf(Ax2,X,A,Y_FULL(:,:,end),'FaceColor','k', ...
%        'EdgeColor','none', 'FaceAlpha',0.5, 'DisplayName','Traditional'),

Le2 = legend(Ax2,'show'); set(Le2,'Interpreter','LaTeX','box','off', ...
    'Location','northoutside','NumColumns',5 ,'Orientation','vertical');
xlabel(Ax2,'$$\tilde{x} = (x - x_{0})/a$$','Interpreter','LaTeX'); 
ylabel(Ax2,'$$\alpha$$');
zlabel(Ax2,'$$\Delta\tilde{y} = (y - y_{*})/a$$','Interpreter','LaTeX');
set(Ax2,'LineWidth',1,'TickLabelInterpreter','LaTeX','Box','on',...
    'View',[15 10]); light,
setall(Gr2,1,[2,1],16,1)

%% diff surfaces

for jj = 1 : numel(models)-1
    Gr2 = Graphics([models{jj},'_diffsurfaces']);
    Fi2     = Gr2.objID;
    Ax2     = axes(Gr2.objID,'NextPlot','add');
    % Summary curve
    surf(Ax2,(X - x0), A, (Y_FULL(:,:,end) - Y_FULL(:,:,jj))/a, 'FaceAlpha',0.8),
    shading interp, colormap jet,
    Co2 = colorbar; Co2.Label.Interpreter = 'LaTeX';
    Co2.TickLabelInterpreter = 'LaTeX';
    xlim([-2 2]), %zlim([-0.3 0.1])
    xlabel(Ax2,'$$\tilde{x} = (x - x_{0})/a$$','Interpreter','LaTeX'); 
    ylabel(Ax2,'$$\alpha$$');
    zlabel(Ax2,'$$\Delta\tilde{y} = (y - y_{*})/a$$','Interpreter','LaTeX');
    set(Ax2,'LineWidth',1,'TickLabelInterpreter','LaTeX','Box','on',...
        'View',[37.7029 28.4299]); light,
    setall(Gr2,1,1/1.5,16,1)
end


%%
Gr2 = Graphics('Summary_surfaces');
Fi2     = Gr2.objID;
Ax2     = axes(Gr2.objID,'NextPlot','add');

for jj = 1 : numel(models)-1
    % Summary curve
    surf(Ax2,(X - x0)/a, A, (Y_FULL(:,:,jj) - h)/a,'FaceColor',colours(jj,:), ...
        'EdgeColor','none', 'FaceAlpha',0.8, 'DisplayName',...
        sprintf('%s',models{jj})),
end

surf(Ax2,(X - x0)/a, A, (Y_FULL(:,:,end) - h)/a,'FaceColor','k', ...
        'EdgeColor','none', 'FaceAlpha',0.5, 'DisplayName','Traditional'),

Le2 = legend(Ax2,'show'); set(Le2,'Interpreter','LaTeX','box','off', ...
    'Location','northoutside','NumColumns',5 ,'Orientation','vertical');
xlabel(Ax2,'$$\tilde{x} = (x - x_{0})/a$$','Interpreter','LaTeX'); 
    ylabel(Ax2,'$$\alpha$$');
    zlabel(Ax2,'$$\tilde{y} = (y - h)/a$$','Interpreter','LaTeX');
set(Ax2,'LineWidth',1,'TickLabelInterpreter','LaTeX','Box','on',...
    'View',[15 10]); light,
setall(Gr2,1,[2,1],12,1)

%%
Gr2 = Graphics('Summary_surfaces_diff');
Fi2     = Gr2.objID;
Ax2     = axes(Gr2.objID,'NextPlot','add');

for jj = 1 : numel(models)-1
    % Summary curve
    surf(Ax2,(X - x0)/a, A, (Y_FULL(:,:,end) - Y_FULL(:,:,jj))/a,'FaceColor',colours(jj,:), ...
        'EdgeColor','none', 'FaceAlpha',0.8, 'DisplayName',...
        sprintf('%s',models{jj})),
end

%surf(Ax2,X,A,Y_FULL(:,:,end),'FaceColor','k', ...
%        'EdgeColor','none', 'FaceAlpha',0.5, 'DisplayName','Traditional'),

Le2 = legend(Ax2,'show'); set(Le2,'Interpreter','LaTeX','box','off', ...
    'Location','northoutside','NumColumns',5 ,'Orientation','vertical');
xlabel(Ax2,'$$\tilde{x} = (x - x_{0})/a$$','Interpreter','LaTeX'); 
ylabel(Ax2,'$$\gamma$$');
zlabel(Ax2,'$$\Delta\tilde{y} = (y - y_{*})/a$$','Interpreter','LaTeX');
set(Ax2,'LineWidth',1,'TickLabelInterpreter','LaTeX','Box','on',...
    'View',[15 10]); light,
xlim([0 2])
setall(Gr2,1,1/1.5,16,1)

%% Fractional models

% CD model
function [yc] = CD(r,a,h,X)
yc = h + a^(-r)*abs(X).^(1 + r).*ml((X/a).^2,2,2 + r,1);
end

% CF model
function [yfc] = CF(r,a,h,X)
yfc = h + a*(1 - r)*(sinh(X/a)) + r*a*(cosh(X/a) - 1);
end

% ABC model
function [ya] = ABC(r,a,h,X)
ya = h + a*((1 - r)*sinh(X/a) + r*abs(X/a).^(1 + r).*ml((X/a).^2,2,2 + r,1));
end

% Conformable model
function [yconf] = Conformable(r,a,h,X)
yconf = h + a*gamma(2 - r)*( ...
    (X/a).^(2 - r).*sinh(X/a).*ml((X/a).^2, 2, 3 - r, 1) - ...
    (X/a).^(3 - r).*cosh(X/a).*ml((X/a).^2, 2, 4 - r, 1));
end

% Traditional model
function [y] = Traditional(a,h,X)
y = a * (cosh((X)/a) - 1) + h;
end

