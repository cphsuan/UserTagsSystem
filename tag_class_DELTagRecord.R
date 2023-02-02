
setClass("tag_DELTagRecord",
         representation(userID ="character",
                        tagID ="character"
         )
)

#設定泛型函數class
setGeneric("tag_DELTagRecord",
           function(obj){
             if (length(obj@tagID)==0){
             print("Tag DEL-TagRecord not updated")
               }else
                 {
                 DELrecord_row = data.frame(
                   id = NA,
                   tagID = obj@tagID,
                   userID = obj@userID,
                   isDeleteTag = "1",
                   createdTime = as.numeric(as.POSIXct(Sys.time(), format="%Y-%m-%d %H:%M:%S")),
                   updatedTime = as.numeric(as.POSIXct(Sys.time(), format="%Y-%m-%d %H:%M:%S")),
                   created_at = Sys.time(),
                   updated_at =Sys.time()
                   )
                 dbWriteTable(mysqlconnection, name = "usertagrelationsrecord", value = DELrecord_row, row.names = FALSE, append = TRUE)#新增列
                 print("Tag DEL-TagRecord already updated")
                 }
             }
)
print("class_ADD_DELTagRecord completed")

