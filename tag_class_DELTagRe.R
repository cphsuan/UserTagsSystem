
#setClass("tag_DELTagRe",
#         representation(tagID ="character"
#         )
#)

#設定泛型函數class
setGeneric("tag_DEL_tagrelations",
           function(obj){
             tagID_chr<-toString(paste("'",obj@tagID, "'", sep = ""))
             if (nchar(del_userID_chr)==2){
               print("Tag Del-TagRelation not updated")
               }else
                 {
                   SQL_del_userID <- paste0("DELETE FROM usertagrelations where userID IN (",del_userID_chr,") AND tagID IN (",tagID_chr,")")
                   dbSendQuery(mysqlconnection, SQL_del_userID)
                   print("Tag Del-TagRelation already updated")
                 }
             }
           )
print("class_DEL_tagrelations completed")
