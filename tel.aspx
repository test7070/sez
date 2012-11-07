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

            function mainPost() {
            	bbmMask = [['txtBegindate', r_picd],['txtCondate', r_picd],['txtEnddate', r_picd]];
            	q_mask(bbmMask);
                fbbm[fbbm.length] = 'txtMemo'; 
                q_cmbParse("cmbComp2", ('').concat(new Array('中華電信', '台灣大哥大', '亞太電信', '遠傳電信', '泛亞電信', '大眾電信', '威寶電信')));
				 q_cmbParse("cmbTypea", q_getPara('tel.typea'));
				 
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
                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);
		        		}

                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('sss_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                //$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtNoa').focus();
            }
			var t_mobile='';
            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
				
                _btnModi();
                $('#txtNoa').focus();
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
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblMobile')]]);

                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                var t_noa = trim($('#txtNoa').val());

                if(t_noa.length ==0)
                    q_gtnoa(q_name, t_noa);
                else
                    wrServer(t_noa);
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
                            <td align="center" id='noa'>~noa</td>
                        </tr>
                    </table>
                </div>
                <div class='dbbm' style="width: 74%;float: left;">
                    <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
                         <tr class="tr1">
                            <td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
                            <td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
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
                            <td class="td1" ><span> </span><a id='lblMemo' class="lbl"></a></td>
                            <td class="td2" colspan="5"><input id="txtMemo" type="text" class="txt c1" style="width: 100%;"/></td>
                        </tr>
                </table>
            </div>
            <input id="q_sys" type="hidden" />
    </body>
</html>
