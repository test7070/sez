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

            q_tables = 's';
            var q_name = "salvaca";
            var q_readonly = ['txtTotal'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtInday', 10, 1, 1], ['txtOutday', 10, 1, 1], ['txtTotal', 10, 1, 1], ['txtBoutday', 10, 1, 1], ['txtPrevyeartime', 10, 1, 1], ['txtLimitday', 3, 0, 1], ['txtNextyeartime', 10, 1, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            aPop = new Array(['txtSssno_', 'btnSss_', 'sss', 'noa,namea,id,rank,indate,cno', 'txtSssno_,txtNamea_,txtId_,txtRank_,txtJobday_,txtCno_', 'sss_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                brwCount2 = 5
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)

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
                bbsMask = [['txtJobday', r_picd]];
                q_mask(bbsMask);

                $('#btnIndata').click(function() {
                    if (!emp($('#txtNoa').val())) {
                    	//找去年移至下年度的特休
                    	var t_where = "where=^^ noa='"+dec($('#txtNoa').val())-1+"' ^^";
                        q_gt('salvaca', t_where, 0, 0, 0, "salvaca_indata", r_accy);
                    }
                });

            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }
			
			var t_salvaca;
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'salvaca_indata':
                		t_salvaca = _q_appendData("salvacas", "", true);
                		
                		var t_where = "where=^^ outdate is null OR outdate='' ^^";
                        q_gt('sss', t_where, 0, 0, 0, "", r_accy);
                		break;
                    case 'sss':
                        var as = _q_appendData("sss", "", true);

                        for (var j = 0; j < q_bbsCount; j++) {
                            for (var i = 0; i < as.length; i++) {
                                if (as[i].noa == $('#txtSssno_' + j).val() || dec($('#txtNoa').val()) - dec(as[i].indate.substr(0, 3)) < 0) {
                                    as.splice(i, 1);
                                    i--;
                                }
                            }
                        }
                        //計算應休天數(特休)
                        for (var i = 0; i < as.length; i++) {
                            //as._year年資
                            //as._day特休天數
                            if (as[i].indate.length > 0)//判斷到職日是否有輸入，若沒輸入則無特休
                                as[i]._year = dec($('#txtNoa').val()) - dec(as[i].indate.substr(0, 3));
                            else
                                as[i]._year = 0;

                            if (as[i]._year == 0 && as[i].indate.substr(4) == '01/01') {
                                as[i]._year = 1;
                            }
                            if (as[i]._year < 1)
                                as[i]._day = 0;
                            else if (as[i]._year < 3)
                                as[i]._day = 7;
                            else if (as[i]._year < 5)
                                as[i]._day = 10;
                            else if (as[i]._year < 10)
                                as[i]._day = 14;
                            else {
                                if (14 + as[i]._year - 9 > 30)
                                    as[i]._day = 30;
                                else
                                    as[i]._day = 14 + as[i]._year - 9;
                            }

                            as[i]._day = as[i]._day * 8;
                            
                            as[i].prevyeartime=0;
                            for (var j = 0; j < t_salvaca.length; j++) {
                            	if(t_salvaca[j].sssno==as[i].noa){
                            		as[i].prevyeartime=dec(t_salvaca[j].nextyeartime);
                            	}
                            }
                        }

                        q_gridAddRow(bbsHtm, 'tbbs', 'txtSssno,txtNamea,txtId,txtJob,txtJobday,txtInday,txtTotal,txtCno,txtPrevyeartime', as.length, as, 'noa,namea,id,job,indate,_day,_day,cno,prevyeartime', 'txtSssno');
                        sum();
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }

                $('#txtWorker').val(r_name)
                sum();

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll($('#txtNoa').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('salvaca_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        $('#txtOutday_' + j).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            q_tr('txtTotal_' + b_seq, q_float('txtInday_' + b_seq) - q_float('txtOutday_' + b_seq) - q_float('txtBoutday_' + b_seq));
                        });
                        $('#txtBoutday_' + j).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            q_tr('txtTotal_' + b_seq, q_float('txtInday_' + b_seq) - q_float('txtOutday_' + b_seq) - q_float('txtBoutday_' + b_seq));
                        });
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val(q_date().substr(0, 3));
                $('#txtSssno_0').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtSssno_0').focus();
            }

            function btnPrint() {
                q_box("z_salvacap.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy + "_" + r_cno, 'salvaca', "95%", "95%", q_getMsg("popSalvaca"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['sssno']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();

                return true;
            }

            function sum() {
                var t_total = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!emp($('#txtSssno_' + j).val()))
                        t_total++;
                }
                $('#txtTotal').val(t_total);
            }

            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
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
                width: 28%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 70%;
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
                width: 75%;
                float: left;
            }
            .txt.c3 {
                width: 47%;
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
                width: 25%;
            }
            .txt.c7 {
                width: 95%;
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
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .tbbs {
                FONT-SIZE: medium;
                COLOR: blue;
                TEXT-ALIGN: left;
                BORDER: 1PX LIGHTGREY SOLID;
                width: 100%;
                height: 98%;
            }

            .tbbs .td1 {
                width: 8%;
            }

		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" style="float: left;  width:32%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:20%"><a id='vewNoa'></a></td>
						<td align="center" style="width:25%"><a id='vewTotal'></a></td>

					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='total'>~total</td>

					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 68%;float:left">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr>
						<td class='td1'><span> </span><a id="lblNoa" class="lbl"></a></td>
						<td class="td2">
						<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
						<td class='td3'>
						<input id="btnIndata" type="button" />
						</td>
						<td class="td4"></td>
					</tr>
					<tr>
						<td class='td1'><span> </span><a id="lblTotal" class="lbl"></a></td>
						<td class="td2">
						<input id="txtTotal"  type="text" class="txt num c1"/>
						</td>
						<td class='td3'></td>
						<td class="td4"></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1410px;">
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" class="td1" style="width: 110px;"><a id='lblSssno'> </a></td>
					<td align="center" class="td1" style="width: 100px;"><a id='lblNamea'> </a></td>
					<td align="center" style="width: 120px;"><a id='lblId'> </a></td>
					<td align="center" style="width: 120px;"><a id='lblJob'> </a></td>
					<td align="center" class="td1" style="width: 100px;"><a id='lblJobday'> </a></td>
					<td align="center" class="td1" style="width: 90px;"><a id='lblInday'> </a></td>
					<td align="center" class="td1" style="width: 100px;"><a id='lblOutday'> </a></td>
					<td align="center" class="td1" style="width: 100px;"><a id='lblBoutday'> </a></td>
					<td align="center" class="td1" style="width: 100px;"><a id='lblTotals'> </a></td>
					<td align="center" class="td1" style="width: 100px;"><a id='lblCno'> </a></td>
					<td align="center"><a id='lblMemo'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
					<td >
						<input class="txt c2" id="txtSssno.*" type="text" />
						<input id="btnSss.*" type="button" value="." style="width: 1%;float: right;"/>
					</td>
					<td ><input class="txt c1" id="txtNamea.*" type="text" /></td>
					<td ><input class="txt c1" id="txtId.*" type="text" /></td>
					<td ><input class="txt c1" id="txtJob.*"type="text" /></td>
					<td ><input class="txt c1" id="txtJobday.*"type="text" /></td>
					<td ><input class="txt num c1" id="txtInday.*" type="text"/></td>
					<td ><input class="txt num c1" id="txtOutday.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtBoutday.*" type="text"/></td>
					<td ><input class="txt num c1" id="txtTotal.*" type="text"/></td>
					<td ><input class="txt c1" id="txtCno.*" type="text" /></td>
					<td >
						<input class="txt c1" id="txtMemo.*"type="text" />
						<input id="txtNoq.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
