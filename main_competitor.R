library(methods)

source("tag_class_UPTagRe.R") #「更新」表：TagRelations的updateTime
source("tag_class_DELTagRecord.R")#匯入「要移除的」tag relation到usertagrelationsrecord
source("tag_class_DELTagRe.R")#移除tagrelation
source("tag_class_ADDTagRecord.R")#匯入「要新增的」tag relation到usertagrelationsrecord
source("tag_class_ADDTagRe.R")#新增tagrelation
#呼叫tagname
source("tag_obj_AppCompetitor.R")
#呼叫SQL
source("tag_SQL_READER.R")
source("tag_SQL_WRITER.R")

#呼叫userDeviceAppList更新程式
source("tag_class_userID_userDeviceAppList.R")

#main appPackageName對應的tagID
tag_list_df<-as.data.frame(tag_list@tagID,tag_list@AppPackageName)
tag_list_AppPackageName <- rownames(tag_list_df)
rownames(tag_list_df) <- NULL
tag_list_df <- cbind(tag_list_AppPackageName,tag_list_df)
colnames(tag_list_df) <-c("appPackageName","tagID")

#main 取出需要更新的userID
tag_appPackage_userID<-tag_update_userDeviceAppList_userID(tag_list)
tag_appPackage_userID<-merge(tag_appPackage_userID,tag_list_df,key="appPackageName",all.x = T)
for (i in 1:nrow(tag_appPackage_userID)) {
  tag_appPackage_userID$user.tagID[i]<-data.frame(data=paste(c(tag_appPackage_userID$userID[i],tag_appPackage_userID$tagID[i]),collapse = ","))
}

#「更新」表：TagRelations的updateTime
tag_re_users<-tag_update_tagrelations_updateTime(tag_list) 
for (i in 1:nrow(tag_re_users)) {
  tag_re_users$user.tagID[i]<-data.frame(data=paste(c(tag_re_users$userID[i],tag_re_users$tagID[i]),collapse = ","))
}

#匯入「要移除的」tag relation到usertagrelationsrecord A %in% B：A 是否在 B 中

del_userID <- tag_re_users[!(tag_re_users$user.tagID %in% tag_appPackage_userID$user.tagID),]

del_class_userID<-new("tag_DELTagRecord",
                      userID = del_userID$userID,
                      tagID = del_userID$tagID)

tag_DELTagRecord(del_class_userID)

#tag_appPackage_userID
del_userID_chr<-toString(paste("'",del_userID$userID, "'", sep = ""))
tag_DEL_tagrelations(tag_list)

#匯入「要新增的」tag relation到usertagrelationsrecord
ADD_userID <- tag_appPackage_userID[!(tag_appPackage_userID$user.tagID %in% tag_re_users$user.tagID),]

ADD_class_userID<-new("tag_ADDTagRecord",
                      userID = ADD_userID$userID,
                      tagID = ADD_userID$tagID)

tag_ADDTagRecord(ADD_class_userID)

#新增tagrelation
tag_ADD_tagrelations(ADD_class_userID)
print("Tags already updated")

cons <- dbListConnections(MySQL())
for(con in cons)dbDisconnect(con)

print("Finished!")

