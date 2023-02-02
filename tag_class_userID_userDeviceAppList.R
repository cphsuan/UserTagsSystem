#APPLIST
# 建立標準，預先定義類別
setClass("tag_name",
         representation(AppPackage ="character",
                        AppPackageName = "character"
         )
)

#設定泛型函數class
setGeneric("tag_update_userDeviceAppList_userID",
           function(obj){
             # append_table <- data.frame(tagID= character(),
             #                            userID= character(),
             #                            createdTime= numeric(),
             #                            updatedTime= numeric(),
             #                            created_at= character(),
             #                            updated_at= character(),
             #                            stringsAsFactors=FALSE)
             time<-Sys.time()-259440 ###259440
             AppPackageName_chr<-toString(paste("'",obj@AppPackageName, "'", sep = ""))
             tag_appPackage <- paste0("select userID, appPackageName from userDeviceAppList where appPackageName IN (",AppPackageName_chr,")"," && ","updatedTime >=","UNIX_TIMESTAMP(STR_TO_DATE('",time,"', '%Y-%m-%d %H:%i:%s'))")
             tag_appPackage_db <- dbSendQuery(mysql_R_connection, tag_appPackage[1]) #取出users,cellphone ###mysql_R_connection
             tag_appPackage_userID<-dbFetch(tag_appPackage_db,n=-1)
             return(tag_appPackage_userID)
             # for (i in 1:length(tagID)){
             #   tag_appPackageName_db <- dbSendQuery(mysqlconnection, tag_appPackageName[i]) #取出users
             #   tag_appPackageName_users<-dbFetch(tag_appPackageName_db,n=-1)
             #   # if (nrow(tag_appPackageName_users)==0){
             #   #   next}
             #   # new_row = data.frame(
             #   #   id = NA,
             #   #   tagID = obj@AppPackage[i],
             #   #   userID = tag_appPackageName_users,
             #   #   createdTime = as.numeric(as.POSIXct(Sys.time(), format="%Y-%m-%d %H:%M:%S")),
             #   #   updatedTime = as.numeric(as.POSIXct(Sys.time(), format="%Y-%m-%d %H:%M:%S")),
             #   #   created_at = Sys.time(),
             #   #   updated_at =Sys.time()
             #   #    )
             #   # append_table <- rbind(append_table, new_row)
             # }
             # #dbSendQuery(mysqlconnection, "SET GLOBAL local_infile = true;")
             #dbWriteTable(mysqlconnection, name = "usertagrelations", value = append_table, row.names = FALSE, append = TRUE)#新增列
             #print("Tags already updated")
           }

)

print("class_writer completed")
