---
title: "Auto Login"
date: 2020-05-15
draft: false
weight : 10
pre: ""
plugin: /opt/repos/idempiere-ita-plugin/it.cnet.impl.extraidempiere
---

## Auto Login idempiere (solo browser Chrome)

(Classe LoginAuto_Idempiere)

Creata classe java per apertura automatica di idempiere (vengono passati nel codice User e Password)

## Scaricare file Chromedriver


```
https://sites.google.com/a/chromium.org/chromedriver/downloads (in base al proprio sistema operativo)
```

Questo file eseguibile è fodamentale per lanciare il browser Chrome, bisogna posizionarlo in una directory a piacere (nella classe Java poi verrà richiamato il path del seguente eseguibile)

## Esempio Classe Java Utilizzata


```
import java.util.HashMap;
import java.util.Map;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
```

```
//AUTO LOGIN DI IDEMPIERE CON SETAGGIO PARAMETRI
public class LoginAuto_Idempiere {
   public static void main(String[] args) throws InterruptedException {
    //impostazioni apertura per Windows XP
    //%HOMEPATH%\Local Settings\Application Data\Google\Chrome\Application\chrome.exe	
    	//impostazioni di apertura per Linux (scaricare il driver ChromeDriver)
      System.setProperty("webdriver.chrome.driver", "/home/andrea/Scrivania/chromedriver");
      DesiredCapabilities capabilities = DesiredCapabilities.chrome();
      capabilities.setCapability(CapabilityType.ForSeleniumServer.ENSURING_CLEAN_SESSION, true);      
      //impostazioni di chrome
      ChromeOptions opts = new ChromeOptions();
      opts.addArguments("start-maximized");
      opts.addArguments("disable-infobars");
      opts.addArguments("--disable-save-password-bubble");     
      //togliere popup salvataggio password (perchè impossibile cmq salvarla)
      Map<String, Object> prefs = new HashMap<String, Object>();
      prefs.put("credentials_enable_service", false);
      prefs.put("profile.password_manager_enabled", false);
       opts.setExperimentalOptions("prefs", prefs);
      capabilities.setCapability(ChromeOptions.CAPABILITY, opts);
      WebDriver driver = new ChromeDriver(capabilities);
      driver.manage().deleteAllCookies();    
       //Indirizzo IP di idempiere
       driver.navigate().to("http://localhost:8080/webui/");    
       Thread.sleep(2000);
      //identifico l'id del primo elemento (nel mio caso lo User)
       WebElement activeElement = driver.switchTo().activeElement(); 
       String className =  activeElement.getAttribute("class"); 
       String id = activeElement.getAttribute("id");       
       //Inserisco i dati e faccio Tab per andare nella riga successiva
       //autologin
       driver.findElement(By.id(id)).sendKeys("GardenAdmin");
       driver.switchTo().activeElement().sendKeys(Keys.TAB);
       driver.switchTo().activeElement().sendKeys("GardenAdmin");
       driver.switchTo().activeElement().sendKeys(Keys.TAB);
       driver.switchTo().activeElement().sendKeys(Keys.TAB);
       driver.switchTo().activeElement().sendKeys(Keys.TAB);
       //driver.switchTo().activeElement().sendKeys(Keys.TAB);
       driver.switchTo().activeElement().sendKeys(Keys.TAB);
       driver.switchTo().activeElement().click();    
       //Chiudere il browser
      //driver.quit();
   }
}
```
