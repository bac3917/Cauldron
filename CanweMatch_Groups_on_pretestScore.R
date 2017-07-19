

# is it permissible to match treatment and comparison cases on their pretests?
# that is: match cases who are equal on pretest and then see how each does?

require(RCurl)
dd<-getURL("https://raw.githubusercontent.com/bac3917/Cauldron/master/ProjExMasterDataFile102416.csv")
dd.raw<-getURL("https://raw.githubusercontent.com/bac3917/Cauldron/master/ProjExMasterDataFile102416.csv")
head(dd)
dd$cohort2<-factor(dd$cohort2,levels=c(1,2),labels =c("Treatment","Comparison"))

boxplot(dd$EFFmeanMID~dd$cohort2,data=dd, main="baseline distibutions")

