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
        var q_name="uccb";
        var q_readonly = [];
        var bbmNum = [['textSize1', 10, 3, 1],['textSize2', 10, 2, 1],['textSize3', 10, 3, 1],['textSize4', 10, 2, 1],['txtWeight', 10, 3, 1],['txtPrice', 10, 2, 1],['txtSprice', 10, 2, 1],['txtEmount', 10, 0, 1],['txtGmount', 10, 0, 1],['txtGweight', 10, 3, 1],['txtEweight', 10, 3, 1]]; 
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
		aPop = new Array(['txtProductno', 'lblProductno', 'ucc', 'noa,product,unit', 'txtProductno,txtProduct,txtUnit', 'ucc_b.aspx'],
        ['txtStoreno', 'lblStoreno', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
        ['txtUseno', 'lblUseno', 'cust', 'noa,comp', 'txtUseno,txtUsea', 'cust_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            q_brwCount();
            q_gt(q_name, q_content, q_sqlCount, 1)
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
            q_cmbParse("cmbItype", q_getPara('uccc.itype'));
            bbmMask = [['txtSdate', r_picd],['txtOdate', r_picd]];
        	q_mask(bbmMask);
        	
        	$('#textSize1').change(function () {
				if ($('#txtProduct').val().indexOf('板')>-1|| $('#txtProduct').val().indexOf('捲')>-1){
					q_tr('txtDime' ,q_float('textSize1'));//厚度
				}else if($('#txtProduct').val().indexOf('管')>-1){
					q_tr('txtRadius' ,q_float('textSize1'));//短徑	
				}
			});
			$('#textSize2').change(function () {
				if ($('#txtProduct').val().indexOf('板')>-1|| $('#txtProduct').val().indexOf('捲')>-1){
					q_tr('txtWidth',q_float('textSize2'));//寬度	
				}else if($('#txtProduct').val().indexOf('管')>-1){
					q_tr('txtWidth',q_float('textSize2'));//長徑	
				}
			});
			$('#textSize3').change(function () {
				if ($('#txtProduct').val().indexOf('板')>-1|| $('#txtProduct').val().indexOf('捲')>-1){
					q_tr('txtLengthb',q_float('textSize3'));//長度	
				}else if($('#txtProduct').val().indexOf('管')>-1){
					q_tr('txtDime',q_float('textSize3'));//厚度		
				}else{//鋼筋、胚
					q_tr('txtLengthb' ,q_float('textSize3'));
				}
			});
			$('#textSize4').change(function () {
				if ($('#txtProduct').val().indexOf('板')>-1|| $('#txtProduct').val().indexOf('捲')>-1){
					q_tr('txtRadius' ,q_float('textSize4'));//短徑	
				}else if($('#txtProduct').val().indexOf('管')>-1){
		        	q_tr('txtLengthb' ,q_float('textSize4'));//長度	
				}
			});
			$('#txtProductno').change(function () {
				size_change ();
			});
			$('#txtProduct').change(function () {
				size_change ();
			});
			$('#txtUnit').focusin(function () {
				size_change ();
			});
			$('#textSize1').focusin(function () {
				size_change ();
			});
			$('#textSize2').focusin(function () {
				size_change ();
			});
			$('#textSize3').focusin(function () {
				size_change ();
			});
			$('#textSize4').focusin(function () {
				size_change ();
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

            q_box('uccb_s.aspx', q_name + '_s', "500px", "550px", q_getMsg("popSeek"));
        }

        function btnIns() {
            _btnIns();
            $('#txtNoa').focus();
            $('#txtNoa').val('AUTO');
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            size_change ();
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            size_change ();
        }

        function btnPrint() {
 
        }
        function btnOk() {
        	$('#txtSdate').val($.trim($('#txtSdate').val()));
                if (checkId($('#txtSdate').val())==0){
                	alert(q_getMsg('lblSdate')+'錯誤。');
                	return;
           	}
        	$('#txtOdate').val($.trim($('#txtOdate').val()));
                if (checkId($('#txtOdate').val())==0){
                	alert(q_getMsg('lblOdate')+'錯誤。');
                	return;
           	}
           var t_err = '';

            t_err = q_chkEmpField(['txtNoa', q_getMsg('lblNoa')]);
           
			 var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll( (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
        }

        function wrServer( key_value) {
            var i;

            xmlSql = '';
            if (q_cur == 2)   
                xmlSql = q_preXml();

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], '','',2);
        }
        
        function refresh(recno) {
            _refresh(recno);
           size_change ();
        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
			size_change();
        }

        function btnMinus(id) {
            _btnMinus(id);
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield); 
			size_change();
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
        
        function size_change () {
        	var vcckind='';
        	if($('#txtProduct').val()=='')
        		vcckind=q_getPara('vcc.kind');
        	if(q_cur==1 || q_cur==2){
				$('input[id*="textSize"]').removeAttr('disabled');
			}else{
				$('input[id*="textSize"]').attr('disabled', 'disabled');
			}
        	if( $('#txtProduct').val().indexOf('板')>-1 || $('#txtProduct').val().indexOf('捲')>-1 || vcckind=='1'){
            	$('#lblSize1').text("厚度：");
            	$('#lblSize2').text("寬度：");
            	$('#lblSize3').text("長度：");
            	$('#lblSize1').show();
            	$('#lblSize2').show();
            	$('#lblSize3').show();
            	$('#lblSize4').hide();
	            $('#textSize1').show();
	            $('#textSize2').show();
	            $('#textSize3').show();
			    $('#textSize4').hide();
			    q_tr('textSize1',q_float('txtDime'));
			    q_tr('textSize2',q_float('txtWidth'));
			    q_tr('textSize3',q_float('txtLengthb'));
			}else if( $('#txtProduct').val().indexOf('管')>-1 || vcckind=='2'){
				$('#lblSize1').text("短徑：");
            	$('#lblSize2').text("長徑：");
            	$('#lblSize3').text("厚度：");
            	$('#lblSize4').text("長度：");
            	$('#lblSize1').show();
            	$('#lblSize2').show();
            	$('#lblSize3').show();
            	$('#lblSize4').show();
			    $('#textSize1').show();
	            $('#textSize2').show();
	            $('#textSize3').show();
				$('#textSize4').show();
			    q_tr('textSize1',q_float('txtRadius'));
			    q_tr('textSize2',q_float('txtWidth'));
			    q_tr('textSize3',q_float('txtDime'));
			    q_tr('textSize4',q_float('txtLengthb'));
			}else{//鋼筋和鋼胚
				$('#lblSize3').text("長度：");
				$('#lblSize1').hide();
            	$('#lblSize2').hide();
            	$('#lblSize3').show();
            	$('#lblSize4').hide();
	            $('#textSize1').hide();
	            $('#textSize2').hide();
	            $('#textSize3').show();
			    $('#textSize4').hide();
			    q_tr('textSize3' ,q_float('txtLengthb'));
			}
        }
        
        function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVWXYZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
                    var key = '12121241';
                    var n = 0;
                    var m = 0;
                    for (var i = 0; i < 8; i++) {
                        n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
                        m += Math.floor(n / 10) + n % 10;
                    }
                    if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
                        return 2;
                }else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//西元年
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 3;
                }else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//民國年
                	str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 4
               	}
               	return 0;//錯誤
            }
    </script>
    <style type="text/css">
         #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 98%;
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
                width: 98%;
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
                width: 90%;
                float: left;
            }
            .txt.c2 {
                width: 30%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 27%;
                float: left;
            }
            .txt.c5 {
                width: 70%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
            }
            .txt.c7 {
                width: 95%;
                float: left;
            }
            .txt.c8 {
            	float:left;
                width: 65px;
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
                font-size:medium;
            }
            .tbbm textarea {
            	font-size: medium;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:30%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
             <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:20%"><a id='vewNoa'> </a></td>
                <td align="center" style="width:25%"><a id='vewProduct'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='product,4'>~product,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 65%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>            
            <tr class="tr1">
            <td class='td1'><span> </span><a id="lblNoa" class="lbl"> </a></td>
            <td class="td2" colspan="3"><input id="txtNoa"  type="text" class="txt c7"/></td>
            <td class='td5'><span> </span><a id="lblItypea" class="lbl"> </a></td>
            <td class="td6"><select id="cmbItype" class="txt c1" > </select></td>
            <td class='td7'><span> </span><a id="lblPrice" class="lbl"> </a></td>
            <td class="td8"><input id="txtPrice"  type="text" class="txt num c1"/> </td>
            <td class='td9'><span> </span><a id="lblSprice" class="lbl"> </a></td>
            <td class="tdA"><input id="txtSprice"  type="text" class="txt num c1"/> </td>
        </tr>
        <tr class="tr2">
            <td class='td1'><span> </span><a id="lblProductno" class="lbl btn"> </a></td>
            <td class="td2" colspan="3"><input id="txtProductno"  type="text" class="txt c4"/><input id="txtProduct"  type="text" class="txt c5"/> </td>
            <td class='td5'><span> </span><a id="lblUnit" class="lbl"> </a></td>
            <td class="td6"><input id="txtUnit"  type="text" class="txt c1"/> </td>
            <td class='td7'><span> </span><a id="lblPlace" class="lbl"> </a></td>
            <td class="td8"><input id="txtPlace" type="text"  class="txt c1"/></td>
            <td class='td9'><span> </span><a id="lblSource" class="lbl"> </a></td>
            <td class="tdA"><input id="txtSource" type="text" class="txt c1"/> </td>
        </tr>
        <tr class="tr3">
            <td class='td1'><span> </span><a id="lblSizest" class="lbl"> </a></td>
        	<td class="td2" colspan="7">
        		<a id="lblSize1" class="lbl" style="float:left;"> </a>
				<input class="txt num c8" id="textSize1" type="text" disabled="disabled"/>
				<a id="lblSize2" class="lbl" style="float:left;"> </a>
				<input class="txt num c8" id="textSize2" type="text" disabled="disabled"/>
				<a id="lblSize3" class="lbl" style="float:left;"> </a>
				<input class="txt num c8" id="textSize3" type="text" disabled="disabled"/>
				<a id="lblSize4" class="lbl" style="float:left;"> </a>
				<input class="txt num c8" id="textSize4" type="text" disabled="disabled"/>
				<!--上為虛擬下為實際-->
				<input id="txtRadius" type="hidden"/>
				<input  id="txtWidth" type="hidden"/>
				<input  id="txtDime" type="hidden"/>
				<input id="txtLengthb" type="hidden"/>
			</td>
            <!--<td class='td1'><span> </span><a id="lblDime" class="lbl"> </a></td>
            <td class="td2"><input id="txtDime"  type="text" class="txt num c1"/></td>
            <td class='td3'><span> </span><a id="lblWidth" class="lbl"> </a></td>
            <td class="td4"><input id="txtWidth" type="text" class="txt num c1" /></td>
            <td class='td5'><span> </span><a id="lblLength" class="lbl"> </a></td>
            <td class="td6"><input id="txtLengthb" type="text"  class="txt num c1" /></td>
            <td class='td7'><span> </span><a id="lblRadius" class="lbl"> </a></td>
            <td class="td8"><input id="txtRadius" type="text"  class="txt num c1" /></td>-->
        </tr>
        <tr class="tr4">
            <td class='td7'><span> </span><a id="lblStoreno" class="lbl btn"> </a></td>
            <td class="td8" colspan="3"><input id="txtStoreno" type="text" class="txt c4" />
            	<input id="txtStore" type="text" class="txt c5" /></td>
        </tr>
        <tr class="tr4">            
            <td class='td1'><span> </span><a id="lblSpec" class="lbl"> </a></td>
            <td class="td2" colspan="3"><input id="txtSpec" type="text" class="txt c7"/> </td>
            <td class='td5'><span> </span><a id="lblClass" class="lbl"> </a></td>
            <td class="td6"><input id="txtClass" type="text" class="txt c1" /></td>
            <td class='td7'><span> </span><a id="lblSize" class="lbl"> </a></td>
            <td class="td8" colspan="3"><input id="txtSize" type="text" class="txt c7"/> </td>
        </tr>
        <tr class="tr5">
            <td class='td1'><span> </span><a id="lblWeight" class="lbl"> </a></td>
            <td class="td2"><input id="txtWeight"  type="text" class="txt num c1"/> </td>
            <td class='td3'><span> </span><a id="lblEmount" class="lbl"> </a></td>
            <td class="td4"><input id="txtEmount"  type="text" class="txt num c1"/> </td>
            <td class='td5'><span> </span><a id="lblHard" class="lbl"> </a></td>
            <td class="td6"><input id="txtHard"  type="text" class="txt num c1"/> </td>
            <td class='td7'><span> </span><a id="lblDescr" class="lbl"> </a></td>
            <td class="td8" colspan="3"><input id="txtDescr"  type="text" class="txt c7"/> </td>
        </tr>
        <tr class="tr6">
            <td class='td1'><span> </span><a id="lblGweight" class="lbl"> </a></td>
            <td class="td2"><input id="txtGweight"  type="text" class="txt num c1"/> </td>
            <td class='td3'><span> </span><a id="lblSdate" class="lbl"> </a></td>
            <td class="td4"><input id="txtSdate"  type="text" class="txt  c1"/> </td>
            <td class='td5'><span> </span><a id="lblZinc" class="lbl"> </a></td>
            <td class="td6"><input id="txtZinc"  type="text" class="txt  c1"/> </td>
            <td class='td7'><span> </span><a id="lblMemo" class="lbl"> </a></td>
            <td class="td8" colspan="3"><input id="txtMemo"  type="text" class="txt c7"/> </td>
        </tr>
        <tr class="tr7">
            <td class='td1'><span> </span><a id="lblEweight" class="lbl"> </a></td>
            <td class="td2"><input id="txtEweight"  type="text" class="txt num c1"/> </td>
            <td class='td3'><span> </span><a id="lblOdate" class="lbl"> </a></td>
            <td class="td4"><input id="txtOdate"  type="text" class="txt  c1"/> </td>
            <td class='td5'><span> </span><a id="lblGmount" class="lbl"> </a></td>
            <td class="td6"><input id="txtGmount"  type="text" class="txt num c1"/> </td>
            <td class='td7'><span> </span><a id="lblUseno" class="lbl btn"> </a></td>
            <td class="td8" colspan="3"><input id="txtUseno"  type="text" class="txt c4"/><input id="txtUsea"  type="text" class="txt c5"/> </td>
        </tr>                                       
        </table>
        </div>
        </div> 
        <input id="q_sys" type="hidden" />    
</body>
</html>
