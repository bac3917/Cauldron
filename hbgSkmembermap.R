library(maptools)
library(rgdal)
library(ggthemes)
library(ggplot2)

setwd("~c:/BasicShapefiles")

CentralPAzips<-readOGR(dsn="C:/BasicShapefiles/CentralPAzips.shp",layer="CentralPAzips")

pa_map <- fortify(CentralPAzips)

# get hbgSk data
library(dplyr)
library(ggplot2)
library(Hmisc)
library(plotly)
library(googlesheets)
suppressMessages(library(dplyr))
my_sheets<-gs_ls()
my_sheets  # prints a list of sheets on the Google account
hbgsk<-gs_title("hbgSk2017") #assigns a paticular sheet to an R dataframe
gs_ws_ls(hbgsk)                         # This command identifies the name of worksheet used in next command

#read data
hbgsk <-hbgsk %>% gs_read(ws = "Form Responses 1")


colnames(hbgsk)<-paste0("Q",1:ncol(hbgsk))
library(reshape)
library(maps)
library(zipcode)
library(viridis)
# http://www.austinwehrwein.com/digital-humanities/creating-a-density-map-in-r-with-zipcodes/
zip_map<-map_data("zips","pennsylvania")

hbgsk<-rename(hbgsk,c(Q5='zip'))
hbgsk$zip<-as.numeric(factor(hbgsk$zip))


us<-map_data("state")
q<-ggplot(hbgsk,aes(CentralPAzips$INTPTLON,CentralPAzips$INTPTLAT))+ geom_polygon(data=us,aes(x=long,y=lat,group=group),
                               color='gray',fill=NA,alpha=.35)+
        geom_point(aes(color=count),size=.15,alpha=.25) +
        theme_awhstin(grid=F)+    xlim(-125,-65)+ylim(20,50)

##########################################################################




# make map
gg<-ggplot()
gg<-gg+geom_polygon(data=CentralPAzips, aes(x=CentralPAzips$INTPTLON, y=CentralPAzips$INTPTLAT), colour='black', fill=NA) 
        
# fills must be factor values!
gg<-gg+geom_map(data=hbgsk,map=pa_map,
                aes(fill=as.factor(hbgsk$zip),map_id=hbgsk$zip), color="#7f7f7f", fill="white", size=0.25)


gg

### another attempt


# tips: http://stackoverflow.com/questions/31641945/choropleth-zip-code?rq=1
library(maptools)
library(rgdal)
library(ggthemes)
library(ggplot2)


CentralPAzips<-readOGR(dsn="Research_and_Evaluation_Group/GENERAL/GIS_Shapefiles/PA/PA_ZIPS/CentralPAzips.shp",
                       layer="CentralPAzips")

#CentralPAzips

Smap<-fortify(CentralPAzips,region="ZCTA4CE")

gg <- ggplot()
#draw the base map polygons
gg<-gg+geom_map(data=Smap,map = Smap,
                aes(x=Smap$long,y=Smap$lat, map_id=Smap$id),
                color="#7f7f7f", size=0.25)
# next, fill in polygons
gg<-gg+geom_map(data=hbgsk,map=Smap, 
                aes(fill=hbgsk$Q6, map_id=hbgsk$zip)  )


