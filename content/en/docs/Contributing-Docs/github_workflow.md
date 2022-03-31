---
title: "Github Workflow"
linkTitle: "Github Workflow"
weight: 3
menu:
  documentation:
    weight: 20
description: >
  Guidance on using the Github Workflow.
---
For COAsT development we use a Github workflow to manage version control and collaboration. Git allows use to keep track of changes made to the COAsT code base, avoid breaking existing code and work as a group on a single package. Any contributor needs to use this workflow to add their code. Below is some guidance on using git with COAsT, including a typical workflow and cheat sheet.

For more information on git, see:

Github (https://github.com/)

The Github page for this package can be found:

[here](https://github.com/british-oceanographic-data-centre/COAsT)

## Key Ideas
1. The COAsT repository has two core branches: `master` and `develop`. The `master` branch contains the tested code that you install when using Anaconda. This is updated less frequently, and is the "user-facing" branch of code. Most contributors do not need to edit this branch. The `develop` branch is the 'pre-master' branch, where **working** code is kept. This is the leading branch, with the most up-to-date code, although it is not necessarily user-facing. When writing code into your own branch (see below), it is 'branched' from `develop` and then eventually merged back into `develop`. **You should never make changes directly to either `master` or `develop`**.

2. There is a 'local' and 'remote' copy of the COAsT repository. The local repository exists only on your machine. The remote repository is the one you see on the Github website and exists separately. The two versions of the repository can be synchronised at a single point using commands such as `git pull` `git push` and `git fetch` (see below). After cloning (downloading) the repository, all modifications you make/add/commit will **only be local until you push them to the remote repository**.

## Typical Workflow
A typical workflow for editting COAsT in git might look like:

1. **Clone Repository:** `git clone git@github.com:British-Oceanographic-Data-Centre/COAsT.git`. This will create a new copy of COAsT on your local system which you can use to interact with git and view/edit the source code. This only needs to be done once.

2. **Checkout develop:** `git checkout develop`. Before creating a new branch for your code, you should checkout the develop branch. This will switch your **local** repository to the develop branch. You can check what branch your current local repository is in by entering `git branch` -- it should now say `develop`

3. **Create/checkout your new branch:** `git checkout -b new_branch_name`. This will create and checkout your new branch -- right now it is an identical copy of `develop`. However, any changes you commit to your local repository will be saved into your branch. Once you have created your branch, you can open it as before, using `git checkout new_branch_name`.

4. **Make changes/additions to code:** Make any changes you like to COAsT. At this point it is separate from the main branches and it is safe to do so. If in doubt, enter `git branch` again to ensure you are within your own branch.

5. **Add changes to branch:** `git add modified_file`. Using this command will tell git that you have changed/added this file and you want to save it to the branch you are currently in. Upon entering this command, the file changes/additions *are not saved* to the branch and won't be until the next step. You can remove an added file by entering `git reset modified_file` and can check which files have changed by typing `git status`.

6. **Commit changes to branch:** `git commit -m "type a message in quotations"`. Entering this command will "save" the changes you added using `git add ` in the step above to the branch you are currently in. Once entered, git will identify what has changed since the previous commit. If this is the first commit in your new branch then since the version of `develop` that you branch from. This will not change any other branch except the one you are in and you can/should do this often with an appropriate message. At this point, all changes are still only on your local machine and will not change the remote repository. It is also possible to undo a commit using `git revert`, so nothing is unfixable.

7. **Continue modifying code:** At this point, you may want to continue modifying the code, repeatedly adding changes and commiting them to your local repository, as above.

8. **Push your local repository to the remote:** `git push origin`. This will upload the changes you have made in the branch you are in (and only this branch) to the remote (website) repository. If this is the first time you have pushed this branch then an error may appear telling you to repush with the `--set-upstream` flag enable. Simply copy and paste this command back into the terminal. This will "create" your branch in the remote repository. Once pushed, github will do some auto-checks to make sure the code works (which it may not, but that is fine). You can continue to modify the code at any point, and push multiple times. This is encouraged if sharing with other collaboraters.


**Once you are satisfied with your changes, move onto the next steps.**


9. **Make sure your local branch is up to date with the remote:** `git pull origin` when in your branch. This is to ensure that nobody else has changed your branch, or if they have to update your local branch with the changes on the remote.

10. **Update your branch with develop:**. Before requesting that your branch and its changes be merged back into the `develop` branch, it is good practice to first merge develop back into your branch. This is because `develop` may have changed since you started working on your branch and these changes should be merged into your branch to ensure that conflicts are resolved. To do this, first update develop by entering `git checkout develop` and `git pull`. This will update the `develop` branch on your local machine. Then merge `develop` back into your branch by entering `git checkout your_branch` and `git merge develop`. This may say up-to-date (in which case GREAT), or successful (in which case GREAT) or may say there are some conflicts. This happens when more than one person has changed the same piece of code.

11. **Resolve Conflicts:** This step may not be necessary if there are no conflicts. If git tells you there are conflicts, it will also tell you which files they occur in. For more information/help with conflict resolution see [here](https://www.atlassian.com/git/tutorials/using-branches/merge-conflicts)

12. **Create a pull request for your branch**. First your most up to date branch using `git push origin`, even after merging develop in step 9/10. On the website you may then create a 'pull request' which is a formal way of saying you want to merge your branch back into `develop`. A pull request allows you to ask people to 'review' your branch, share your code, view the changes in your branch and other things. To make a pull request, go to the website, click on the pull requests tab and click `Create new pull request`. Then select your branch in the right drop down menu and `develop` in the left. You may then enter a description of the changes you have made and anything else you would like reviewers to see.

13. **Reviewers review the code:** Requested reviewers take a look at your changes and run the unit_test. Once they are satisfied, they will approve the pull request, or add comments about any problems.

14. **Merge branch into develop:** Once reviewers are satisfied, you may click `Merge branch` at the bottom of the pull request. Now your changes will be added into develop! Again, this is fine as the branch has been inspected by reviewers and any change can be reverted using `git revert` (although this is not encouraged for the `develop` branch).

**Note: After creating a pull request, Github will automatically apply "black formatting" to the code. This will commit new (small) changes to the branch so you should always do a `git pull` on your branch to make sure your local version is up to date with the remote. 

## Condensed Workflow

1. `git clone git@github.com:British-Oceanographic-Data-Centre/COAsT.git`.
2. `git checkout develop`
3. `git checkout -b new_branch_name`
4. Make changes
5. `git add changed_file`
6. `git commit -m "what changes have you made"`
7. `git push origin`
8. If your branch changed by anyone else, `git pull`
9. Repeat steps 4-8
10. `git checkout develop` `git pull` `git checkout your_branch` `git merge develop` `git push origin`
11. Create pull request from `your_branch` to `develop`, include description and request reviewers.
12. Reviewers accept, Merge branch.
