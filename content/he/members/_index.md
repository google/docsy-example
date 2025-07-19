---
type: 'members'
title: 'חברים ופעילות'
linkTitle: 'חברים ופעילות'
menu:
  main:
    weight: 80
    identifier: members

# Page Content
description: 'בדף זה תוכלו לראות את רשימת התורמים לקהילה, כולל מידע על תרומתם: קומיטים, בקשות משיכה, תגובות ומספר פרויקטים בהם השתתפו. ניתן למיין ולחפש לפי שם או לפי כמות תרומות.'

# Page Configuration
pageConfig:
  showSearch: true
  showCommunityStats: true
  enableSorting: true
  enableProjectDetails: true
  direction: 'ltr'  # Content direction for the main table area

# Search Configuration
searchConfig:
  placeholder: 'Type to search...'
  label: 'Search by name, username, or bio:'
  helpText: '💡 Click column headers to sort'

# Date and Update Configuration
lastUpdatedFormat: '2006-01-02 15:04:05'
showDataGenerationDate: true

# Labels and Static Text
labels:
  # Community Summary
  communitySummaryTitle: 'Community Summary:'
  contributors: 'Contributors'
  projects: 'Projects'
  commits: 'Commits'
  prs: 'PRs'
  issues: 'Issues'
  prComments: 'PR Comments'
  issueComments: 'Issue Comments'
  analysisPeriod: 'Analysis period'
  minForkFilter: 'Min fork filter'
  
  # Table Headers
  tableHeaders:
    user: 'User'
    commits: 'Commits'
    pullRequests: 'PRs'
    issues: 'Issues'
    prComments: 'PR Comments'
    issueComments: 'Issue Comments'
    total: 'Total'
    projects: 'Projects'
  
  # UI Elements
  projectsCount: 'projects'  # Used in "X projects" text
  lastUpdated: 'Last updated'
  dataGenerated: 'Data generated'
  
  # Project Details
  projectDetailsLabels:
    commits: 'C'
    pullRequests: 'PR'
    issues: 'I'
    prComments: 'PRC'
    issueComments: 'IC'
---