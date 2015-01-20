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

            var decbbm = [];
            var q_name = "tel";
            var q_readonly = [];
            var bbmNum = [['txtFeerate',12 , 0, 1],['txtNetfee',12 , 0, 1],['txtTotal',14 , 0, 1],['txtYears',2 , 0, 0]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
			aPop = new Array(['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'],['txtSssno', 'lblSss', 'sss', 'noa,namea,partno,part', 'txtSssno,txtNamea,txtPartno,txtPart', 'sss_b.aspx'],['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtComp2', 'acomp_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtNoa').focus
            });
            //////////////////   end Ready
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }

                q_mask(bbmMask);

                mainForm(0);
                // 1=Last  0=Top

                $('#txtNoa').focus();

            }///  end Main()
			var insed=false;//判斷電話是否重覆輸入
            function mainPost() {
            	bbmMask = [['txtBegindate', r_picd],['txtCondate', r_picd],['txtEnddate', r_picd]];
            	q_mask(bbmMask);
                fbbm[fbbm.length] = 'txtMemo'; 
                q_cmbParse("cmbComp2", ('').concat(new Array('中華電信', '台灣大哥大', '亞太電信', '遠傳電信', '泛亞電信', '大眾電信', '威寶電信')));
				 q_cmbParse("cmbTypea", q_getPara('tel.typea'));
				 
				 $('#txtTelno').change(function () {
				 	if(!emp($('#txtTelno').val())){
				 		t_where = "where=^^ telno='"+$('#txtTelno').val()+"' ^^"
	           			q_gt('tel', t_where , 0, 0, 0, "", r_accy);
				 	}
			     });
				 
				 $('#txtFeerate').change(function () {
				 	sum();
			     });
			     $('#txtNetfee').change(function () {
				 	sum();
			     });
			     $('#chkNet').click(function() {
        			sum();
        		});
        		$('#txtYears').change(function () {
        			if(emp($('#txtYears').val())||dec($('#txtYears').val())==0){
        				$('#txtBegindate').val('');
        				$('#txtCondate').val('');
        				$('#txtEnddate').val('');
        				return;
        			}
        			
        			var t_enddate='';
        			if(emp($('#txtBegindate').val())){
        				$('#txtBegindate').val(q_date());
        				t_enddate=q_date().substring(0,3);
        			}else{
        				t_enddate=(trim($('#txtBegindate').val())).substring(0,3);
        			}
        			t_enddate=dec(t_enddate)+dec(trim($('#txtYears').val()));
        			$('#txtCondate').val(t_enddate+(trim($('#txtBegindate').val())).substring(3));
        			$('#txtEnddate').val(t_enddate+(trim($('#txtBegindate').val())).substring(3));
			     });
			     $('#txtBegindate').change(function () {
        			var t_enddate=(trim($('#txtBegindate').val())).substring(0,3);
        			t_enddate=dec(t_enddate)+dec(trim($('#txtYears').val()));
        			$('#txtCondate').val(t_enddate+(trim($('#txtBegindate').val())).substring(3));
        			$('#txtEnddate').val(t_enddate+(trim($('#txtBegindate').val())).substring(3));
			     });
            }
            
            function txtCopy(dest, source) {
                var adest = dest.split(',');
                var asource = source.split(',');
                $('#' + adest[0]).focus(function() {
                    if(trim($(this).val()).length == 0)
                        $(this).val(q_getMsg('msgCopy'));
                });
                $('#' + adest[0]).focusout(function() {
                    var t_copy = ($(this).val().substr(0, 1) == '=');
                    var t_clear = ($(this).val().substr(0, 2) == ' =');
                    for( i = 0; i < adest.length; i++) {
                        if(t_copy)
                            $('#' + adest[i]).val($('#' + asource[i]).val());

                        if(t_clear)
                           $('#' + adest[i]).val('');

                    }
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'conn':

                        break;

                    case 'sss':
                        ret = getb_ret();
                        if(q_cur > 0 && q_cur < 4)
                            q_browFill('txtSalesno,txtSales', ret, 'noa,namea');
                        break;

                    case 'sss':
                        ret = getb_ret();
                        if(q_cur > 0 && q_cur < 4)
                            q_browFill('txtGrpno,txtGrpname', ret, 'noa,comp');
                        break;

                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }   /// end Switch
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'sss':
                        q_changeFill(t_name, ['txtSalesno', 'txtSales'], ['noa', 'namea']);
                        break;

                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();

                        if(q_cur == 1 || q_cur == 2){
                           var as = _q_appendData("tel", "", true);
            				if(as[0]!=undefined){
            					insed=true;
            					alert('電話重覆輸入!!');
            					$('#txtTelno').focus();
            				}else{
            					insed=false;
            				}
		        		}

                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('tel_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtTelno').focus();
            }
			var t_mobile='';
            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
				
                _btnModi();
                $('#txtTelno').focus();
            }

            function btnPrint() {
				q_box('z_telp.aspx', '', "95%", "650px", q_getMsg("popPrint"));
            }
            
            function sum() {
            	if ($('#chkNet')[0].checked)
            	{
					q_tr('txtTotal' ,q_float('txtFeerate')+q_float('txtNetfee'));
				}
				else
				{
					q_tr('txtTotal' ,q_float('txtFeerate'));
					q_tr('txtNetfee' ,0);
				}
            }

            function btnOk() {          	
                var t_err = '';
                t_err = q_chkEmpField([['txtTelno', q_getMsg('lblMobile')]]);

                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                if(insed){
            		alert('電話重覆輸入!!');
                	return;
                }
	            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
	            if (s1.length == 0 || s1 == "AUTO")   
	                q_gtnoa(q_name, replaceAll('T' + $('#txtPartno').val(), '/', ''));
	            else
	                wrServer(s1);
            }

            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if(q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
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
                if(q_tables == 's')
                    bbsAssign();
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
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
                width: 10%;
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
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 45%;
                float: left;
            }
            .txt.c3 {
                width: 55%;
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
                font-size: medium;
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
                            <td align="center" style="width:25%"><a id='vewPart'></a></td>
                            <td align="center" style="width:25%"><a id='vewNamea'></a></td>
                            <td align="center" style="width:30%"><a id='vewNoa'></a></td>
                        </tr>
                        <tr>
                            <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                            <td align="center" id='part'>~part</td>
                            <td align="center" id='namea'>~namea</td>
                            <td align="center" id='telno'>~telno</td>
                        </tr>
                    </table>
                </div>
                <div class='dbbm' style="width: 74%;float: left;">
                    <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
                         <tr class="tr1">
                            <td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
                            <td class="td2"><input id="txtTelno"  type="text" class="txt c1"/><input id="txtNoa"  type="hidden" class="txt c1"/></td>
                            <td class="td3"><span> </span><a id='lblAcomp' class="lbl"></a></td><!--<input id="btnAcomp" type="button"  style="width: auto;font-size: medium;"/>-->
                            <td class="td4">
                            	<select id="cmbComp2" class="txt c1"></select>
                            	<!--<input id="txtCno" type="text"  class="txt c4"/><input id="txtComp2" type="text" class="txt c5"/>-->
                            </td>
                        </tr>
                        <tr class="tr2">
                            <!--<td class="td1"><span> </span><a id='lblMobile' class="lbl"></a></td>
                            <td class="td2"><input id="txtMobile"  type="text" class="txt c1"/></td>-->
                            <td class="td1"><span> </span><a id='lblSss' class="lbl btn"></a></td>
                            <td class="td2"><input id="txtSssno"  type="text"  class="txt c2"/><input id="txtNamea"  type="text"  class="txt c3"/></td><!--<input id="btnSss" type="button" style="width: auto;font-size: medium;"/>-->
                            <td class="td3"><span> </span><a id='lblPart' class="lbl btn"></a></td>
                            <td class="td4"><input id="txtPartno" type="text"  class="txt c2"/><input id="txtPart" type="text"  class="txt c3"/></td><!--<input id="btnPart" type="button" style="width: auto;font-size: medium;"/>-->
                        </tr>
                        <tr class="tr3">
                            <td class="td1"><span> </span><a id='lblType' class="lbl"></a></td>
                            <td class="td2"><select id="cmbTypea" class="txt c1"></select></td>
                            <td class="td3"><span> </span><a id='lblFeerate' class="lbl"></a></td>
                            <td class="td4"><input id="txtFeerate"  type="text" class="txt num c1" /></td>
                            <td class="td5"><span> </span><a id='lblYears' class="lbl"></a></td>
                            <td class="td6"><input id="txtYears" type="text" class="txt c1"/></td>
                        </tr>
                        <tr class="tr4">
                            <td class="td1"><span> </span><a id='lblNet' class="lbl"></a></td>
                            <td class="td2"><input id="chkNet" type="checkbox"/></td>
                            <td class="td3"><span> </span><a id='lblNetfee' class="lbl"></a></td>
                            <td class="td4"><input id="txtNetfee"  type="text" class="txt num c1" /></td>
                            <td class="td5"><span> </span><a id='lblTotal' class="lbl"></a></td>
                            <td class="td6"><input id="txtTotal"  type="text" class="txt num c1" /></td>
                        </tr>
                        <tr class="tr5">
                            <td class="td1"><span> </span><a id='lblBegindate' class="lbl"></a></td>
                            <td class="td2"><input id="txtBegindate"  type="text" class="txt c1" /></td>
                            <td class="td3"><span> </span><a id='lblCondate' class="lbl"></a></td>
                            <td class="td4"><input id="txtCondate" type="text" class="txt c1"/></td>
                            <td class="td5"><span> </span><a id='lblEnddate' class="lbl"></a></td>
                            <td class="td6"><input id="txtEnddate" type="text" class="txt c1"/></td>
                        </tr>
                        <tr class="tr6">
                            <td class="td1"><span> </span><a id='lblBrand' class="lbl"></a></td>
                            <td class="td2"><input id="txtBrand"  type="text" class="txt c1" /></td>
                            <td class="td3"><span> </span><a id='lblModel' class="lbl"></a></td>
                            <td class="td4"><input id="txtModel" type="text" class="txt c1"/></td>
                            <td class="td5"><span> </span><a id='lblMoney' class="lbl"></a></td>
                            <td class="td6"><input id="txtMoney" type="text" class="txt num c1"/></td>
                        </tr>
                        <tr class="tr7">
                            <td class="td1" ><span> </span><a id='lblMemo' class="lbl"></a></td>
                            <td class="td2" colspan="5"><input id="txtMemo" type="text" class="txt c1" style="width: 100%;"/></td>
                        </tr>
                </table>
            </div>
            <input id="q_sys" type="hidden" />
    </body>
</html>
