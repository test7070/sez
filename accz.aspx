<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title></title>
    <script src="../script/jquery.min.js" type="text/javascript"></script>
    <script src='../script/qj2.js' type="text/javascript"></script>
    <script src='qset.js' type="text/javascript"></script>
    <script src='../script/qj_mess.js' type="text/javascript"></script>
    <script src="../script/qbox.js" type="text/javascript"></script>
    <script src='../script/mask.js' type="text/javascript"></script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        var q_name="accz";
        var q_readonly = ['txtYear_depl','txtTotal'];
        var bbmNum = [['txtMount',10, 0, 1],['txtEcount',10, 0, 1],['txtRate',3, 2, 1],['txtScrapvalue',14, 0, 1],['txtMoney',14, 0, 1],['txtFixmoney',14, 0, 1],['txtAccumulat',14, 0, 1],['txtYear_depl',14, 0, 1],['txtEndvalue',14, 0, 1],['txtTotal',14, 0, 1]]; 
        //var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
        aPop = new Array(
        	['txtNoa', 'lblNoa', 'acc', 'acc1,acc2', 'txtNoa,txtNamea', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
        	['txtDepl_ac', 'lblAcc', 'acc', 'acc1,acc2', 'txtDepl_ac,txtNamea2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
        );
        $(document).ready(function () {
            bbmKey = ['noa'];
            q_brwCount();
            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy + "_" + r_cno )
            $('#txtNoa').focus
        });
        //////////////////   end Ready
       function main() {
           if (dataErr)   
           {
               dataErr = false;
               return;
           }
            mainForm(0); // 1=Last  0=Top
        }  ///  end Main()


        function mainPost() { 
			q_getFormat();
        	bbmMask = [['txtIndate', r_picd],['txtFixdate', r_picd]];
            q_mask(bbmMask);
            $('#btnAccc').click(function () {
            	q_box("acczt.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" , '', "95%", "650px", q_getMsg('popOrde'));
            })
            $('#btnCommand4').click(function () {
            	q_box("accza.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" , '', "95%", "650px", q_getMsg('popOrde'));
            })
            $('#btnCommand1').click(function () {
            	q_box("acczs.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';" +  r_accy , '', "95%", "650px", q_getMsg('popOrde'));
            })
            $('#btnCommand2').click(function () {
				q_box('z_accz.aspx' + "?;;;;" + r_accy, '', '95%', '650px', q_getMsg("popPrint"));
            })
            $('#txtNoa').change(function(){
            	var s1 = trim($(this).val());
            	if(s1.length > 4 && s1.indexOf('.') <0)
            		$(this).val(s1.substr(0,4) + '.' + s1.substr(4));
            	if(s1.length == 4)
            		$(this).val(s1 + '.');
            })
            $('#txtDepl_ac').change(function(){
            	var s1 = trim($(this).val());
            	if(s1.length > 4 && s1.indexOf('.') <0)
            		$(this).val(s1.substr(0,4) + '.' + s1.substr(4));
            	if(s1.length == 4)
            		$(this).val(s1 + '.');
            })
            $('#txtMoney').change(function(){
            	if(q_float('txtMoney') != 0 && q_float('txtFixmoney') > 0 )
            		alert(q_getMsg('lblMoney') + ' ' + q_getMsg('lblFixmoney') + '不可同時存在。');
            		
            	sum();
            })
            $('#txtFixmoney').change(function(){
            	if(q_float('txtFixmoney') !=0 && q_float('txtMoney') > 0)
            		alert(q_getMsg('lblMoney') + ' ' + q_getMsg('lblFixmoney') + '不可同時存在。');
            	sum();
            })
            $('#txtAccumulat').change(function(){
            	sum();
            })
            $('#txtYear').change(function(){
            	sum();
            })
            $('#txtEndvalue').change(function(){
            	sum();
            })
            $('#txtRate').change(function(){
            	var rate = trim($(this).val().valueOf());
            	if(rate >=0 && rate <= 1){
            		if(rate.indexOf('.') < 0)
            			$(this).val(rate + '.00');
            		else{
	            		if(rate.length == 3)
	            			$(this).val(rate + '0');
	            		else if(rate.length <3)
	            			$(this).val(rate + '00');
	            	}
            	}else{
            		alert(q_getMsg('lblRate') + '提撥率應介於 0 ~ 1 之間');
            		$(this).val('1.00');
            	}
            })
            $('#txtScrapvalue').blur(function() {
                    $('#txtMemo').focus();
                }).keydown(function(e) {
			 		if ( e.keyCode=='13' ){
			 			event.returnValue= false;
				   		event.keyCode= 9;
				  	}
				});
        }
		function sum(){
			var endvalue = 0;
			var money = q_float('txtMoney');
			var fixmoney = q_float('txtFixmoney');
			var year = q_float('txtYear');
			var accumulat = q_float('txtAccumulat');
			var year_depl = q_float('txtYear_depl');
			var total = 0;
			if(year > 0 && !($('#chkIsdepl')[0].checked==true)){
				endvalue = (money + fixmoney)/(year+1);
			}	
			$('#txtEndvalue').val(endvalue.toFixed(0));
			total = money + fixmoney-accumulat-year_depl;
			$('#txtTotal').val(parseFloat(total,10));
		}
        function q_boxClose( s2) {
            var ret; 
            switch (b_pop) {
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }


        function q_gtPost(t_name) {  
            switch (t_name) {
                 case q_name: 
                 	if (q_cur == 4)  
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        
        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('accz_s.aspx', q_name + '_s', "500px", "330px", q_getMsg( "popSeek"));
        }

        function btnIns() {
            _btnIns();
            $('#txtNoa').focus();
            $('#txtIndate').val(q_date());
            $('#txtRate').val('1.00');
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtNoa').focus();
        }

        function btnPrint() {
			q_box('z_accz.aspx' + "?;;;;" + r_accy, '', '95%', '650px', q_getMsg("popPrint"));
        }
        function btnOk() {
            if (!q_cd($('#txtIndate').val())) {
            	alert(q_getMsg('lblIndate') + '錯誤。');
                return;
            }
            if (!q_cd($('#txtFixdate').val())) {
            	alert(q_getMsg('lblFixdate') + '錯誤。');
                return;
            }
            var t_err = '';
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
            if( t_err.length > 0) {
                alert(t_err);
                return;
            }
            var t_noa = trim($('#txtNoa').val());
            if ( t_noa.length==0 )  
                q_gtnoa(q_name, t_noa);
            else
                wrServer(  t_noa);
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
                width: 38%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
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
                width: 60%;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 2%;
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
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
    </style>
</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewNamea'></a></td>
                <td align="center" style="width:40%"><a id='vewDepl_ac'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='namea'>~namea</td>
                   <td align="center" id='depl_ac'>~depl_ac</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 73%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
            <tr>
               <td class="td1"><span> </span><a id='lblNoa' class="lbl btn"></a></td>
               <td class="td2"><input id="txtNoa" type="text" class="txt c1"/></td>
               <td class="td3" align="right"><input id="chkIsdepl" type="checkbox" /></td>
               <td class="td4"><a id="lblDepl_ac"></a></td>
               <td class="td5"></td>
               <td class="td6"></td>              
            </tr>
           <tr>
               <td class="td1"><span> </span><a id="lblNamea" class="lbl"></a></td>
               <td class="td2"><input id="txtNamea"  type="text"  class="txt c1"/></td>
               <td class="td3"></td>
               <td class="td4"></td>
               <td class="td5"></td>
               <td class="td6"></td>
            </tr>            
            <tr>
               <td class="td1"><span> </span><a id='lblAcc' class="lbl btn"></a></td>
               <td class="td2"><input id="txtDepl_ac"  type="text" class="txt c2"/><input id="txtNamea2"  type="text" class="txt c3"/></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblMount' class="lbl"></a></td>
               <td class="td2"><input id="txtMount"  type="text" class="txt num c1"/></td>
	           <td class="td3"><span> </span><a id='lblUnit' class="lbl"></a></td>
               <td class="td4"><input id="txtUnit"  type="text" class="txt c1" /></td>
               <td class="td5"><span> </span><a id='lblEcount' class="lbl"></a></td>
               <td class="td6"><input id="txtEcount"  type="text"  class="txt num c1" /></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblMoney' class="lbl"></a></td>
               <td class="td2"><input id="txtMoney"  type="text" class="txt num c1" /></td>
               <td class="td3"></td>
               <td class="td4"></td>
               <td class="td5"></td>
               <td class="td6"></td>
 	       </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblFixmoney' class="lbl"></a></td>
               <td class="td2"><input id="txtFixmoney"  type="text" class="txt num c1" /></td>
               <td class="td3"><span> </span><a id='lblFixdate' class="lbl"></a></td>
               <td class="td4"><input id="txtFixdate"  type="text" class="txt c1" /></td>
               <td class="td5"></td>
               <td class="td6"></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblAccumulat' class="lbl"></a></td>
               <td class="td2"><input id="txtAccumulat"  type="text" class="txt num c1" /></td>
               <td class="td3"></td>
               <td class="td4"></td>
	           <td class="td5"></td>
               <td class="td6"></td>
            </tr>  
	    <tr>
               <td class="td1"><span> </span><a id='lblYear' class="lbl"></a></td>
               <td class="td2"><input id="txtYear"  type="text" class="txt num c1"/></td>
               <td class="td3"></td>
               <td class="td4"></td>
	           <td class="td5"></td>               
               <td class="td6"></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblEndvalue' class="lbl"></a></td>
               <td class="td2"><input id="txtEndvalue"  type="text" class="txt num c1" /></td>
               <td class="td3"></td>
               <td class="td4"></td>
	           <td class="td5"></td>
               <td class="td6"></td>
               
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblYear_depl' class="lbl"></a></td>
               <td class="td2"><input id="txtYear_depl"  type="text" class="txt num c1"/></td>
               <td class="td3"></td>
               <td class="td4"><input id="btnCommand3" type="button"  /></td>
	           <td class="td5" ></td>
               <td class="td6"></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblIndate' class="lbl"></a></td>
               <td class="td2"><input id="txtIndate"  type="text" class="txt c1" /></td>
               <td class="td3"></td>
               <td class="td4"><input id="btnAccc" type="button" /></td>
	           <td class="td5"></td>
               <td class="td6"></td>
            </tr> 
	       <tr>
               <td class="td1"><span> </span><a id='lblRate' class="lbl"></a></td>
               <td class="td2"><input id="txtRate" type="text" class="txt num c1" /></td>
	           <td class="td3"></td>
               <td class="td4"><input id="btnCommand4" type="button"  /></td>
               <td class="td5"></td>
               <td class="td6"></td>
            </tr> 
            <tr>
               <td class="td1"><span> </span><a id='lblScrapvalue' class="lbl"></a></td>
               <td class="td2"><input id="txtScrapvalue"  type="text" class="txt num c1" /></td>
               <td class="td3"><span> </span><a id="lblNscrapvalue" class="lbl"></a></td>
               <td class="td4"><input id="btnCommand2" type="button"  /></td>
               <td class="td5"></td>
               <td class="td6"></td>
            </tr>
            <tr>   
                <td class="td1"><span> </span><a id='lblTotal' class="lbl"></a></td>
                <td class="td2"><input id="txtTotal"  type="text" class="txt num c1" /></td> 
                <td class="td3"></td>
                <td class="td4"><input id="btnCommand1" type="button" /></td> 
                <td class="td5"></td>
                <td class="td6"></td> 
            </tr>       
           <tr>
               <td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
               <td class="td2" colspan="5"><textarea id="txtMemo" rows="5" cols="10" style="width: 98%; height: 50px;"></textarea></td>               
            </tr>        
        </table>
        </div>
        </div>
         <input id="q_sys" type="hidden" />    
</body>
</html>
            