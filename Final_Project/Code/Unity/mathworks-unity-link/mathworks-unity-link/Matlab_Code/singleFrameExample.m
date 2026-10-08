clc;
clear all;
close all;

%Include source files in path
addpath(genpath('../src'))

%Initialization Parameters
server_ip   = '127.0.0.1';     %IP address of the Unity Server
server_port = 55001;           %Server Port of the Unity Sever

client = tcpclient(server_ip,server_port);
fprintf(1,"Connected to server\n");

% x,y,z,yaw[z],pitch[y],roll[x]
pose = [-2,0,0,10,0,0];
unityImage = unityLink(client,pose);

imshow(unityImage);

%Close Gracefully
fprintf(1,"Disconnected from server\n");
