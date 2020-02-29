%%%%% Global configuration file for Honda %%%%%%

data_dim = 20*20;
subspace_th = 0.85;
set_length = 50;
random_sample = 0;
k_c           = 1; % clustering number
lambda1       = 1e-3;
lambda2       = 1e-1;

%%% add path
load(['honda_heq.mat']);

%%% Holds all settings used in all parts of the code, enabling the exact
%%% reproduction of the experiment at some future date.

EXPERIMENT_TYPE = 'RNP';
DATASET_NAME = 'honda';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DIRECTORIES - please change if copying the code to a new location
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Directory holding the experiment 
RUN_DIR = [ '../../' ];

%%% Directory holding all the source images
DATA_DIR = [ '../../data/' ];
RESULT_DIR = ['G:\Face recognition\FR_ImageSet\sanfr\JournalPaper\honda\'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% GLOBAL PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Mostly boring file and directory name settings

Global.Ground_Truth_Name = 'ground_truth_locations';

%% how many zeros to prefix image, interest and model files by....
Global.Num_Zeros = 0;

%% subdirectory, file prefix and file extension of images 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% CATEGORIES 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Image classes to use (cell array)
Categories.Name = {'behzad',
                   'chia',
                   'danny',
                   'fuji',
                   'harsh',
                   'hector',
                   'hide',
                   'james',
                   'jeff',
                   'joey',
                   'leekc',
                   'louis',
                   'miho',
                   'ming',
                   'mushiake',
                   'rakesh',
                   'saito',
                   'victor',
                   'wei',
                   'yokoyama'
                  };

%% Frame range for each of the classes to use 
%% (must have an entry for each of the classes in Categories.Name)
Categories.Train_Frames = {[3],   % 1
                           [6],
                           [9],
                           [11],
                           [16],
                           [18],
                           [20],
                           [23],
                           [27],
                           [30],
                           [34],
                           [37],
                           [40],
                           [45],
                           [48],
                           [51],
                           [53],
                           [56],
                           [57],
                           [59]
                          };
Categories.Test_Frames = {[1:2],   % 1
                          [4:5],
                          [7:8],
                          [10],
                          [12:15],
                          [17],
                          [19],
                          [21:22],
                          [24:26],
                          [28:29],
                          [31:33],
                          [35:36],
                          [38:39],
                          [41:44],
                          [46:47],
                          [49:50],
                          [52],
                          [54:55],
                          [],
                          [58]
                          };
Categories.Number = length(Categories.Name);
