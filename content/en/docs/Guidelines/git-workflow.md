---
title: "Git Workflow"
linkTitle: "Git Workflow"
date: 2020-11-24
description: >
  Guidelines on how to use git.
---

{{% pageinfo %}}
Note : This is maybe not perfect and is definitely open to suggestions, but we'd like to at least try it out for some time to see the results.
{{% /pageinfo %}}

This is the workflow we would like to try out for now.

You have something you need to work on :
1. You **pull** the latest changes from master.
2. You create a **branch** from master, called `dev-name/branch-name` (ex: `tim/T-123-admin-pro-subscription`).
3. You **work** on that branch however you like, you can commit/push/rebase as many times as you want. Note that it's usually recommended to do a lot of small commits instead of working locally for 3 days and then doing one big commit. But this is up to you.
4. Once you're done, **create a PR** on GitHub.
5. You can **continue working** on the branch to address any comments / bugfixes / ...
6. When your PR is accepted and ready to merge, go on the page of your PR on GitHub and click "**Squash and merge**" (The big green button, click on the little arrow and choose "Squash and merge" and not any of the other options).
7. **Edit the title** of the commit to start with the Height ticket (if applicable), followed by what this PR is adding, and leave the PR number at the end. ex: `T-123 Admin page for ProSubscription and ProSubscriptionPayment (#903)`
8. **Edit the description** to explain in more detail what this PR is adding/modifying. The default description puts all your commit messages one under the other. This is a pretty good default, but you can remove what you feel is not necessary and add what you feel is missing, this is up to you. (ex: If I have some commits like "rubocop", "small bugfix", "PR comments", "rubocop again", these are not needed in the final description).
9. Click "**Confirm squash and merge**"

## Why ?

We would like to avoid using merge commits at all costs, as those create a Git history that is very hard to follow.
Example:
```
* ff6d75661 added check to prevent counting cancelled and old tasks when computing the daily allowances
* f12dfdd4f T-12939
*   1cf19311d Merge branch 'master' of https://github.com/listminut/listminutv3
|\
| * e0d0f2016 mark as feature test
| * c09fa11e1 Create estimation feature test
* | b0c75ae7c disable sold_out_dates for christmas tree
|/
* 917f0195b API bug correction edit email
* 1adc7c282 Handle task without associated SP
```

The usually recommended way to work is to use rebases ([This](https://daniel.haxx.se/blog/2020/11/09/this-is-how-i-git/) is a good article explaining that).
This creates a nice and linear Git history:
```
* cc789766d Update SEM NL Client title
* 38c6aa33a Update SEM NL Client headings
* 83d2e7087 Add new level 2 headlines (h2)
* c8ad12088 Update SEM NL Client descriptions
```

But we feel like rebasing can sometimes be time-consuming, can be "scary" for people who aren't used to it, and will leave a lot of "ugly" or useless commit messages in the history:
```
* 156d84e5e Mauro Feedbacks
* a81833887 remove comments
* 5491e1a9c label as feature
* 180d8f08e complete apply page feature test
* e491cd393 pause dev to fix urgent bug on master
```
This can be fixed by cleaning up your commit history before rebasing, but this is even more time-consuming/scary.

So we are opting for an intermediate solution where we don't have to use any complex git commands and can just continue working as before, but by doing a "squash and merge" it should keep the git history nice and easy to follow.

The problem with this solution is that it only allows you to squash your entire PR in one single commit, which should be alright for most cases, but could be a problem for bigger branches (ex: the christmas-tree branch we had recently).

## Working with bigger branches

If you need more than a single commit message for your PR, you will have to manualy clean up your branch history by squashing some commits together, and once the branch is clean and only contains usefull commit messages, you can use "rebase and merge".

**TODO**: Mauro can probably explain this part in more detail.
