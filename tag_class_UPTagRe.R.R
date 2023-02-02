
setGeneric("tag_update_tagrelations_updateTime",
           function(obj){
             tagID_chr<-toString(paste("'",obj@tagID, "'", sep = ""))
             SQL_Up_TagRe <- paste0("update usertagrelations set updatedTime ='",floor(as.numeric(as.POSIXct(Sys.time()), format="%Y-%m-%d %H:%M:%S")),"' where tagID IN (",tagID_chr,")")
             dbSendQuery(mysqlconnection, SQL_Up_TagRe)
              tag_re <- paste0("select userID, tagID from usertagrelations where tagID IN (",tagID_chr,")")
              tag_re_db <- dbSendQuery(mysqlconnection, tag_re[1]) #取出users,cellphone
              tag_re_users<-dbFetch(tag_re_db,n=-1)
             return(tag_re_users)
           }
)
print("class_tagrelations-updateTime completed")
