
maxiter = 20;
restartProb = 0.5;
dim_disease = 150;
dim_site = 400;

diseaseNets = {'SimDisGaussianSimilarity', 'SimMddDAG', 'SimMddSym'};
siteNets = {'SimSiteGaussianSimilarity', 'SimMss'};

tic
X = DCA(diseaseNets, dim_disease, restartProb, maxiter);
toc
tic
Y = DCA(siteNets, dim_site, restartProb, maxiter);
toc

dlmwrite(['E:/豆豆/体系一修改/降维/feature/disease', num2str(dim_disease), '.txt'], X, '\t');
dlmwrite(['E:/豆豆/体系一修改/降维/feature/site', num2str(dim_site), '.txt'], Y, '\t');
