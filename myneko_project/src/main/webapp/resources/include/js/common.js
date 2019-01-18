function chkSubmit(item, msg) {
   if (item.val().replace(/\s/g, "") == "") {
      alert(msg + " 입력 해 주세요");
      item.val("");
      item.focus();
      return false;
   } else {
      return true;
   }
}

function checkForm(item, msg) {
   var message = "";
   if (item.val().replace(/\s/g, "") == "") {
      message = msg + " 입력 해 주세요.";
      item.attr("placeholder", message);
      return false;
   } else {
      return true;
   }
}

function formCheck(main, item, msg) {
   if (main.val().replace(/\s/g, "") == "") {
      item.html(msg + " 입력해 주세요");
      main.val("");
      return false;
   } else {
      return true;
   }
}

function chkData(item, msg) {
   if ($(item).val().replace(/\s/g, "") == "") {
      alert(msg + " 입력해주세요");
      $(item).val("");
      $(item).focus();
      return false;
   } else {
      return true;
   }
}

function chkFile(item) {
   var ext = item.val().split('.').pop().toLowerCase();
   if (jQuery.inArray(ext, [ 'gif', 'png', 'jpg', 'jpeg' ]) == -1) {
      alert('gif, png, jpg, jpeg 파일만 업로드 할 수 있습니다.');
      return false;
   } else {
      return true;
   }
}