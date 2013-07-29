
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title> </title>
    <script src="../script/jquery.min.js" type="text/javascript"> </script>
    <script src='../script/qj2.js' type="text/javascript"> </script>
    <script src='qset.js' type="text/javascript"> </script>
    <script src='../script/qj_mess.js' type="text/javascript"> </script>
    <script src="../script/qbox.js" type="text/javascript"> </script>
    <script src='../script/mask.js' type="text/javascript"> </script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" /> 
    <script type="text/javascript">
       
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        var decbbm = [];
        var q_name="acc";
        var q_readonly = [];
        var bbmNum = []; 
        var bbmMask = []; 
        
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'acc1';
        //ajaxPath = ""; //  execute in Root
		
        $(document).ready(function () {
            bbmKey = ['acc1'];
            brwCount2=20
            q_brwCount();
           q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy+'_'+r_cno)
            $('#txtAcc1').focus
        });
 
       function main() {
           if (dataErr)   
           {
               dataErr = false;
               return;
           }
            
            mainForm(0); // 1=Last  0=Top  
        }
        function mainPost() { 
           $('#txtAcc1').change(function () {
           		$('#txtAcc1').val($('#txtAcc1').val().replace(/_/g,''));
           		if(emp($('#txtAcc1').val()))
           		{
           			$('#txtAcc1').focus();
           		}else{
					 var t_where = "where=^^ acc1='"+$('#txtAcc1').val()+"' ^^";
					q_gt(q_name, t_where , 0, 1, 0, "",  r_accy+'_'+r_cno);
				}
		     });
        }

      
        function txtCopy(dest, source) {
            var adest = dest.split(',');
            var asource = source.split(',');
            $('#' + adest[0]).focus(function () { if (trim($(this).val()).length == 0) $(this).val( q_getMsg('msgCopy')); });
            $('#' + adest[0]).focusout(function () {
                var t_copy = ($(this).val().substr(0, 1) == '=');
                var t_clear = ($(this).val().substr(0, 2) == ' =') ;
                for (var i = 0; i < adest.length; i++) {
                    {
                        if (t_copy)
                            $('#' + adest[i]).val($('#' + asource[i]).val());

                        if( t_clear)
                            $('#' + adest[i]).val('');
                    }
                }
            });
        }
        
        function q_boxClose( s2) {
            var ret; 
            switch (b_pop) {
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }
	var accdb=true;
        function q_gtPost(t_name) {  
            switch (t_name) {
                case q_name: if (q_cur == 4)  
                        q_Seek_gtPost();

                   if (q_cur == 1 || q_cur == 2) 
                   {
                   		if(accdb)
                   		{
                   			acc1 = _q_appendData(t_name, "", true);
	                   		if(acc1[0]!=undefined)
	                   		{
								alert("科目編號重複");
								$('#txtAcc1').focus();
							}else{
								var t_where = "where=^^ acc1='"+$('#txtAcc1').val().substr(0,5)+"' ^^";
								q_gt(q_name, t_where , 0, 1, 0, "",  r_accy+'_'+r_cno);
								accdb=false;
							}
						}else{
							var as =_q_appendData(t_name, "", true);
							$('#txtAcc2').val(as[0].acc2);
							//$('#txtBeginmoney').val(as[0].beginmoney);
							$('#txtOacc').val(as[0].oacc);
							$('#txtLok').val(as[0].lok);
							accdb=true;
						}
					}
                    break;
            }  /// end switch
        }
        
        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('acc_s.aspx', q_name + '_s', "500px", "310px", q_getMsg( "popSeek"));
        }

        function combPay_chg() {   
            var cmb = document.getElementById("combPay")
            if (!q_cur) 
                cmb.value = '';
            else
                $('#txtPay').val(cmb.value);
            cmb.value = '';
        }

        function btnIns() {
            _btnIns();
            $('#txtAcc1').focus();
        }

        function btnModi() {
            if (emp($('#txtAcc1').val()))
                return;

            _btnModi();
        }

        function btnPrint() {
 			q_box("z_accp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy + "_" + r_cno, 'z_accc1', "95%", "90%", q_getMsg('popZ_accc1'));
        }
        var acc1=[];
        function btnOk() {
            var t_err = '';
            t_err = q_chkEmpField(['txtAcc1', q_getMsg('lblAcc1')]);
            
            if(acc1[0]!=undefined)
			{
				alert("科目編號重複");
	            return;
			}
            
			var t_acc1 = trim($('#txtAcc1').val());

            if ( t_acc1.length==0 )  
                q_gtacc1(q_name, t_acc1);
            else
                wrServer( t_acc1);
        }

        function wrServer( key_value) {
            var i;

            xmlSql = '';
            if (q_cur == 2)   /// popSave
                xmlSql = q_preXml();

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], '','',2);
        }
       
        function refresh(recno) {
            _refresh(recno);
        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
        }

        function btnMinus(id) {
            _btnMinus(id);
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield);
            if (q_tables == 's')
                bbsAssign();  
        }

        function q_appendData(t_Table) {
            return _q_appendData(t_Table);
        }

        function btnSeek(){
            _btnSeek();
        }

        function btnTop() {
            _btnTop();
        }
        function btnPrev() {
            _btnPrev();
        }
        function btnPrevPage() {
            _btnPrevPage();
        }

        function btnNext() {
            _btnNext();
        }
        function btnNextPage() {
            _btnNextPage();
        }

        function btnBott() {
            _btnBott();
        }
        function q_brwAssign(s1) {
            _q_brwAssign(s1);
        }

        function btnDele() {
            _btnDele();
        }

        function btnCancel() {
            _btnCancel();
        }
    </script>
    <style type="text/css">
         #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 20%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: 16px;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 78%;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                /*border: 1px white double;
                 border-spacing: 0;
                 border-collapse: collapse;*/
                font-size: 16px;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm td {
                width: 10%;
            }
            .tbbm .tdZ {
                width: 2%;
            }
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: 16px;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .tbbm tr td .txt.c1 {
                width: 100%;
                float: left;
            }
            .tbbm tr td .txt.c2 {
                width: 45%;
                float: left;
            }
            .tbbm tr td .txt.c3 {
                width: 55%;
                float: left;
            }
            .tbbm tr td .txt.c4 {
                width: 60%;
                float: left;
            }
            .tbbm tr td .txt.c5 {
                width: 40%;
                float: left;
            }
            .tbbm tr td .txt.num {
                text-align: right;
            }
          	
            .txt.num {
                text-align: right;
            }
            td {
                margin: 0px -1px;
                padding: 0;
            }
            td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size:medium;
            }
            input[type="text"],input[type="button"] {
                font-size:medium;
            }
            input[readonly="readonly"]#txtMiles{
            	color:green;
            }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:25%"><a id='vewAcc1'> </a></td>
                <td align="center" style="width:40%"><a id='vewAcc2'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='acc1'>~acc1</td>
                   <td align="center" id='acc2'>~acc2</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 70%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
          <tr class="tr1">
               <td class="td1"><span> </span><a id="lblAcc1" class="lbl"> </a></td>
               <td class="td2"><input id="txtAcc1" type="text" class="txt c1"/></td>
               <td class="td3"> </td>
               <td class="td4"> </td> 
            </tr>
            <tr class="tr2">
               <td class="td1"><span> </span><a id="lblAcc2" class="lbl"> </a></td>
               <td class="td2"><input id="txtAcc2" type="text" class="txt c1"/></td>
               <td class="td3"> </td>
               <td class="td4"> </td> 
            </tr>      
         <!--<tr class="tr3">
               <td class="td1"><span> </span><a id="lblBeginmoney" class="lbl"> </a></td>
               <td class="td2"><input id="txtBeginmoney" type="text" class="txt num c1"/></td>
               <td class="td3"> </td>
               <td class="td4"> </td> 
         </tr>-->
            <tr class="tr4">
               <td class="td1"><span> </span><a id="lblOacc" class="lbl"> </a></td>
               <td class="td2"><input id="txtOacc" type="text" class="txt c1"/></td>
               <td class="td3"> </td>
               <td class="td4"> </td> 
            </tr>
            <tr class="tr5">
               <td class="td1"><span> </span><a id="lblLok" class="lbl"> </a></td>
               <td class="td2"><input id="txtLok" type="text" class="txt c1"/></td>
               <td class="td3"> </td>
               <td class="td4"> </td> 
            </tr>
        </table>
        </div>
        </div> 
        <input id="q_sys" type="hidden" />
</body>
</html>
