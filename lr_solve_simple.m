
%% playing around with logistic regression

% define the domain

Xrange = linspace(-10,10,325);
Yrange = linspace(-10,10,325);
[X Y] = meshgrid(Xrange, Yrange);
sz = size(X);

% make a feature matrix
% TODO: what happens when we change Y(:) to Y(:).^2?
% TODO: what happens when we change Y(:) to X(:).^2?
feature_builder = @(x) [ones(size(x,1), 1) sin(x(:,1)) cos(x(:,2))];
features = feature_builder([X(:) Y(:)]);

% theta(1) is the threshold parameter
% theta(2:end) is orthogonal to the decision surface
% TODO: how does changing the first element change things?
theta = 3*[0 -1 1]';

% define the sigmoid function
sigmoid = @(z) 1 ./ (1 + exp(-z));
% A script for visualizing the representation and parameter optimization
% for logistic regression

% show how to visualize the P(true | location) and generate fake data

% apply sigmoid and theta to data
values = reshape(sigmoid(features*theta), sz);

% show the decision surface and the conditional probabilities P(class |
% feature value)
figure(1); clf;
imagesc(values, 'XData', Xrange, 'YData', Yrange)
hold on
contour(X,Y,values,.5,'r');
hold off
colormap(gray(256))
axis xy

%
% use the model to create some training data
%

% make training data
Xtrain = (rand(1000, 1) - .5)*20;
Ytrain = (rand(1000, 1) - .5)*20;
features_train = feature_builder([Xtrain(:) Ytrain(:)]);

% assign a class label based on true conditional

% P(class = 1 | feature)
Ptrain = sigmoid(features_train * theta);

% randomly assign a class
Ctrain = double(rand(size(Xtrain)) < Ptrain);

% add the training data
figure(1); clf;
imagesc(values, 'XData', Xrange, 'YData', Yrange)
hold on
contour(X,Y,values,.01,'g');
contour(X,Y,values,.5,'r');
contour(X,Y,values,.99,'g');
h = scatter(Xtrain, Ytrain, 50, Ctrain, 'filled');
set(h, 'MarkerEdgeColor', 'g')
hold off
colormap(gray(256))
axis xy

%% fit a model to the training data (batch ascent)

theta_est = zeros(size(theta)); theta_est(end) = 1;

for i = 1:4000
  
  if mod(i, 10) == 0
    
    % show updates
    figure(1); clf;
    subplot(1,2,2)
    values = reshape(sigmoid(features*theta_est), sz);
    imagesc(values, 'XData', Xrange, 'YData', Yrange)
    hold on
    contour(X,Y,values,.5,'r');
    h = scatter(Xtrain, Ytrain, 50, Ctrain, 'filled');
    set(h, 'MarkerEdgeColor', 'g')
    hold off, colormap(gray(256)), axis xy
    title('Learned Posterior')
    
    subplot(1,2,1)
    values = reshape(sigmoid(features*theta), sz);
    imagesc(values, 'XData', Xrange, 'YData', Yrange)
    hold on
    contour(X,Y,values,.5,'r');
    h = scatter(Xtrain, Ytrain, 50, Ctrain, 'filled');
    set(h, 'MarkerEdgeColor', 'g')
    hold off, colormap(gray(256)), axis xy
    title('True Posterior')
    
    pause(.01)
  end

  update = features_train'*(Ctrain - sigmoid(features_train*theta_est));
  update = update / numel(Ctrain);
  theta_est = theta_est + .05*update;
  
  % check for convergence (stop if update is really small)
  % (the threshold is problem dependent)
  if norm(update) < .01
    break
  end
  
end

disp('done with batch learning')

pause

%
%% fit a model to the training data (stochastic ascent)
%

theta_est = zeros(size(theta)); theta_est(end) = 1;

count = 1;
for i = 1:20
  
  for iExample = randperm(size(features_train,1))
    
    % update based on one training example
    update = features_train(iExample,:)'*(Ctrain(iExample,:) - sigmoid(features_train(iExample,:)*theta_est));
    theta_est = theta_est + (.005)*update;
    
    if mod(count,20) == 0
      % show updates
      figure(1); clf;
      subplot(1,2,2)
      values = reshape(sigmoid(features*theta_est), sz);
      imagesc(values, 'XData', Xrange, 'YData', Yrange)
      hold on
      contour(X,Y,values,.5,'r');
      h = scatter(Xtrain, Ytrain, 50, Ctrain, 'filled');
      set(h, 'MarkerEdgeColor', 'g')
      hold off, colormap(gray(256)), axis xy
      title('Learned Posterior')
      
      subplot(1,2,1)
      values = reshape(sigmoid(features*theta), sz);
      imagesc(values, 'XData', Xrange, 'YData', Yrange)
      hold on
      contour(X,Y,values,.5,'r');
      h = scatter(Xtrain, Ytrain, 50, Ctrain, 'filled');
      set(h, 'MarkerEdgeColor', 'g')
      hold off, colormap(gray(256)), axis xy
      title('True Posterior')
      
      pause(eps)
      
    end
    count = count + 1;
  end
  
  % check for convergence
%  if norm(update) < .0000000001
%    disp('converged')
%    break
%  end
  
end

disp('done with incremental learning')

pause

