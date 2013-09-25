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
        var q_name="signagentdate";
        var q_readonly = [];
        var bbmNum = [];  
        var bbmMask = [['txtBtime', '99:99'],['txtEtime', '99:99']]; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
		aPop = new Array(['txtCheckerno', 'lblChecker','sss','noa,namea', 'txtCheckerno,txtChecker','sss_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            q_brwCount();
			q_gt(q_name, q_content, q_sqlCount, 1);
            $('#txtNoa').focus();
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
        	bbmMask = [['txtBdate',r_picd],['txtEdate',r_picd],['txtBtime', '99:99'],['txtEtime', '99:99']];
        	q_mask(bbmMask);
        	var t_where = "where=^^ checkerno ='"+ abbm[q_recno].checkerno +"' ^^";
			q_gt('signagent', t_where, 0, 0, 0, "");
			$('#txtCheckerno').change(function() {
        		var t_where = "where=^^ checkerno ='"+$('#txtCheckerno').val()+"' ^^";
				q_gt('signagent', t_where, 0, 0, 0, "");
			});
			$('#txtCheckerno').focusout(function() {
        		var t_where = "where=^^ checkerno ='"+$('#txtCheckerno').val()+"' ^^";
				q_gt('signagent', t_where, 0, 0, 0, "");
			});
			$('#cmbAgentno').change(function() {
				$('#txtAgent').val($('#cmbAgentno :checked').text());
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


        function q_gtPost(t_name) {  
            switch (t_name) {
                case 'sss': 
                    q_changeFill(t_name, ['txtSalesno', 'txtSales'], ['noa', 'namea']);
                    break;
                case 'signagent':
	                var as = _q_appendData("signagent", "", true);
	                $('#cmbAgentno').text('');
	                if (as[0] != undefined) {
			            for ( i = 0; i < as.length; i++) {
				            t_item = as[i].agentno + '@' + as[i].agent;
				            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].agentno2 + '@' + as[i].agent2;
				            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].agentno3 + '@' + as[i].agent3;
		            	}
			            q_cmbParse("cmbAgentno", t_item);
			            if(q_cur != 1){
				            if (abbm[q_recno] != undefined) {
				            	$("#cmbAgentno").val(abbm[q_recno].agentno);
				            	$('#txtAgent').val(abbm[q_recno].agent);
				            }
				        }else{
				        	$('#txtAgent').val($('#cmbAgentno :checked').text());
				        }
	                }
                	break;
                case q_name: if (q_cur == 4)  
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        
        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('signagentdate_s.aspx', q_name + '_s', "500px", "380px", q_getMsg( "popSeek"));
        }

        function btnIns() {
            _btnIns();
        	var t_where = "where=^^ checkerno ='"+$('#txtCheckerno').val()+"' ^^";
			q_gt('signagent', t_where, 0, 0, 0, "");
            $('#txtNoa').focus();
            
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;

            _btnModi();
        	var t_where = "where=^^ checkerno ='"+$('#txtCheckerno').val()+"' ^^";
			q_gt('signagent', t_where, 0, 0, 0, "");
			$('#txtComp').focus();
        }

        function btnPrint() {
 
        }
        function btnOk() {
            $('#txtBdate').val($.trim($('#txtBdate').val()));
                if (checkId($('#txtBdate').val())==0){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
            }
            $('#txtEdate').val($.trim($('#txtEdate').val()));
                if (checkId($('#txtEdate').val())==0){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
            }
        	
        	
            var t_date = trim($('#txtBdate').val());
            var t_noa = trim($('#txtNoa').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll('P' + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
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
			var t_where = "where=^^ checkerno ='"+ abbm[q_recno].checkerno +"' ^^";
			q_gt('signagent', t_where, 0, 0, 0, "");
        }
		function q_popPost(s1) {
			switch (s1) {
				case 'txtCheckerno':
					$('#txtCheckerno').focusout();
					break;
			}
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
            .txt.c6 {
                width: 40%;
                float: left;
            }
            .txt.c7 {
                width: 35%;
                float: left;
            }
            .txt.c8 {
                width: 5%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm .cen{
            	text-align: center;
            	font-weight: bold;
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
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain'>
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:15%"><a id='vewNoa'></a></td>
                <td align="center" style="width:15%"><a id='vewChecker'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='checker'>~checker</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 60%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
             <tr>
               <td class="td1"><span> </span><a id='lblDatea' class="lbl"></a></td>
               <td class="td2"><input id="txtBdate"  type="text" class="txt c6"/>
               <a id='lblSymbol' class="txt cen c4" ></a>
               	<input id="txtEdate"  type="text" class="txt c6"/>
               </td>
               <td class="td3"></td>
               <td class="td1"><span> </span><a id='lblNoa' class="lbl" style="display:none"></a></td>
               <td class="td2"><input id="txtNoa"  type="text" class="txt c1" style="display:none"/></td>
            </tr>
             <tr>
               <td class="td1"><span> </span><a id='lblTime' class="lbl"></a></td>
               <td class="td2"><input id="txtBtime"  type="text" class="txt c7"/><a id="lblBtime" class="txt c8"></a>
               	<a id='lblSymbols' class="txt cen c4" ></a>
               	<input id="txtEtime"  type="text" class="txt c7"/><a id="lblEtime" class="txt c8"></a>
               </td>
               <td class="td3"></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblChecker' class="lbl btn"></a></td>
               <td class="td2"><input id="txtCheckerno"  type="text" class="txt c2"/>
               	<input id="txtChecker"  type="text" class="txt c3"/>
               </td>
               <td class="td3"></td>
               <td class="td4"></td>
            </tr>
           <tr>
				<td class="td1"><span> </span><a id='lblAgent' class="lbl btn"></a></td>
				<td class="td2">
					<select class="txt" id="cmbAgentno" style="width:215px; font-size:medium;"> </select>
					<input id="txtAgent"  type="text" style="display:none;"/>
            	</td>
               <td class="td3"></td>
               <td class="td4"></td>
            </tr>
        </table>
        </div>
        </div>
         <input id="q_sys" type="hidden" />    
</body>
</html>
            