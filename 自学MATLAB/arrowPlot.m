function H = arrowPlot(X, Y, varargin)
%ARROWPLOT Plot with arrow on the curve.
%   ARROWPLOT(X, Y) plots X, Y vectors with 2 arrows directing the trend of data.
%
%   You can use some options to edit the properties of arrow or curve.
%   The options that you can change are as follow:
%       number:		The number of arrows, default number is 2;
%       color:		The color of arrows and curve, default color is [0, 0.447, 0.741];
%       LineWidth:	The line width of curve, default LineWidth is 0.5;
%       scale:		To scale the size of arrows, default scale is 1;
%       limit:		The range to plot, default limit is determined by X, Y data;
%       ratio:		The ratio of X-axis and Y-axis, default ratio is determined by X, Y data;
%             		You can use 'equal' for 'ratio', that means 'ratio' value is [1, 1, 1].
%
%   Example 1:
%   ---------
%      t = [0:0.01:20];
%      x = t.*cos(t);
%      y = t.*sin(t);
%      arrowPlot(x, y, 'number', 3)
%
%   Example 2:
%   ---------
%      t = [0:0.01:20];
%      x = t.*cos(t);
%      y = t.*sin(t);
%      arrowPlot(x, y, 'number', 5, 'color', 'r', 'LineWidth', 1, 'scale', 0.8, 'ratio', 'equal')

%   Copyright 2017 TimeCoder.

    h = plot(X, Y);
    hold on;
    if nargout == 1
        H = h;
    end

    ratio = get(gca, 'DataAspectRatio');
    limit = axis;
    d = max(limit(2)-limit(1), limit(4)-limit(3));
    
    default_options.number = 2;
    default_options.color = [0 0.447 0.741];
    default_options.LineWidth = 0.5;
    default_options.size = d;
    default_options.scale = 1;
    default_options.limit = axis;
    default_options.ratio = ratio;
    Options = creat_options(varargin, default_options);
    
    useroptions = creat_useroptions(varargin);
    if ~isfield(useroptions, 'size')
        Options.size = max(Options.limit(2)-Options.limit(1), Options.limit(4)-Options.limit(3));
    end
    if ~isfield(useroptions, 'ratio')
        axis(Options.limit);
        Options.ratio = get(gca, 'DataAspectRatio');
    end
    set(h, 'color', Options.color);
    set(h, 'LineWidth', Options.LineWidth);
    if isa(Options.ratio, 'char') && strcmp(Options.ratio, 'equal')
        r = 1;
    else
        r = Options.ratio(2) / Options.ratio(1);
    end
    
    n_X = length(X);
    journey = 0;
    for i = 1 : n_X-1
        journey = journey + sqrt( (X(i+1)-X(i))^2 + (Y(i+1)-Y(i))^2 );
    end
    journey_part = journey / Options.number;

    if 10*journey<Options.size
        Options.size = 10*journey;
    end
    
    
    [X_arrow, Y_arrow] = arrow_shape(50, 25);
    [X_arrow1, Y_arrow1] = Scale(X_arrow, Y_arrow, 0.015*Options.scale*Options.size);

    k=0.5;
    journey_now = 0;

    for i = 1 : n_X-1
        journey_step = sqrt( (X(i+1)-X(i))^2 + (Y(i+1)-Y(i))^2 );
        journey_next = journey_now + journey_step;
        if journey_now<=k*journey_part && journey_next>k*journey_part
            s = (k*journey_part - journey_now) / journey_step;
            x0 = X(i) + s * (X(i+1)-X(i));
            y0 = Y(i) + s * (Y(i+1)-Y(i));
            [X_arrow2, Y_arrow2] = Rotate(X_arrow1, Y_arrow1, arg(X(i+1)-X(i), (Y(i+1)-Y(i))/r) );
            [X_arrow3, Y_arrow3] = Translation(X_arrow2, r*Y_arrow2, [x0, y0]);
            g = fill(X_arrow3, Y_arrow3, Options.color);
            set(g, 'EdgeColor', Options.color);
            k=k+1;
        end
        journey_now = journey_next;
    end
    axis(Options.limit);
    if isequal(Options.ratio, 'equal')
        axis equal;
    end
    hold off;
end

function Options = creat_options(user_choice, default_choice_struct)
    n = length(user_choice);
    if ~ispair(n)
        error('varargin is not an options''s struct.');
    end
    
    Options = default_choice_struct;
    i = 1;
    while i <= n
        if isfield(default_choice_struct, user_choice{i})
            Options = setfield(Options, user_choice{i}, user_choice{i+1});
        end
        i = i + 2;
    end
end

function Options = creat_useroptions(VARARGIN)
    if ~isa(VARARGIN, 'cell')
        error('VARARGIN is not of class cell!');
    end
    n = length(VARARGIN);
    if ~ispair(n)
        error('length of VARARGIN is not pair!');
    end
    i = 1;
    Options = struct();
    while i < n
        Options = setfield(Options, VARARGIN{i}, VARARGIN{i+1});
        i = i+2;
    end
end

function check = ispair(x)
    check = ( isint(x) && isint( 1.0*x / 2.0 ) );
end

function check = isint(x)
    check = ( floor(x) == x );
end

function theta = arg(x, y)
    if nargin == 2
        [m, n] = size(x);
        theta = zeros(m, n);
        for i = 1 : m
            for j = 1 : n
                if x(i, j) > 0 || y(i, j) ~= 0
                    theta(i, j) = 2 * atan( y(i, j) ./ ( x(i, j) + sqrt(x(i, j).^2+y(i, j).^2) ) );
                elseif x(i, j) < 0 && y(i, j) == 0
                    theta(i, j) = pi;
                elseif x(i, j) == 0 && y(i, j) == 0
                    theta(i, j) = 0;
                end
            end
        end
    elseif nargin==1
        theta = arg(real(x), imag(x));
    end
end

function [X, Y] = arrow_shape(theta1, theta2)
    theta1 = theta1/180*pi;
    theta2 = theta2/180*pi;
    x0 = tan(theta2) / ( tan(theta2) - tan(theta1) );
    y0 = tan(theta1) * tan(theta2) / ( tan(theta2) - tan(theta1) );
    X = [0, x0, 1, x0, 0];
    Y = [0, y0, 0, -y0, 0];
end

function [X_new, Y_new] = Rotate( X, Y, varargin )
    if length(varargin)==1
        center = [0, 0];
        theta = varargin{1};
    elseif length(varargin)==2
        center = varargin{1};
        theta = varargin{2};
    end

    [m1, n1] = size(X);
    [m2, n2] = size(Y);
    
    if min(m1, n1) ~= 1
        error('The size of X is wrong!');
    end
    
    if min(m2, n2) ~= 1
        error('The size of Y is wrong!');
    end
    
    if n1 == 1
        X = X';
    end
    
    if n2 == 1
        Y = Y';
    end
    
    if length(X) ~= length(Y)
        error('length(X) and length(Y) must be equal!');
    end
    XY_new = [cos(theta), -sin(theta); sin(theta), cos(theta)] * [X-center(1); Y-center(2)];
    X_new = XY_new(1, :)+center(1);
    Y_new = XY_new(2, :)+center(2);
end

function [X_new, Y_new] = Scale( X, Y, varargin )
    if length(varargin)==1
        center = [0, 0];
        s = varargin{1};
    elseif length(varargin)==2
        center = varargin{1};
        s = varargin{2};
    end
    
    X_new = s * ( X - center(1) ) + center(1);
    Y_new = s * ( Y - center(2) ) + center(2);
end

function [X_new, Y_new] = Translation( X, Y, increasement )
    X_new = X + increasement(1);
    Y_new = Y + increasement(2);
end