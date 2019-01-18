<%@page import="com.myneko.client.cart.service.CartService"%>
<%@page import="com.myneko.client.cart.vo.CartVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tag" uri="/WEB-INF/tld/custom_tag.tld"%>
<%-- <%
   session.setAttribute("m_id", "donut123");
%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
   href="/resources/include/css/cart.css?ver=4" />
<script type="text/javascript"
   src="/resources/include/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
   $(function() {

      // 상품 주문하기 누르면 실행
   var data = $("#thischeck").val();
   
      $("#goorder").click(function() {
      if (data != null) {
         var remove = "<%session.removeAttribute("rnp_pnumber");%>"
         var con_test = confirm("주문 하시겠습니까?");
         if (con_test == true) {
            remove
            location.href = "/cart/payment?m_number=${m_number}";
         } else if (con_test == false) {

         }
      } else {
         alert("장바구니에 담긴 상품이 없습니다.")
      }
      });
      
   

      // 장바구니 상품 수량 수정
      $(".edit").click(function() {
         var ct_number = $(this).attr("data-num");
         var ct_amount = $(this).parent("td").children(".ctAmount").val();
         if (!chkData(".ctAmount", "수량을"))
            return;
         
         if (confirm("수량을 변경하시겠습니까?")) {
        	 var data = {
        		"ct_number" : ct_number,
        		"ct_amount" : ct_amount
        	 };
            $.ajax({
               url : '/cart/' + ct_number + ".do" ,
               type : 'post',
               data : data,
               error : function() {
            	   return;
               },
               success : function(result) {
                  console.log("result: " + result);
                  if (result == 'SUCCESS') {
                     history.go(0)
                  } else {
                     alert("수량 변경 실패")
                  }
               }
            });

         }
      });      

      // 선택한 상품 삭제
      $("#checkdelete").click(function() {
         if (confirm("선택하신 제품을 삭제하시겠습니까?")) {
            $("input[name=thischeck]:checked").each(function() {
               var test = $(this).val();
               $.ajax({
                  type : 'delete',
                  url : '/cart/' + test + ".do",
                  headers : {
                     "Content-Type" : "application/json",
                     "X-HTTP-Method-Override" : "DELETE"
                  },
                  dataType : 'text',
                  success : function(result) {
                     console.log("result: " + result);
                     if (result == 'SUCCESS') {
                        history.go(0)
                     }
                  }
               });
            });
         } else {
            alert("선택한 상품이 없습니다.");
         }
      });

      // 장바구니 상품 삭제      
      $(document).on("click", "#thisDelete", function() { 
         var currLi = $(this).parents("tr");
         cartNum = currLi.attr("data-num");

         if (confirm("선택하신 상품을 삭제하시겠습니까?")) {
            $.ajax({
               type : 'delete',
               url : '/cart/' + cartNum + ".do",
               headers : {
                  "Content-Type" : "application/json",
                  "X-HTTP-Method-Override" : "DELETE"
               },
               dataType : 'text',
               success : function(result) {
                  console.log("result: " + result);
                  if (result == 'SUCCESS') {
                     history.go(0)
                  }
               }
            });
         } else {
            alert("삭제 되지 않았습니다.");
         }
      });
   });

   // 데이터 입력 확인
   function chkData(item, msg) {
      if ($(item).val().replace(/\s/g, "") == "") {
         alert(msg + " 입력해 주세요.");
         $(item).val("");
         $(item).focus();
         return false;
      } else {
         return true;
      }
   }

   // 전체 선택
   function allcheck() {
      if ($("#td_check").is(':checked')) {
         $("input[name=thischeck]").prop("checked", true);
      } else {
         $("input[name=thischeck]").prop("checked", false);
      }
   }
</script>
</head>
<body>
   <div id="cartContainer" align="center">
      <div>
         <!-- 장바구니 아이콘 -->
         <img id="cartimg" src="/resources/include/images/11cart.png">

         <table summary="장바구니 목록" border="1">
            <colgroup>
               <col width="5%" />
               <col width="10%" />
               <col width="40%" />
               <col width="12%" />
               <col width="10%" />
               <col width="15%" />
               <col width="8%" />
            </colgroup>
            <thead>
               <tr>
                  <th><input type="checkbox" name="allcheck" id="td_check"
                     onclick="allcheck();"></th>
                  <!-- 전체 선택 check box -->
                  <th colspan="2">상품명</th>
                  <th>가격</th>
                  <th>수량</th>
                  <th>주문금액</th>
                  <th>삭제</th>
               </tr>
            </thead>
            <tbody>
               <!-- 데이터 출력 -->
               <c:choose>
                  <c:when test="${not empty cartList}">
                        <c:forEach var="cart" items="${cartList}" varStatus="status">
                        
                           <!-- 장바구니에 담긴 상품 총 가격 -->
                           <c:set var="money" value="${money + cart.total_money }" />
                           <!-- 배송비 -->
                           <c:set var="fee" value="3000" />
                           <!-- 상품 총 가격과 배송비 합친 것 -->
                           <c:set var="all" value="${money + fee}" />
               
                           <tr data-num="${cart.ct_number}">
                              <!-- 장바구니 번호 -->
                              <td align="center"><input type="checkbox" id="thischeck"
                                 name="thischeck" value="${cart.ct_number}"></td>

                              <c:choose>
                                 <c:when test="${ not empty productList }">
                                    <c:forEach var="product" items="${ productList }" varStatus="status2">
                                       <c:if test="${ cart.p_name == product.p_name }">
                                          <!-- 상품 이미지 -->
                                          <td align="center">
                                             <img id="fileImage" src="/uploadStorage/product/thumbnail/${ product.p_thumbnail }">
                                          </td>
                                       </c:if>      
                                    </c:forEach>
                                 </c:when>
                                 <c:otherwise>
                                    <td>
                                    </td>
                                 </c:otherwise>
                              </c:choose>
                              
                              <!-- 상품 이름 -->
                              <td id="pname">${cart.p_name}</td>

                              <!-- 상품 가격 -->
                              <td align="center"><fmt:formatNumber
                                    pattern="###,###,###" value="${cart.p_price}" />원</td>

                              <!-- 상품 수량 + 수량 변경 버튼 -->
                              <td id="editinput"><input type="text" class="ctAmount"
                                 value="${cart.ct_amount}"> <input type="button"
                                 class="edit" value="변경"  data-num="${cart.ct_number}" /> <!-- 상품가격 x 상품 수량 -->
                              <td align="center"><fmt:formatNumber
                                    pattern="###,###,###" value="${cart.money}" />원</td>

                              <!-- 삭제 버튼 -->
                              <td align="center">
                                 <button id="thisDelete">삭제</button>
                              </td>
                           </tr>
                        </c:forEach>
                  </c:when>
                  <c:otherwise>
                     <tr>
                        <td colspan="7" align="center">장바구니에 담긴 상품이 없습니다.</td>
                     </tr>
                  </c:otherwise>
               </c:choose>
            </tbody>
         </table>
         <br>
         <c:choose>
            <c:when test="${not empty cartList }">
               <div>
                  총 상품가격
                  <font color="#EB6181" size="5"><fmt:formatNumber pattern="###,###,###" value="${money }" /></font>원&nbsp;
                  + 배송비 
                  <font color="#EB6181" size="5"><fmt:formatNumber pattern="###,###,###" value="${fee }" /></font>원&nbsp;
                  = 총 주문금액 
                  <font color="red" size="5"><fmt:formatNumber pattern="###,###,###" value="${all }" /></font>원
               </div>
            </c:when>
            <c:otherwise>
            <div>
               총 상품가격
               <font color="#EB6181" size="5"><fmt:formatNumber pattern="###,###,###" value="0" /></font>원&nbsp;
               + 배송비 
               <font color="#EB6181" size="5"><fmt:formatNumber pattern="###,###,###" value="0" /></font>원&nbsp;
               = 총 주문금액 
               <font color="red" size="5"><fmt:formatNumber pattern="###,###,###" value="0" /></font>원
            </div>
         </c:otherwise>
         </c:choose>
         <br>
         <div align="center">
            <button id="goorder">상품 주문하기</button>
            &nbsp;
            <button id="checkdelete">선택상품 삭제하기</button>
         </div>
      </div>
   </div>
</body>
</html>