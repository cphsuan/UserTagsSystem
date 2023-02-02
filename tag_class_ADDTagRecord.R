# 建立標準，預先定義類別
setClass("tag_ADDTagRecord",
         representation(userID ="character",
                        tagID ="character"
         )
)

#設定泛型函數class
setGeneric("tag_ADDTagRecord",
           function(obj){
             if (length(obj@tagID)==0){
             print("Tag ADD-TagRecord not updated")
               }else{
                 ADDrecord_row = data.frame(
                   id = NA,
                   tagID = obj@tagID,
                   userID = obj@userID,
                   isDeleteTag = "0",
                   createdTime = as.numeric(as.POSIXct(Sys.time(), format="%Y-%m-%d %H:%M:%S")),
                   updatedTime = as.numeric(as.POSIXct(Sys.time(), format="%Y-%m-%d %H:%M:%S")),
                   created_at = Sys.time(),
                   updated_at =Sys.time()
                 )
                 dbWriteTable(mysqlconnection, name = "usertagrelationsrecord", value = ADDrecord_row, row.names = FALSE, append = TRUE)#新增列
                 print("Tag ADD-Record already updated")
                 }
             }
)
print("class_ADDTagRecord completed")

