
# Open and prepare data.
ProjExData <- read.csv("//filesvr01/Research_and_Evaluation_Group/conferences_articles/TeacherPrep_CoTeaching/ProjExMasterDataFile121616.csv")
require(MASS)
require(psych)
require(nlme)
require(lme4)

as.data.frame(ProjExData)
CoTeach<-ProjExData
CoTeach[2:174,]
describe(CoTeach$ZPR_1)

# Various regression models.
# See http://www.ats.ucla.edu/stat/r/dae/rreg.htm for more info on rlm function.
#Unconditional model
lme(ZPR_1~1,data=CoTeach,random=~1|USER_ID)

# Model 1
summary(ols<-lm(ZPR_1~FIDEL_mean_mid,data=CoTeach))   #run basic ols model first
plot(ols,las=1)


rlm(ZPR_1~FIDEL_mean_mid,data=CoTeach,method=c("M"))

# Model 2
rlm(ZPR_1~FIDEL_mean_mid+cohort2,data=CoTeach,method=c("M"))

#Model 3
rlm(ZPR_1~FIDEL_mean_mid+cohort2+enroll100s+urban,data=CoTeach,method=c("M"))


# Use LMER to do multilevel models
# reference: http://www.clayford.net/statistics/unconditional-multilevel-models-for-change-ch-4-of-alda/
# Multilevel model
M1=lmer(ZPR_1 ~ 1+ (1|NCESSCH), REML=F,CoTeach)
summary(M1)
