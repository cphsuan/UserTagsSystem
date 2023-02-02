
#設定泛型函數class
setGeneric("tag_ADD_tagrelations",
           function(obj){
             if (length(obj@tagID)==0){
               print("Tag ADD-TagRelation not updated")
             }else
             {
               new_row = data.frame(
                 id = NA,
                 tagID = obj@tagID,
                 userID = obj@userID,
                 createdTime = as.numeric(as.POSIXct(Sys.time(), format="%Y-%m-%d %H:%M:%S")),
                 updatedTime = as.numeric(as.POSIXct(Sys.time(), format="%Y-%m-%d %H:%M:%S")),
                 created_at = Sys.time(),
                 updated_at =Sys.time()
               )
             dbWriteTable(mysqlconnection, name = "usertagrelations", value = new_row, row.names = FALSE, append = TRUE)#新增列
             print("Tag ADD-TagRelation already updated")
           }}
)
print("class_ADD_tagrelations completed")
