# DDSR

D'Eli Dulce y Sal Repository.
DDSR is a project with the purpose of creating a repository and mobile app to track all custom orders, along with the clients that made them.

The mobile app uses the api to get all clients, orders made, orders in progress and finished orders. It will also provide a way of introducing information into the repository, such as creating new users,
adding orders, tagging orders as complete and so on. 

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

## VERSIONING

There are 2 main branches, Master and Develop, and n-number of branches made for features for the app, these branches are made from the develop branch.

- Master is the branch with the stable app versions.
- Develop is the branch that holds all the feature branches.

# SETTING UP FOR THE FIRST TIME

- if you are using visual studio code, you will need to first create a flutter application using the command palette. 

- if you are using Android Studio, follow the next steps, the IDE after detecting the archives for flutter should add the missing folders it needs to function.

To set up the repository get in the folder's root and type:
- git init
- git remote add ddsr <'this repo url'>
- git fetch -all
- git reset --hard ddsr/master

This will first start the git repo, we add the remote url, so it will pull and push to it. We use fetch -all to retrieve all data from the repository without adding or trying to stage data. And then, we use git reset, so the local branch is overwritten by the branch from the repository. After this the repository is set, you can now pull and push from it.

# PUSHING INFORMATION

To push changes to the repository first use:
- git checkout develop

This will put you on the develop branch, from there use:
- git checkout -b feature/<'feature-name'>

It will automatically locate you in the newely created branch, and you will be able to change and commit in it. To make commits use:
- git add .
- git commit -m <"message">
- git push

git add, adds all changes you make in the files to the git tracking, git commit stages those changes for pushing or stashing, add a meaningful message to let others know what you did. Then with git push you publish the changes and commits you made to the repository, so all the other people can look at them and pull them.

- Before pushing to a feature branch, do a checkout to develop, and perform a git pull there, in the case develop has new changes that you don't have locally.
    - if that is the case, then we will use:
        - git fetch --all
        - git checkout feature/<'feature-name'>
        - git rebase ddsr/develop
    
    What the last step does is basically. 
    People did a lot of changes to develop or master while you were working on your branch, they are now quite ahead. With fetch all you retrieve all said changes and then you checkout to your feature branch and use git rebase.

    What rebase does is taking all those commits and changes and dumping them in your local branches without your feature branch getting merged but still getting those new features or corrections other people made.
