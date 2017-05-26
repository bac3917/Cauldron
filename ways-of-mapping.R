


## Using both ggplot and choroplethr to map to county level
# tips: http://rforpublichealth.blogspot.com/2015/10/mapping-with-ggplot-create-nice.html
library(ggplot2)
library(maptools)
library(rgeos)
library(raster)
library(ggmap)
library(scales)
library(rgdal)
library(RColorBrewer)

# open shapefile
setwd("//FILESVR01/Research_and_Evaluation_Group/GENERAL/GIS_Shapefiles/census")
county.shp<-readShapeSpatial("cb_2013_us_county_5m.shp" ,repair = TRUE)
class(county.shp)
names(county.shp)   #column names
head(county.shp)

# now get data we want to map
library(RCurl)
HSmap<-getURL("https://raw.githubusercontent.com/bac3917/Cauldron/master/NeedsSurv_MAP.csv")
HSmap<-read.csv(text=HSmap)
library(plyr)
HSmap<-plyr::rename(HSmap,c(fipst="region") )             #rename variables
HSmap<-plyr::rename(HSmap,c(ChallSum_mean="value") )      #rename variables
HSmap$id<-HSmap$region  #we use GEOID to match the files
head(HSmap)  #check to see we have anew column named GEOID

# to merge, we FORTIFY the shapefile...
county2<-fortify(county.shp)
tail(county2)
#merge with coefficients and reorder
merged_county<-merge(county2,HSmap,by="id",all.x=TRUE)
final.plot<-merged_county[order(merged_county$order), ] 


#basic plot  (this works!!!!)
ggplot()+geom_polygon(data=final.plot,
                      aes(x=long,y=lat,group=group,fill=BurnoutTotal_mean),
                      color="black",size=0.25)+
                coord_map(xlim=c(-81,-74),ylim=c(39,43))

# same plot, but add points
Hslocations <- read_csv("//filesvr01/Research_and_Evaluation_Group/GENERAL/GIS_Shapefiles/CSC_Projects/BerksIU/OCDEL EHS CCP Center Information.csv")
qq<-ggplot()+geom_polygon(data=final.plot,
                      aes(x=long,y=lat,group=group,fill=region),
                      color="yellow",size=0.25)+
        coord_map(xlim=c(-81,-74),ylim=c(39,43) )


ggplot()+geom_point(aes(x=Hslocations$LON,y=Hslocations$LAT),data=HSmap)

bb<-qq+geom_point(aes(x=Hslocations$LON,y=Hslocations$LAT),data=HSmap)
qq
bb
###############






county_choropleth
function (df, title = "", legend = "", num_colors = 5, zoom = NULL) 
{
       c = countychoropleth$new(df)
       c$title = title
       c$legend = legend
       c$set_num_colors(num_colors)
       c$set_zoom(zoom)
       c$show_labels = TRUE
       Map1=c$render()
}

data(HSmap)
Map2=county_choropleth(HSmap, 
                        title = "Head Start 2017 Survey - Average # Challenging Behaviors per Staff, by County",
                        legend="Number of Responses",
                        state_zoom = "pennsylvania",
                        reference_map = FALSE) 


Map2


##############
data(df_pop_state)
with_abbr = state_choropleth(df_pop_state,
                             title = "2012 State Population Estimates",
                             legend = "Population")

with_abbr


county_choropleth
function (df, title = "", legend = "", num_colors = 7, zoom = NULL) 
{
        c = StateChoropleth$new(df)
        c$title = title
        c$legend = legend
        c$set_num_colors(num_colors)
        c$set_zoom(zoom)
        c$show_labels = FALSE
        c$render()
}


#### Ben again ######
county_choropleth
function (df, title = "", legend = "", num_colors = 5, zoom = NULL) 
{
        bc = CountyChoropleth$new(df)
        bc$title = title
        bc$legend = legend
        bc$set_num_colors(num_colors)
        bc$set_zoom(zoom)
        bc$show_labels = TRUE
        county=bc$render()
}

county <- data.frame(region = c(42001,42013,42017,42042,42021,42023,42033,42035),
                     value=c(-37102,-41052,35016,-13180,-8062,6357,-46946,-5380))

county_choropleth(county, "PA Test", state_zoom = "pennsylvania") + scale_fill_brewer("Test",palette="Blues")



###################

