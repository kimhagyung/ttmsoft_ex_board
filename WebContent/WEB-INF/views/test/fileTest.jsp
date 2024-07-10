 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${root}/resources/se2/js/service/HuskyEZCreator.js"></script>
 
</head>
<body>
<div class="container" style="margin-top: 50px; text-align: center;">
   <div>
   <input  type="file" name="files" id="files" class="files form-control form-control-sm" multiple>
</div>  
    <ul id="fileList"></ul>
</div> 

<script>
$(document).ready(function() {
   const dataTransfer = new DataTransfer();

    $("#files").change(function(){
       
        let fileArr = document.getElementById("files").files

        if(fileArr != null && fileArr.length>0){

          // =====DataTransfer 파일 관리========
            for(var i=0; i<fileArr.length; i++){
                dataTransfer.items.add(fileArr[i])
            }
            document.getElementById("files").files = dataTransfer.files;
            console.log("dataTransfer =>",dataTransfer.files)
            console.log("input FIles =>", document.getElementById("files").files)
            
      // ==========================================
           
        }
         
    });
            
       $("#fileList").click(function(event){
           let fileArr = document.getElementById("files").files
           if(event.target.className=='remove_button'){
               // console.log(event.target.dataset.index )
               targetFile = event.target.dataset.index 
               
             // ============DataTransfer================
               for(var i=0; i<dataTransfer.files.length; i++){
                   if(dataTransfer.files[i].lastModified==targetFile){
                       // 총용량에서 삭제
                       total_file_size-=dataTransfer.files[i].size
                       
                       dataTransfer.items.remove(i)
                       break
                   }
               }
               document.getElementById("files").files = dataTransfer.files;
        
               const removeTarget = document.getElementById(targetFile);
               removeTarget.remove();
             
               console.log("dataTransfer 삭제후=>",dataTransfer.files)
               console.log('input FIles 삭제후=>',document.getElementById("files").files)

           }
       })
});
</script>
</body>
</html>


<!-- 사용하지 않는 파일임  -->