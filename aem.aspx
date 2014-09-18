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

            q_desc = 1;
            q_tables = 's';
            var q_name = "aem";
            var q_readonly = ['txtNoa','txtMoney','txtMoney1','txtMoney2','txtMoney3'];
            var q_readonlys = [];
            var bbmNum = [['txtMan', 15, 0, 1], ['txtMan1', 15, 0, 1], ['txtMan2', 15, 0, 1], ['txtMan3', 15, 0, 1],['txtMoney', 15, 0, 1], ['txtMoney1', 15, 0, 1], ['txtMoney2', 15, 0, 1], ['txtMoney3', 15, 0, 1]];
            var bbsNum = [['txtMoney', 15, 0, 1], ['txtMoney1', 15, 0, 1], ['txtMoney2', 15, 0, 1], ['txtMoney3', 15, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 3;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            aPop = new Array(['txtAcc1_', 'btnAcc1_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtMon', r_picm]];
                bbsMask = [];
                q_mask(bbmMask);
                
                $('#btnImport').click(function() {
                	if(q_cur==1 || q_cur==2){
                		if(emp($('#txtMon').val())){
							alert('請先輸入'+q_getMsg('lblMon'));
							return;
						}
						var t_where = "where=^^ left(a.accc2,2)= '"+$('#txtMon').val().substr(4,2)+"' and a.accc5 like '55%' ^^";
			        	q_gt('acccs_accc5', t_where, 0, 0, 0, "", $('#txtMon').val().substr(0,3)+'_'+r_cno);
						
                	}
				});
				
				$('#txtMan1').change(function() {
                	if((q_cur==1 || q_cur==2)) {
                		for (var j = 0; j < q_bbsCount; j++) {
                			if(!emp($('#txtAcc1_'+j).val()) && q_float('txtMan')>0)
                				q_tr('txtMoney1_'+j,round(q_mul(q_float('txtMoney_'+j),q_div(q_float('txtMan1'),q_float('txtMan'))),0));
                			else
                				q_tr('txtMoney1_'+j,0);
                		}
                	}
                	sum();
				});
				
				$('#txtMan2').change(function() {
                	if((q_cur==1 || q_cur==2)) {
                		for (var j = 0; j < q_bbsCount; j++) {
                			if(!emp($('#txtAcc1_'+j).val()) && q_float('txtMan')>0)
                				q_tr('txtMoney2_'+j,round(q_mul(q_float('txtMoney_'+j),q_div(q_float('txtMan2'),q_float('txtMan'))),0));
                			else
                				q_tr('txtMoney2_'+j,0);
                		}
                	}
                	sum();
				});
				
				$('#txtMan3').change(function() {
                	if((q_cur==1 || q_cur==2)) {
                		for (var j = 0; j < q_bbsCount; j++) {
                			if(!emp($('#txtAcc1_'+j).val()) && q_float('txtMan')>0)
                				q_tr('txtMoney3_'+j,round(q_mul(q_float('txtMoney_'+j),q_div(q_float('txtMan3'),q_float('txtMan'))),0));
                			else
                				q_tr('txtMoney3_'+j,0);
                		}
                	}
                	sum();
				});
				
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                b_ret = getb_ret();
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acccs_accc5':
                        var as = _q_appendData("acccs", "", true);
                        as.sort(compare);
                        //分類
                        /*var ac55=new Array();
                        var accc5='',t_accc5='',t_accc6='',accc5_total=0;
                        for (var i = 0; i < as.length; i++) {
                        	accc5=as[i].accc5;
                        	if(accc5!=t_accc5 && t_accc5!=''){
                        		if(accc5_total>0){
	                        		ac55.push({
										acc1:t_accc5,
										acc2:t_accc6,
										money:accc5_total,
									});
								}
                        		
                        		accc5_total=0;
                        	}
                        	accc5_total=q_add(accc5_total,q_sub(dec(as[i].dmoney),dec(as[i].cmoney)))
                			t_accc5=accc5;
                			t_accc6=as[i].accc6;
                		}
                		q_gridAddRow(bbsHtm, 'tbbs', 'txtAcc1,txtAcc2,txtMoney', ac55.length, ac55, 'acc1,acc2,money', '');*/
                		for (var i = 0; i < as.length; i++) {
                			as[i].money=q_sub(dec(as[i].dmoney),dec(as[i].cmoney));
                			if(as[i].money<=0){
                				as.splice(i, 1);
                				i--;	
                			}
                		}
                		q_gridAddRow(bbsHtm, 'tbbs', 'txtAcc1,txtAcc2,txtMoney', as.length, as, 'accc5,acc2,money', '');
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }
            
            function compare(a,b) {
				if (a.accc5 < b.accc5)
					return -1;
				if (a.accc5 > b.accc5)
					return 1;
				return 0;
			}

            function btnOk() {
                t_err = '';
                t_err = q_chkEmpField([['txtMon', q_getMsg('lblMon')]]);
                
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                if(q_float('txtMan')!=q_add(q_float('txtMan1'),q_add(q_float('txtMan2'),q_float('txtMan3')))){
                	alert("人數合計異常!!");
                    return;
                }
                
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('AE' + q_date(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('aem_s.aspx', q_name + '_s', "500px", "300px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                    }
                }

                $('#tbbs .num').change(function() {
                    sum();
                });

                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtMon').val(q_date().substr(0, 6));
                $('#txtMon').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();

            }

            function btnPrint() {
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['acc1']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['mon'] = abbm2['mon'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);

            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);

            }

            function sum() {
                var t_money = 0, t_money1 = 0, t_money2 = 0, t_money3 = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    t_money=q_add(t_money,q_float('txtMoney_'+j));
                    t_money1=q_add(t_money1,q_float('txtMoney1_'+j));
                    t_money2=q_add(t_money2,q_float('txtMoney2_'+j));
                    t_money3=q_add(t_money3,q_float('txtMoney3_'+j));
                }
                
                q_tr('txtMoney',t_money);
                q_tr('txtMoney1',t_money1);
                q_tr('txtMoney2',t_money2);
                q_tr('txtMoney3',t_money3);
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
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
                width: 350px;
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
                width: 400px;
                /*margin: -1px;
                 border: 1px black solid;*/
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
                width: 50%;
                float: left;
            }
            .txt.c7 {
                float: left;
                width: 22%;
            }
            .txt.c8 {
                float: left;
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
                font-size: medium;
            }
            .tbbm textarea {
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 800px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1px;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div class="dview" id="dview" style="float: left;  width:32%;"  >
			<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
				<tr>
					<td align="center" style="width:5%"><a id='vewChk'> </a></td>
					<td align="center" style="width:20%"><a id='vewNoa'> </a></td>
					<td align="center" style="width:25%"><a id='vewMon'> </a></td>
				</tr>
				<tr>
					<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
					<td align="center" id='noa'>~noa</td>
					<td align="center" id='mon'>~mon</td>
				</tr>
			</table>
		</div>
		<div class='dbbm' style="width: 68%;float:left">
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
				<tr class="tr1">
					<td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
					<td class="td2"><input id="txtNoa" type="text" class="txt c1"/></td>
					<td class="td3"><span> </span><a id="lblMon" class="lbl"> </a></td>
					<td class="td4"><input id="txtMon" type="text" class="txt c1"/></td>
					<td class="td5"><span> </span></td>
            		<td class="td6"><input id="btnImport" type="button" style="float: left;"/></td>
				</tr>
				<tr class="tr2">
					<td class="td1"><span> </span><a id="lblMan" class="lbl"> </a></td>
					<td class="td2"><input id="txtMan" type="text" class="txt num c1"/></td>
					<td class="td3"><span> </span><a id="lblMan1" class="lbl"> </a></td>
					<td class="td4"><input id="txtMan1" type="text" class="txt num c1"/></td>
					<td class="td5"><span> </span><a id="lblMan2" class="lbl"> </a></td>
					<td class="td6"><input id="txtMan2" type="text" class="txt num c1"/></td>
					<td class="td7"><span> </span><a id="lblMan3" class="lbl"> </a></td>
					<td class="td8"><input id="txtMan3" type="text" class="txt num c1"/></td>
				</tr>
				<tr class="tr2">
					<td class="td1"><span> </span><a id="lblMoney" class="lbl"> </a></td>
					<td class="td2"><input id="txtMoney" type="text" class="txt num c1"/></td>
					<td class="td3"><span> </span><a id="lblMoney1" class="lbl"> </a></td>
					<td class="td4"><input id="txtMoney1" type="text" class="txt num c1"/></td>
					<td class="td5"><span> </span><a id="lblMoney2" class="lbl"> </a></td>
					<td class="td6"><input id="txtMoney2" type="text" class="txt num c1"/></td>
					<td class="td7"><span> </span><a id="lblMoney3" class="lbl"> </a></td>
					<td class="td8"><input id="txtMoney3" type="text" class="txt num c1"/></td>
				</tr>
			</table>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /></td>
					<td align="center" style="width:14%;"><a id='lblAcc1_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblMoney1_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblMoney2_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblMoney3_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td ><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td >
						<input  id="txtAcc1.*" type="text" style="width:80%;" />
						<input class="btn"  id="btnAcc1.*" type="button" value='.' style=" font-weight: bold;width:1%;float:right;" />
						<input  id="txtAcc2.*" type="text" style="width:80%;"/>
						<input id="txtNoq.*" type="hidden" />
					</td>
					<td ><input  id="txtMoney.*" type="text" class="txt c1 num"/></td>
					<td ><input  id="txtMoney1.*" type="text" class="txt c1 num"/></td>
					<td ><input  id="txtMoney2.*" type="text" class="txt c1 num"/></td>
					<td ><input  id="txtMoney3.*" type="text" class="txt c1 num"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
