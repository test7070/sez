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

            q_tables = 's';
            var q_name = "borrf";
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['money', 10, 0]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array( 
            ['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
            ['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno])

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });

            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }///  end Main()

            function mainPost() {
            	bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('borr.typea'), 's');
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				$('#txtDatea').focusout(function () {
                     	   q_cd( $(this).val() ,$(this));
	                });
                $("#txtPayc").change(function() {
                    sum();
                });
                $("#cmbTaxtype").change(function() {
                    sum();
                });
                $("#txtTaxrate").change(function() {
                    sum();
                });
            }

            function pop(form, seq) {
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
                    for(var i = 0; i < adest.length; i++) { {
                            if(t_copy)
                                $('#' + adest[i]).val($('#' + asource[i]).val());

                            if(t_clear)
                                $('#' + adest[i]).val('');
                        }
                    }
                });
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();

                        if(q_cur == 1 || q_cur == 2)
                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                        break;
                }
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;
               q_box('borro_s.aspx', q_name + '_s', "500px", "340px", q_getMsg( "popSeek"));
            }

            function btnIns() {
                _btnIns();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
            }

            function btnOk() {
                var t_err = '';
				$('#txtDatea').val($.trim($('#txtDatea').val()));
                if (checkId($('#txtDatea').val())==0){
                	alert(q_getMsg('lblDatea')+'��~�C');
                	return;
                }  
                //  t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')]]);
                var t_noa = $.trim($('#txtNoa').val());
                //  alert(t_noa+'  '+t_noa.length);
                //  if(t_noa.length == 0)
                //    q_gtnoa(q_name, t_noa);
                //else

                wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['acc1']) {
                    as[bbsKey[1]] = '';
                    
                    return;
                }

                q_nowf();
                as['noa'] = abbm2['noa'];

                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                if(q_cur > 0 && q_cur < 4)
                    sum();
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

            function bbsAssign() {
                _bbsAssign();

                for(var j = 0; j < q_bbsCount; j++) {
                    $("#txtMoney_" + j).change(function(e) {
                        sum();
                    });
                }
            }

            function sum() {
                switch($("#cmbTaxtype").val()) {
                    case '1':
                        //extra
                        $("#txtTax").val(Math.round($("#txtPayc").val() * $("#txtTaxrate").val() / 100, 0));
                        break;
                    case '3':
                        //include  
                        $("#txtTax").val($("#txtPayc").val() - Math.round($("#txtPayc").val() / (1 + $("#txtTaxrate").val() / 100), 0));
                        break;
                    case '5':
                        //custom
                        $("#txtTaxrate").val(0);
                        break;
                    default:
                        $("#txtTax").val(0);
                }

                var inMoney = 0;
                var outMoney = 0;
                for(var i = 0; i < q_bbsCount; i++) {
                    if($("#cmbTypea_" + i).val() == '1')
                        outMoney += $("#txtMoney_" + i).val();
                    else
                        inMoney += $("#txtMoney_" + i).val();
                }
                $("#txtBwmoney").val(outMoney);
                $("#txtPay").val(inMoney);
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

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
		</script>
		<style type="text/css">
           #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 29%;
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
                width: 69%;
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
                width: 99%;
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
            .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size:medium;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
             .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td{
            	text-align: center;
                border: 2px lightgrey double;
            }
            
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:25%"><a id='vewDatea'></a></td>
						<td align="center" style="width:25%"><a id='vewNoa'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr1">
						<td class="td1" ><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtDatea"  type="text"  class="txt c1"/>
						</td>
						<td> </td>
						<td> </td>
						<td> </td>						
					</tr>
					<tr class="tr2">
						<td class="td1" ><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1" ><span> </span>
						<a id="lblCustno" class="lbl btn" > </a>
						</td>
						<td class="td2" colspan="2">
						<input id="txtCustno"  type="text"  class="txt c2"/>
						<input id="txtComp"  type="text" class="txt c3"/>
						</td>
					</tr>

				</table>
			</div>
			<div class='dbbs' >
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"></td>
					<td align="center" style="width:200px;"><a id='lblAcc_s'> </a></td>
					<td align="center" style="width:400px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblDmoney_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblCmoney_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
					<input class="btn"  id="btnAcc.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
					<input type="text" id="txtAcc1.*"  style="width:35%;"/>
					<input type="text" id="txtAcc2.*"  style="width:45%;"/>
					</td>
					<td >
					<input type="text" id="txtMemo.*" style="width:95%;" />
					</td>
					<td>
					<input type="text" id="txtDmoney.*" style="width:95%;text-align: right;" />
					</td>
					<td>
					<input type="text" id="txtCmoney.*" style="width:95%;text-align: right;" />
					</td>
				</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

