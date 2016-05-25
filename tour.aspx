<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
        <title> </title>
        <script src="../script/jquery.min.js" type="text/javascript"></script>
        <script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
        <script src='../script/qj_mess.js' type="text/javascript"></script>
        <script src="../script/qbox.js" type="text/javascript"></script>
        <script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">    
            var q_name = "tour";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 20;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_copy=1;
            q_xchg = 1;
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(
				
			);

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtNoa').focus
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                // 1=Last  0=Top
            }

            function mainPost() {
            	bbmMask = [['txtDatea',r_picd]]
            	bbmNum = [];
                q_mask(bbmMask);
                
                
                $('#btnCost').click(function() {
                	$('.cost').show();
                	$('.tour').hide();
				});
				
				 $('#btnTour').click(function() {
                	$('.cost').hide();
                	$('.tour').show();
				});
				
				$('.cbutton').hide();
				$('#btnTour').click();
				
				$('#combGtype').change(function() {
					if (q_cur == 1 || q_cur == 2) {
						$('#txtGtype').val($('#combGtype').find("option:selected").text());
					}
				});
            }
			
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
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
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('tour_s.aspx', q_name + '_s', "500px", "400px", $('#btnSeek').val());
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').focus();
                $('#txtDatea').val(q_date());
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {

            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }

            function btnOk() {
                var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
					
				//sum();

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', '')); //q_getPara('sys.key_tour')
				else
					wrServer(s1);
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                if(q_xchg==2){
                	$('.cbutton').show();
                }else{
                	$('.cbutton').hide();
                }
                
                var t_where = "where=^^ 1=1 ^^";
				q_gt('tour', t_where, 0, 0, 0, "getgtype",r_accy,1);
				
				var as = _q_appendData("tour", "", true);
				var t_item = " @ ";
				if (as[0] != undefined) {
					for ( i = 0; i < as.length; i++) {
						t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].combGtype;
					}
				}
				document.all.combGtype.options.length = 0;
				q_cmbParse("combGtype", t_item);
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
                width: 1260px;
            }
            .dview {
                float: left;
                width: 450px;
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
                width: 1260px;
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
            /*.tbbm tr td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 2%;
            }*/
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
                width: 99%;
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
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left;  width:35%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:15%"><a id='vewDatea'>開團日</a></td>
						<td align="center" style="width:25%"><a id='vewNoa'>團號</a></td>
						<td align="center" style="width:30%"><a id='vewGrpname'>團別</a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='grpname'>~grpname</td>
					</tr>
				</table>
			</div>
			<input id="btnTour" type="button" class="cbutton" value="出團明細">
			<input id="btnCost" type="button" class="cbutton" value="成本明細">
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm" border="0" cellpadding='2'  cellspacing='5'>
					<tr style="height: 1px;">
						<td style="width: 80px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 80px;"> </td>
						<td style="width: 40px;"> </td>
						<td style="width: 80px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 80px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 80px;"> </td>
						<td style="width: 40px;"> </td>
						<td style="width: 80px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 80px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 10px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl">團號</a></td>
						<td colspan="3"><input id="txtNoa"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblDays' class="lbl">天數</a></td>
						<td colspan="2"><input id="txtDays"  type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblOp' class="lbl">OP</a></td>
						<td colspan="3"><input id="txtOp"  type="text" class="txt c1" /></td>
						<td class="tour"><span> </span><a id='lblTicket' class="lbl">已開票</a></td>
						<td class="tour"><input id="txtTicketno"  type="text" class="txt c1" /></td>			
						<td class="tour" colspan="2"><input id="txtTicket"  type="text" class="txt c1" /></td>
					</tr>
					<tr class="tour">
						<td><span> </span><a id='lblSit' class="lbl">座位</a></td>
						<td colspan="3"><input id="txtSit"  type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblSold' class="lbl">已售</a></td>
						<td colspan="2"><input id="txtSold"  type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblUnsold' class="lbl">未售</a></td>
						<td colspan="3"><input id="txtUnsold"  type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblList' class="lbl">名單</a></td>
						<td colspan="2"><input id="txtList"  type="text" class="txt num c1" /></td>
					</tr>
					<tr class="tour">
						<td><span> </span><a id='lblWait' class="lbl">座位</a></td>
						<td colspan="3"><input id="txtWait"  type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblDatea' class="lbl">開團日</a></td>
						<td colspan="2"><input id="txtDatea"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblGtype' class="lbl">團別</a></td>
						<td colspan="6">
							<input id="txtGtype" type="text" class="txt c1" style="width: 94%;"/>
							<select id="combGtype" class="txt c1" style="width: 25px;"> </select>
						</td>
					</tr>
					<tr class="tour">
						<td><span> </span><a id='lblTel1' class="lbl">電代1</a></td>
						<td colspan="3">
							<input id="txtTelname1" type="text" class="txt c1" style="width: 70%;"/>
							<input id="txtTel1" type="text" class="txt c1"  style="width: 25%;"/>
						</td>
						<td><span> </span><a id='lblTel2' class="lbl">2</a></td>
						<td colspan="2">
							<input id="txtTelname2" type="text" class="txt c1" style="width: 70%;"/>
							<input id="txtTel2" type="text" class="txt c1"  style="width: 25%;"/>
						</td>
						<td><span> </span><a id='lblTel3' class="lbl">3</a></td>
						<td colspan="3">
							<input id="txtTelname3" type="text" class="txt c1" style="width: 70%;"/>
							<input id="txtTel3" type="text" class="txt c1"  style="width: 25%;"/>
						</td>
						<td><span> </span><a id='lblTel4' class="lbl">4</a></td>
						<td colspan="2">
							<input id="txtTelname4" type="text" class="txt c1" style="width: 70%;"/>
							<input id="txtTel4" type="text" class="txt c1"  style="width: 25%;"/>
						</td>
					</tr>
					<tr class="tour">
						<td><span> </span><a id="lblRemark" class="lbl">備忘</a></td>
						<td colspan="10"><input id="txtRemark" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblSource" class="lbl">來源</a></td>
						<td colspan="2"><input id="txtSource" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tour">
						<td><span> </span><a id='lblDate1' class="lbl">追加日1</a></td>
						<td colspan="3"><input id="txtDate1"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblPsit1' class="lbl">機位數</a></td>
						<td colspan="2"><input id="txtPsit1"  type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblPtname1' class="lbl">電代</a></td>
						<td colspan="3"><input id="txtPtname1"  type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblOkdate1' class="lbl">OK日</a></td>
						<td colspan="2"><input id="txtOkdate1"  type="text" class="txt num c1" /></td>
					</tr>
					<tr class="tour">
						<td><span> </span><a id='lblDate2' class="lbl">追加日2</a></td>
						<td colspan="3"><input id="txtDate2"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblPsit2' class="lbl">機位數</a></td>
						<td colspan="2"><input id="txtPsit2"  type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblPtname2' class="lbl">電代</a></td>
						<td colspan="3"><input id="txtPtname2"  type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblOkdate2' class="lbl">OK日</a></td>
						<td colspan="2"><input id="txtOkdate2"  type="text" class="txt num c1" /></td>
					</tr>
					<tr class="tour">
						<td style="text-align: center;"> </td>
						<td style="text-align: center;"><a>CITY</a></td>
						<td style="text-align: center;"><a>交通</a></td>
						<td style="text-align: center;"><a>CL</a></td>
						<td style="text-align: center;"><a>日期</a></td>
						<td style="text-align: center;"><a>時間</a></td>
						<td style="text-align: center;"> </td>
						<td style="text-align: center;"><a>CITY</a></td>
						<td style="text-align: center;"><a>交通</a></td>
						<td style="text-align: center;"><a>CL</a></td>
						<td style="text-align: center;"><a>日期</a></td>
						<td style="text-align: center;"><a>時間</a></td>
						<td colspan="2"  style="text-align: center;"><a>直客售價</a></td>
					</tr>
					<tr class="tour">
						<td style="text-align: center;">1</td>
						<td><input id="txtCity1" type="text" class="txt c1" /></td>
						<td><input id="txtTran1" type="text" class="txt c1" /></td>
						<td><input id="txtCl1" type="text" class="txt c1" /></td>
						<td><input id="txtPdate1" type="text" class="txt c1" /></td>
						<td><input id="txtPtime1" type="text" class="txt c1" /></td>
						<td style="text-align: center;">2</td>
						<td><input id="txtCity2" type="text" class="txt c1" /></td>
						<td><input id="txtTran2" type="text" class="txt c1" /></td>
						<td><input id="txtCl2"  type="text" class="txt c1" /></td>
						<td><input id="txtPdate2" type="text" class="txt c1" /></td>
						<td><input id="txtPtime2" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblPrice1" class="lbl">大人</a></td>
						<td><input id="txtPrice1" type="text" class="txt num c1" /></td>
					</tr>
					<tr class="tour">
						<td style="text-align: center;">3</td>
						<td><input id="txtCity3" type="text" class="txt c1" /></td>
						<td><input id="txtTran3" type="text" class="txt c1" /></td>
						<td><input id="txtCl3" type="text" class="txt c1" /></td>
						<td><input id="txtPdate3" type="text" class="txt c1" /></td>
						<td><input id="txtPtime3" type="text" class="txt c1" /></td>
						<td style="text-align: center;">4</td>
						<td><input id="txtCity4" type="text" class="txt c1" /></td>
						<td><input id="txtTran4" type="text" class="txt c1" /></td>
						<td><input id="txtCl4" type="text" class="txt c1" /></td>
						<td><input id="txtPdate4" type="text" class="txt c1" /></td>
						<td><input id="txtPtime4" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblPrice2" class="lbl">小孩</a></td>
						<td><input id="txtPrice2"  type="text" class="txt num c1" /></td>
					</tr>
					<tr class="tour">
						<td style="text-align: center;">5</td>
						<td><input id="txtCity5" type="text" class="txt c1" /></td>
						<td><input id="txtTran5" type="text" class="txt c1" /></td>
						<td><input id="txtCl5" type="text" class="txt c1" /></td>
						<td><input id="txtPdate5" type="text" class="txt c1" /></td>
						<td><input id="txtPtime5" type="text" class="txt c1" /></td>
						<td style="text-align: center;">6</td>
						<td><input id="txtCity6" type="text" class="txt c1" /></td>
						<td><input id="txtTran6" type="text" class="txt c1" /></td>
						<td><input id="txtCl6" type="text" class="txt c1" /></td>
						<td><input id="txtPdate6" type="text" class="txt c1" /></td>
						<td><input id="txtPtime6" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblPrice3" class="lbl">嬰兒</a></td>
						<td><input id="txtPrice3"  type="text" class="txt num c1" /></td>
					</tr>
					<tr class="tour">
						<td style="text-align: center;">7</td>
						<td><input id="txtCity7" type="text" class="txt c1" /></td>
						<td><input id="txtTran7" type="text" class="txt c1" /></td>
						<td><input id="txtCl7" type="text" class="txt c1" /></td>
						<td><input id="txtPdate7" type="text" class="txt c1" /></td>
						<td><input id="txtPtime7" type="text" class="txt c1" /></td>
						<td style="text-align: center;">8</td>
						<td><input id="txtCity8" type="text" class="txt c1" /></td>
						<td><input id="txtTran8" type="text" class="txt c1" /></td>
						<td><input id="txtCl8" type="text" class="txt c1" /></td>
						<td><input id="txtPdate8" type="text" class="txt c1" /></td>
						<td><input id="txtPtime8" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblPrice4" class="lbl">TICK</a></td>
						<td><input id="txtPrice4"  type="text" class="txt num c1" /></td>
					</tr>
					<tr class="tour">
						<td><span> </span><a id="lblRate" class="lbl">成行率</a></td>
						<td><input id="txtRate" type="text" class="txt c1" style="width: 80%;"/> %</td>
						<td><span> </span><a id="lblDeposit" class="lbl">訂金$</a></td>
						<td colspan="2"><input id="txtDeposit" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWeb" class="lbl">網站</a></td>
						<td><input id="txtWeb" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblSchedule" class="lbl">行程表</a></td>
						<td colspan="2"><input id="txtSchedule" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblPrice6" class="lbl">會員價</a></td>
						<td><input id="txtPrice6" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblPrice5" class="lbl">JOIN</a></td>
						<td><input id="txtPrice5" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tour">
						<td><span> </span><a id="lblWorker" class="lbl">操作者</a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl">修改者</a></td>
						<td colspan="2"><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblOdate" class="lbl">訂團日</a></td>
						<td><input id="txtOdate" type="text" class="txt c1"/></td>
					</tr>
					
					
					<tr class="cost">
						<td><span> </span><a id='lblStype' class="lbl">售價別</a></td>
						<td colspan="2"><input id="txtStype"  type="text" class="txt c1" /></td>
						<td colspan="2"><span> </span><a id='lblCprice' class="lbl">單人房差售價</a></td>
						<td colspan="2"><input id="txtCprice"  type="text" class="txt num c1" /></td>
					</tr>
					<tr class="cost">
						<td><span> </span><a id='lblMemo' class="lbl">備註</a></td>
						<td colspan="10"><input id="txtMemo"  type="text" class="txt c1" /></td>
					</tr>
					<tr class="cost">
						<td> </td>
						<td colspan="10" style="text-align: center;">
							<span style="width: 155px;float: left;">大人</span>
							<span style="width: 155px;float: left;">小孩</span>
							<span style="width: 155px;float: left;">嬰兒</span>
							<span style="width: 155px;float: left;">TICKET</span>
							<span style="width: 155px;float: left;">JOIN</span>
						</td>
					</tr>
					<tr class="cost">
						<td><span> </span><a class="lbl">機票款</a></td>
						<td colspan="10">
							<input id="txtCpmoney1"  type="text" class="txt num c1" style="width: 155px;" />
							<input id="txtCpmoney2"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCpmoney3"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCpmoney4"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCpmoney5"  type="hidden" class="txt num c1" style="width: 155px;"/><span style="width: 155px;float: left;"> </span>
						</td>
					</tr>
					<tr class="cost">
						<td><span> </span><a class="lbl">團費1</a></td>
						<td colspan="10">
							<input id="txtCgmoney11"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCgmoney12"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCgmoney13"  type="hidden" class="txt num c1" style="width: 155px;"/><span style="width: 155px;float: left;"> </span>
							<input id="txtCgmoney14"  type="hidden" class="txt num c1" style="width: 155px;"/><span style="width: 155px;float: left;"> </span>
							<input id="txtCgmoney15"  type="text" class="txt num c1" style="width: 155px;"/>
						</td>
					</tr>
					<tr class="cost">
						<td><span> </span><a class="lbl">團費2</a></td>
						<td colspan="10">
							<input id="txtCgmoney21"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCgmoney22"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCgmoney23"  type="hidden" class="txt num c1" style="width: 155px;"/><span style="width: 155px;float: left;"> </span>
							<input id="txtCgmoney24"  type="hidden" class="txt num c1" style="width: 155px;"/><span style="width: 155px;float: left;"> </span>
							<input id="txtCgmoney25"  type="text" class="txt num c1" style="width: 155px;"/>
						</td>
					</tr>
					<tr class="cost">
						<td><span> </span><a class="lbl">保費</a></td>
						<td colspan="10">
							<input id="txtCimoney1"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCimoney2"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCimoney3"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCimoney4"  type="hidden" class="txt num c1" style="width: 155px;"/><span style="width: 155px;float: left;"> </span>
							<input id="txtCimoney5"  type="text" class="txt num c1" style="width: 155px;"/>
						</td>
					</tr>
					<tr class="cost">
						<td colspan="15"><Hr></td>
					</tr>
					<tr class="cost">
						<td><span> </span><a class="lbl">內稅</a></td>
						<td colspan="10">
							<input id="txtCitax1"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCitax2"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCitax3"  type="hidden" class="txt num c1" style="width: 155px;"/><span style="width: 155px;float: left;"> </span>
							<input id="txtCitax4"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCitax5"  type="text" class="txt num c1" style="width: 155px;" />
						</td>
					</tr>
					<tr class="cost">
						<td><span> </span><a class="lbl">外稅</a></td>
						<td colspan="10">
							<input id="txtCotax1"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCotax2"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCotax3"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCotax4"  type="text" class="txt num c1" style="width: 155px;"/>
							<input id="txtCotax5"  type="text" class="txt num c1" style="width: 155px;"/>
						</td>
					</tr>
					<tr class="cost">
						<td><span> </span><a class="lbl">中稅</a></td>
						<td colspan="10">
							<input id="txtCmtax1"  type="text" class="txt num c1" style="width: 155px;" />
							<input id="txtCmtax2"  type="text" class="txt num c1" style="width: 155px;" />
							<input id="txtCmtax3"  type="text" class="txt num c1" style="width: 155px;" />
							<input id="txtCmtax4"  type="text" class="txt num c1" style="width: 155px;" />
							<input id="txtCmtax5"  type="text" class="txt num c1" style="width: 155px;" />
						</td>
					</tr>
					<tr class="cost">
						<td><span> </span><a class="lbl">其他</a></td>
						<td colspan="10">
							<input id="txtCttax1"  type="text" class="txt num c1" style="width: 155px;" />
							<input id="txtCttax2"  type="text" class="txt num c1" style="width: 155px;" />
							<input id="txtCttax3"  type="text" class="txt num c1" style="width: 155px;" />
							<input id="txtCttax4"  type="text" class="txt num c1" style="width: 155px;" />
							<input id="txtCttax5"  type="text" class="txt num c1" style="width: 155px;" />
						</td>
					</tr>
					<tr class="cost">
						<td colspan="15"><Hr></td>
					</tr>
					<tr class="cost">
						<td><span> </span><a class="lbl">底價</a></td>
						<td colspan="10">
							<input id="txtCdmoney1"  type="text" class="txt num c1" style="width: 85px;"/>
							<span style="width: 70px;float: left;text-align: center;">業績人數</span>
							<input id="txtCdmoney2"  type="text" class="txt num c1" style="width: 85px;"/>
							<span style="width: 70px;float: left;text-align: center;">業績人數</span>
							<input id="txtCdmoney3"  type="text" class="txt num c1" style="width: 85px;"/>
							<span style="width: 70px;float: left;text-align: center;">業績人數</span>
							<input id="txtCdmoney4"  type="text" class="txt num c1" style="width: 85px;"/>
							<span style="width: 70px;float: left;text-align: center;">業績人數</span>
							<input id="txtCdmoney5"  type="text" class="txt num c1" style="width: 85px;"/>
							<span style="width: 70px;float: left;text-align: center;">業績人數</span>
						</td>
					</tr>
					<tr class="cost">
						<td><span> </span><a class="lbl">PAK</a></td>
						<td colspan="10">
							<input id="txtCkmoney1"  type="text" class="txt num c1" style="width: 85px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCknumber1"  type="text" class="txt num c1" style="width: 50px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCkmoney2"  type="text" class="txt num c1" style="width: 85px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCknumber2"  type="text" class="txt num c1" style="width: 50px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCkmoney3"  type="text" class="txt num c1" style="width: 85px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCknumber3"  type="text" class="txt num c1" style="width: 50px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCkmoney4"  type="text" class="txt num c1" style="width: 85px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCknumber4"  type="text" class="txt num c1" style="width: 50px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCkmoney5"  type="text" class="txt num c1" style="width: 85px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCknumber5"  type="text" class="txt num c1" style="width: 50px;"/><span style="width: 10px;float: left;"> </span>
						</td>
					</tr>
					<tr class="cost">
						<td><span> </span><a class="lbl">同行</a></td>
						<td colspan="10">
							<input id="txtCsmoney1"  type="text" class="txt num c1" style="width: 85px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCsnumber1"  type="text" class="txt num c1" style="width: 50px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCsmoney2"  type="text" class="txt num c1" style="width: 85px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCsnumber2"  type="text" class="txt num c1" style="width: 50px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCsmoney3"  type="text" class="txt num c1" style="width: 85px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCsnumber3"  type="text" class="txt num c1" style="width: 50px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCsmoney4"  type="text" class="txt num c1" style="width: 85px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCsnumber4"  type="text" class="txt num c1" style="width: 50px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCsmoney5"  type="text" class="txt num c1" style="width: 85px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCsnumber5"  type="text" class="txt num c1" style="width: 50px;"/><span style="width: 10px;float: left;"> </span>
						</td>
					</tr>
					<tr class="cost">
						<td><span> </span><a class="lbl">直客</a></td>
						<td colspan="10">
							<input id="txtCtmoney1"  type="text" class="txt num c1" style="width: 85px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCtnumber1"  type="text" class="txt num c1" style="width: 50px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCtmoney2"  type="text" class="txt num c1" style="width: 85px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCtnumber2"  type="text" class="txt num c1" style="width: 50px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCtmoney3"  type="text" class="txt num c1" style="width: 85px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCtnumber3"  type="text" class="txt num c1" style="width: 50px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCtmoney4"  type="text" class="txt num c1" style="width: 85px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCtnumber4"  type="text" class="txt num c1" style="width: 50px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCtmoney5"  type="text" class="txt num c1" style="width: 85px;"/><span style="width: 10px;float: left;"> </span>
							<input id="txtCtnumber5"  type="text" class="txt num c1" style="width: 50px;"/><span style="width: 10px;float: left;"> </span>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
