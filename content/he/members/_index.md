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

# Development Notice
developmentNotice:
  show: true
  text: 'הדף שלפניכם נמצא בתהליכי פיתוח וייתכן שיש בו שגיאות. בכל עניין (פיתוח חדש, שאלות או הערות נא לפנות לאוריאל אופיר urielofir@gmail.com).'

# Table Information
tableInfo:
  show: true
  title: '📊 על הטבלה'
  text: 'בטבלה שלפניכם מופיעה פעילות מחצי השנה האחרונה מספריות קוד פתוח, כלומר ספריות שיש להן לפחות 3 פורקים (forks).'

# How to Add Your Profile Instructions (Hebrew)
howToAddProfile:
  show: true
  title: 'איך להוסיף את הפרופיל שלך לטבלה?'
  instructions: |
    יש לך פרופיל בגיטהאב ורוצה שהתרומות שלך יופיעו בטבלה? הנה איך לעשות זאת:
    
    1. **צור Pull Request** - הוסף את שם המשתמש שלך ל<a href="https://github.com/Maakaf/maakaf_home/blob/main/config.json" target="_blank">קובץ הקונפיגורציה</a> (במערך `usernames` - הוסף את שם המשתמש שלך בתוך גרשיים עם פסיק)
    2. **חכה לאישור ה-Pull Request שלך** - כאשר זה יקרה הנתונים שלך יצורפו לטבלה
  expandButtonText: 'הצג הוראות מלאות'
  collapseButtonText: 'הסתר הוראות'

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
  helpText: '💡 Click column headers (↕) to sort data'

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