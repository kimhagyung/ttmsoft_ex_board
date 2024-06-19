<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    
    var img_count = 1;
    var formData = new FormData();
        
    //pr_img
    //input 파일첨부 버튼 클릭하면 실행되는 change 메서드
    $("#img").change(function fileadd() {
        var reader = new FileReader;
    //이미지 파일 정보와 화면출력을 위해 <img> 태그를 변수로 만듦
        var str = "<img id='img_"+(img_count)+"' src=''/>";
    //파일 경로에 넣기 위해 String으로 변환시켜줌
        var img_count_string = img_count.toString();
        
    //jQuery append 메서드를 사용해 <div id="pr_img"> 안에 <img> 태그 변수를 추가해줌
        $("#pr_img").append(str);
    
    //formdata에 append
    
    //onload는 파일이 업로드 완료된 시점에 function을 발생시키는 메서드
    //<img src=""> 사용자가 업로드한 이미지 파일 경로를 src로 저장해줌(data.target.result) 
        reader.onload = function(data) {
    //태그 안의 속성을 입력할 수 있는 jQuery attr 메서드를 사용 
            $('#img_' + img_count_string).attr('src', data.target.result).width(150);
        };
        
    //화면에 이미지를 출력해주는 FileReader 객체 인스턴스 reader.readAsDataURL();
    //this.files는 <input type="file">을 통해 업로드한 파일의 정보를 저장하고 있는 배열이다.
    //첨부하기 1회당 file 하나만 업로드해서 <img_0,1,2...>에 각각의 파일들을
    //할당시켜줄 것이기 때문에 files[0]로 index 고정    
 
        reader.readAsDataURL(this.files[0]);
    
    //ajax로 전달할 files를 formData에 담는다.  
        formData.append('pr_img_' + img_count_string, this.files[0]);
 
    img_count++;
            
    });
 
 
    //업로드 버튼 클릭
    function fileUpload() {
        
        $.ajax({
            url:"/sellproduct/ajax",
               type: 'POST',
            data: formData,
                processData: false,
                contentType: false,
                success: function(data) {
                    console.log('jQuery ajax form submit success');
                    }
            }); //end ajax
            
        formData.delete;
    }
 
  </script>

</head>
<body>
  <form id="frm" action="sellproduct/done" method="post" enctype="multipart/form-data">
    
    <section class="pr_img">
          <p>    
            <label for="img"><h2>상품 이미지</h2></label>
        </p>
        <div id="pr_img">
            <input type="file" id="img" name="pr_img_files"/>            
        
        </div>
        <%-- <%=request.getRealPath("/") %> --%>
        <input id="upload" type="button" value="업로드" onclick="fileUpload()"/>
    </section>
 
</form>
</body>
</html>
