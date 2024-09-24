# add local repo to github

initiate local repo

echo "# git repo" >> README.md
git init
git add README.md
or git add .
git commit -m "first commit"
git branch -M main
git remote add origin { github repo link }
git push -u origin main

or push an existing repository from the command line

git remote add origin { github repo link }
git branch -M main
git push -u origin main

# create branch

git branch name

# cd to branch

git checkout branchName

# delete branch

git branch -D branchName

# rename branch

git branch -m branchName

> [!TIP]
> it is better to add file to git ignore before commit any changes when then the ignored file exist

## delete last commit

git reset --soft HEAD~1

delete last 4 commits

git reset --soft HEAD~4

## this will delete all commit until this commit but this commit is excluded from delete

````bash

```git rest --hard  e26c8f2ea3cac76a083e0db8aa11c49377163ac6
````

## fix commit secrets

first identify the commit let say its 2 commits back then run
git reset --soft HEAD~2

this will delete last 2 commit
then the secrets to your git ignore config then run

git rm -r --cached . --force

to untrack all the file in the repo

and add them all again with
git add .

this will track all the files exept the ignored one

> [!TIP]
> you can test if the file ignored by running git status after toggling the ignored file in .gitconfig

## To delete commits from remote, you will need to push your local changes to the remote using the git push command

`git push origin HEAD --force`
