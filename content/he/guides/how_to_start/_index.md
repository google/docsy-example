---
type: "docs"
title: "פרוייקט התרגול לתרומה ראשונה"
slug: "how-to-contribute"
linkTitle: "פרוייקט התרגול לתרומה ראשונה"

---
## מדריך תרומה ראשונית בפרויקט התרגול

**מאת דרור קרפפן**

ברוכים הבאים לעולם הקוד הפתוח!
במדריך הזה נלמד איך עובד תהליך התרומה לקוד פתוח, ונדגים כאן שלב אחר שלב תרומה לפרויקט התרגול של קהילת מעקף.

**לפני שנתחיל**

- מומלץ לצפות בסרטון ההדרכה הקצר <a target="_blank" href="https://youtu.be/IVNxfbHNHZk?si=CCX2i2qwxyKNfuSS">איך להתחיל לתרום לקוד פתוח</a>, שמדגים את כל מה שנציג במדריך הזה.
- היכנסו <a target="_blank" href="https://github.com/UrielOfir/os-practice">לפרויקט התרגול</a>.

### מה נעשה בתרגול הזה?

נוסיף מין "כרטיס חבר" באתר של פרויקט התרגול, על ידי הוספת קובץ טקסט פשוט לפרויקט.

אנחנו נעבוד בשני מישורים - יהיו פעולות שנבצע **בפרויקט הראשי**, ויהיו פעולות שנבצע **מקומית אצלנו**.

![תרשים של תהליך העבודה בקוד פתוח](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/os-workflow.png)

#### 1. יצירת פורק Fork

ניגש לפרויקט הראשי וניצור פורק.
**פורק זו פעולה שמעתיקה את הריפו של הפרויקט הראשי אל הגיטהאב שלנו.**

![כפתור fork](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/1-fork-btn.png)

אין צורך לבצע שינויים במסך הביניים, פשוט לאשר, וזה מיד יעביר אותנו אל הריפו שנוצר אצלנו.
נוכל לראות שהפורק, הריפו שנוצר אצלנו, ממש זהה לריפו של הפרויקט הראשי.

![יצירת fork](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/2-create-fork.png)

#### 2. יצירת קלון Clone

בריפו שנוצר אצלנו, בפורק, נעשה קלון.
**זה למעשה יוצר עותק של הפרויקט על המחשב שלנו, ומאפשר לנו להריץ אותו לוקאלית.**

![יצירת clone](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/4-clone.png)

אפשר לעשות את זה דרך הטרמינל, ואפשר גם ממש להוריד ידנית את הפרויקט בקובץ zip.
נדגים את הפעולה הזו דרך הטרמינל.
נעתיק את הקישור ובטרמינל נריץ את הפקודה:

    git clone https://github.com/[your user]/os-practice.git

זה יצור לנו את הפרויקט על המחשב, ועכשיו נוכל לעבוד עליו ולהריץ אותו מקומית.
![הפרויקט המקומי](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/local-project.png)

_**נשים לב!** שתי הפעולות האלו, פורק וקלון, אלו פעולות שנעשה פעם אחת כשנצטרף לפרויקט. מכאן המשך התהליך זו רוטינה שחוזרת על עצמה._

#### 3. פתיחת אישיו Issue

בשלב הבא נחזור **לפרויקט הראשי**, לא לפורק שלנו, וניגש ללשונית אישיוז.

**מה זה בכלל אישיו?**

אישיו הוא משימה שצריך לבצע בפרויקט - זה יכול להיות באג שצריך לתקן, פיצ'ר שצריך לפתח וכו'.

בדרך כלל קיימת רשימה של אישיוז, משימות, ואם נרצה לטפל באישיו מסוים - נצטרך להגיב עליו ולבקש.
עושים את זה כדי לשמור על סדר ולהימנע מעבודה כפולה.

אם נרצה לפתוח אישיו חדש, נצטרך לתת לו כותרת ותיאור.
הקו המנחה הוא שהמידע הזה צריך להיות כמה שיותר ברור, ושאחרים יוכלו להבין בקלות למה אנחנו מתכוונים.
כדאי לצרף דברים כמו צילומי מסך, הסבר איך לשחזר את הבאג, רפרנס לדוגמה וכו'.

במקרה שלנו בפרויקט התרגול - אנחנו נפתח את האישיו, ואוטומטית נהיה מוגדרים כאחראים עליו (זו אוטומציה ספציפית לפרויקט הזה, כאמור בדרך כלל צריך להגיב ולבקש ממנהלי הפרויקט שיגדירו אותנו).

![יצירת issue](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/6-new-issue.png)

![יצירת issue](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/7-set-issue.png)

![הגדרה אוטומטית של אחראי](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/8-auto-assign.png)

#### 4. יצירת בראנץ', עבודה, ודחיפת השינויים Branch, Code & Push

**חזרה למגרש שלנו!**

נפתח בראנץ' לאישיו שיצרנו - הרעיון הוא לפתוח בראנץ' נפרד לכל אישיו.

נעבוד על המשימה שלנו, במקרה שלנו נוסיף קובץ טקסט לפרויקט.
וכשנסיים נדחף את השינויים לבראנץ'.

אפשר לפתוח בראנץ' בגיטהאב ואפשר גם דרך ה-VSCode.
נלחץ על ה-main שבפינה השמאלית למטה, ונבחר בתפריט Create new branch.
ניתן לו שם, שיהיה בעל משמעות כמובן.

![פתיחת branch](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/9-new-branch.png)

נוכל לראות שאיפה שהיה main קודם עכשיו מופיע הבראנץ' החדש שפתחנו - כלומר עכשיו אנחנו עובדים על הבראנץ' החדש, וכל השינויים שנבצע ישמרו רק בו.

נתקין את כל הספריות באמצעות הפקודה

    npm install
ונריץ את הפרויקט.

לאחר מכן נוסיף את השינויים שלנו - קובץ טקסט פשוט לתיקייה

    Docs/people
נוכל לראות ב-local host את השינויים שביצענו.

![עבודה מקומית](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/see-changes.png)

נראה טוב!
אז יאללה נעשה קומיט ופוש.

![ביצוע commit](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/10-commit.png)

![ביצוע push](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/11-push.png)

אם נסתכל על הפורק שלנו נוכל לראות ברשימת הבראנצ'ים את הבראנץ' החדש שפתחנו.
נשים לב שבבראנץ' הראשי השינויים שעשינו לא מופיעים, הם רק בבראנץ' שעבדנו עליו.

![הבראנץ' שלנו](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/12-see-branch.png)

#### 5. פתיחת פול ריקווסט Pull Request

עכשיו נחזור **לפרויקט הראשי**, ונפתח בו פול ריקווסט למיזוג הבראנץ' שלנו אל הפרויקט.

**מה זה בכלל פול ריקווסט?**

פול ריקווסט זו בקשה למזג את העבודה שלנו אל תוך הפרויקט הראשי.

מנהלי הפרויקט עוברים על הבקשות האלו, עושים קוד ריוויו, נותנים פידבק ומבקשים תיקונים לפי הצורך.
הם אלו שמבצעים את המיזוג של השינויים אל תוך הפרויקט. פול ריקווסט לא דוחף מיידית את מה שעשינו!

גם פה נצטרך לתת כותרת ותיאור, וגם כאן הקו המנחה הוא להסביר בצורה ברורה מה השינויים שעשינו.
בתיאור נרצה לקשר אל האישיו שפתרנו. נעשה את זה באמצעות האשטאג (#) שפותח רשימה וממנה נבחר את האישיו הרלוונטי.

אז בריפו של הפרויקט הראשי, ניגש ללשונית פול ריקווסטס ונפתח חדש.
נלחץ על compare across forks, ובצד שמאל נראה את הריפו והבראנץ' הראשי של הפרויקט, ובצד ימין נבחר את הפורק שלנו ואת הבראנץ' שעבדנו עליו.

![יצירת PR](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/13-new-pr.png)

![יצירת PR](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/14-choose-fork-branch.png)

נוכל להסתכל על כל השינויים והקומיטים שביצענו, ונלחץ על Create pull request.
הפול ריקווסט נוצר ומריץ מספר בדיקות ואוטומציות. תוך כמה רגעים זה מסתיים, והפול ריקווסט שלנו מוכן לריוויו על ידי מנהלי הפרויקט.

![קישור לאישיו](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/16-link-issue.png)

![יצירת PR](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/15-create-pr.png)

הידד! השלמנו את התהליך! תרגלנו תרומה לקוד פתוח!

### אז מה עשינו בעצם? בואו נעשה קצת סדר

למעשה האישיוז והפול ריקווסטים מנוהלים בפרויקט הראשי בלבד.
הבראנצ'ים שאנחנו נפתח והעבודה שנעשה - כל זה קורה בפורק שלנו.
ובאמצעות הפול ריקווסט שנפתח, נבצע את התרומה שלנו לקוד של הפרויקט.

אם נרצה, נוכל לקחת על עצמנו אישיו נוסף בפרויקט, ולעשות שוב את כל התהליך הזה.
חשוב ממש שנשים לב, לפני שנתחיל לעבוד על עוד אישיו, שהפורק שלנו מעודכן.

מה הכוונה?

### עדכון הפורק Sync

יכול להיות שמאז שיצרנו את הפורק, התקבלו פול ריקווסטים של אנשים אחרים, ולמעשה הקוד של הפרויקט הראשי השתנה.
זה יכול לגרום להתנגשויות כשנרצה לפתוח פול ריקווסט חדש.

נחזור לפורק שלנו, ונשים לב שאנחנו חוזרים לבראנץ' הראשי.
נוכל לראות הודעה שאומרת אם הפורק שלנו מעודכן או לא.
אם הוא לא מעודכן, נלחץ על הכפתור של סנכרון הפורק וזה יתעדכן.
עכשיו אנחנו מוכנים לצאת שוב לדרך!

![סנכרון הפורק](https://raw.githubusercontent.com/Maakaf/maakaf_home/main/assets/images/how_to_start/18-sync.png)

### לסיכום

פתאום תרומה לקוד פתוח כבר לא נראית כל כך מאיימת הא?

עכשיו כשתרגלתם את זה במו ידיכם, הגיע הזמן למצוא פרויקטים לתרום אליהם.
כדי למצוא אותם בעמוד הפרוייקטים המומלצים באתר שלנו.

<a class="btn btn-outline-primary" href="/he/guides/projects" target="_blank">🔗 לפרויקטים המומלצים</a>

{{< comments >}}
