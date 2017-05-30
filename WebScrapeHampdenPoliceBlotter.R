
### WEB SCRAPING

## good tutorial: http://francojc.github.io/web-scraping-with-rvest/

library(rvest)

#hampden_police<-html("http://www.hampdentownship.us/township-department/police-department/police-blotter/")


url<-"http://www.hampdentownship.us/township-department/police-department/police-blotter/"
page<-read_html(url)

page %>%
        html_node("p+p , #header_outer h2")%>%
        html_text()


url2<-"http://www.hampdentownship.us/police-blotter-september-2016/"
page2<-read_html(url2)
page2 %>%
        html_node(span | p~p+p)
        html_text()
        
page2 %>%
        html_nodes(xpath='//*[contains(concat( " ", @class, " " ), concat( " ", "content_top", " " ))]//>//p~//p+//p')%>%
        html_table()

        

# HEad Start info
url3<-"http://paheadstart.org/index.php/head-start-in-pa/phsa_programs/greene"
page5<-read_html(url3)
page5 %>%
       html_node(".prog , area , td+ td")%>%
       html_text()

