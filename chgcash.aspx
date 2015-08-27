<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
		    this.errorHandler = null;
		    function onPageError(error) {
		        alert("An error occurred:\r\n" + error.Message);
		    }

		    isEditTotal = false;
		    q_tables = 's';
		    var q_name = "chgcash";
		    var q_readonly = ['txtCarchgno', 'txtCustchgno', 'txtChgitem', 'txtChgpart', 'txtOrg', 'txtNamea', 'txtComp', 'txtAccno', 'txtNoa', 'txtWorker', 'txtMoney', 'txtWorker2'];
		    var q_readonlys = ['txtAcc2'];
		    var bbmNum = [['txtMoney', 10, 0,1],['txtOrg', 12, 0, 1]];
		    var bbsNum = [['txtMoney', 10, 0,1]];
		    var bbmMask = [];
		    var bbsMask = [];
		    q_sqlCount = 6;
		    brwCount = 6;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'noa';
		    q_desc = 1;
		    aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno', 'car2_b.aspx']
            , ['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_,txtMemo_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtSssno', 'lblSss', 'sss', 'noa,namea,partno,part', 'txtSssno,txtNamea,txtPartno,txtPart', 'sss_b.aspx']
            , ['txtChgitemno', 'lblChgitem', 'chgitem', 'noa,item', 'txtChgitemno,txtChgitem', 'chgitem_b.aspx']
            , ['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx']
            , ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
            , ['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);

		//1030726拿掉 	['txtMemo', '', 'qphr', 'code,phr', 'txtMemo,txtMemo', "qPhr_b.aspx", 'txtAcc1'],
		
		    brwCount2 = 4;

		    $(document).ready(function () {
		        bbmKey = ['noa'];
		        bbsKey = ['noa', 'noq'];
		        q_brwCount();

		        q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
		    });
		    function main() {
		        if (dataErr) {
		            dataErr = false;
		            return;
		        }
		        mainForm(0);
		    }

		    function mainPost() {
		        bbmMask = [['txtTime', '99:99'], ['txtDatea', r_picd]];
		        q_mask(bbmMask);
		        //------------------------------------------------
		        //零用金下拉式與TXT輸入
		        q_cmbParse("cmbDc", q_getPara('chgcash.typea'));
		        q_gt('acpart', '', 0, 0, 0, "",r_accy+'_'+r_cno);
		        //q_gt('carteam', '', 0, 0, 0, "");
		        q_gt('chgpart', '', 0, 0, 0, "");
		        

		        $('#txtDatea').focusout(function () {
		            q_cd($(this).val(), $(this));
		        });
		        $("#cmbDc").focus(function () {
		            var len = $("#cmbDc").children().length > 0 ? $("#cmbDc").children().length : 1;
		            $("#cmbDc").attr('size', len + "");
		        }).blur(function () {
		            $("#cmbDc").attr('size', '1');
		        });

		        $('#txtAcc1').change(function () {
		            var s1 = trim($(this).val());
		            if (s1.length > 4 && s1.indexOf('.') < 0)
		                $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
		            if (s1.length == 4)
		                $(this).val(s1 + '.');
		        });
		        $("#cmbCarteamno").focus(function () {
		            var len = $("#cmbCarteamno").children().length > 0 ? $("#cmbCarteamno").children().length : 1;
		            $("#cmbCarteamno").attr('size', len + "");
		        }).blur(function () {
		            $("#cmbCarteamno").attr('size', '1');
		        });
		        $("#cmbChgpartno").focus(function () {
		            var len = $("#cmbChgpartno").children().length > 0 ? $("#cmbChgpartno").children().length : 1;
		            $("#cmbChgpartno").attr('size', len + "");
		        }).blur(function () {
		            $("#cmbChgpartno").attr('size', '1');
		        });
		        $("#chkCarchg").change(function (e) {
		            if ($("#chkCarchg").prop("checked"))
		                $(".carchg").css('display', '');
		            else
		                $(".carchg").css('display', 'none');
		        });
		        $("#chkCustchg").change(function (e) {
		            if ($("#chkCustchg").prop("checked"))
		                $(".custchg").css('display', '');
		            else
		                $(".custchg").css('display', 'none');
		        });
		        $('#lblAccno').click(function () {
		            q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
		        });

		        $('#lblCustchg').click(function () {
		            var t_where = "";
		            var tmp = $('#txtCustchgno').val().split(',');
		            for (var i in tmp)
		                t_where += (t_where.length > 0 ? ' or ' : '') + "noa='" + tmp[i] + "'";
		            q_pop('txtCustchgno', "custchg.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy + '_' + r_cno, 'custchg', 'noa', 'datea', "92%", "1000px", q_getMsg('popCustchg'), true);
		        });
		        $('#lblCarchg').click(function () {
		            var t_where = "";
		            var tmp = $('#txtCarchgno').val().split(',');
		            for (var i in tmp)
		                t_where += (t_where.length > 0 ? ' or ' : '') + "noa='" + tmp[i] + "'";
		            q_pop('txtCarchgno', "carchg.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy + '_' + r_cno, 'custchg', 'noa', 'datea', "92%", "1000px", q_getMsg('popCarchg'), true);
		        });
		        //alert('mainpost');
		    }
		    function q_funcPost(t_func, result) {
		        switch (t_func) {
		            default:
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
		        b_pop = '';
		    }

		    function q_gtPost(t_name) {
		        switch (t_name) {
		            case 'chgcashorg':
		                var as = _q_appendData("chgcash", "", true);
		                if (as[0] != undefined)
		                    $('#txtOrg').val(as[0].total);
		                break;
		            case 'carteam':
		                var as = _q_appendData("carteam", "", true);
		                if (as[0] != undefined) {
		                    var t_item = "";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
		                    }
		                    q_cmbParse("cmbCarteamno", t_item);
		                    $("#cmbCarteamno").val(abbm[q_recno].carteamno);
		                }
		                break;
		            case 'acpart':
		                var as = _q_appendData("acpart", "", true);
		                if (as[0] != undefined) {
		                    var t_item = "@";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
		                    }
		                    q_cmbParse("cmbPartno", t_item, 's');
		                    refresh(q_recno);  /// 第一次需要重新載入
		                }
		                break;
		            case 'chgpart':
		                var as = _q_appendData("chgpart", "", true);
		                if (as[0] != undefined) {
		                    var t_item = "";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
		                    }
		                    q_cmbParse("cmbChgpartno", t_item);
		                    if(abbm[q_recno])
		                    	$("#cmbChgpartno").val(abbm[q_recno].chgpartno);
		                }
		                break;
		            case q_name:
		                if (q_cur == 4)
		                    q_Seek_gtPost();
		                break;
		            default:
		                break;
		        }
		    }

		    function btnOk() {
		        for (var i = 0; i < q_bbsCount; i++) {
		            $('#txtPart_' + i).val($('#cmbPartno_' + i).find(":selected").text());
		        }
		        
		        if ($('#txtSssno').val().length == 0)
		            $('#txtNamea').val('');
		        if (!$("#chkCarchg").prop("checked")) {
		            $('#cmbCarteamno').val('');
		        }
		        
		        if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
		            alert(q_getMsg('lblDatea') + '錯誤。');
		            return;
		        }
		       
		       //104/05/13 開放1111可以輸入
		       if($('#cmbDc').val() == 3){
		        	if( ($('#txtAcc1').val() == '') || ($('#txtAcc2').val() == '') || ($('#txtAcc1').val().substring(0,4) !='1111' && $('#txtAcc1').val().substring(0,4) !='1112') ){
		        		alert('請輸入' + q_getMsg('lblAcc1') + '且為1111或1112開頭' );
		        		return;
		        	}
		        }
		        
		        //104/05/13 判斷表身一定要有資料才能存檔
		        var bbs_count=false;
		        for (var i = 0; i < q_bbsCount; i++) {
		        	if(!emp($('#txtAcc1_'+i).val())){
		        		bbs_count=true;
		        		break;
		        	}
		        }
		        if(!bbs_count){
		        	alert('表身無資料。');
		            return;
		        }
		        
		        if(emp($('#txtPartno').val()) || $('#txtPartno').val()=='0'){
		        	$('#txtPartno').val($('#cmbPartno_0').val());
		        	$('#txtPart').val($('#cmbPartno_0').find(":selected").text());
		        }
		        
		        sum();
		        
		        if(q_cur ==1){
	            	$('#txtWorker').val(r_name);
	            }else if(q_cur ==2){
	            	$('#txtWorker2').val(r_name);
	            }else{
	            	alert("error: btnok!")
	            }
		        $('#txtChgpart').val($('#cmbChgpartno').find(":selected").text());
		        var t_noa = trim($('#txtNoa').val());
		        var t_date = trim($('#txtDatea').val());
		        if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll(q_getPara('sys.key_chgcash') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);
		    }

		    function _btnSeek() {
		        if (q_cur > 0 && q_cur < 4)
		            return;

		        q_box('chgcash_s.aspx', q_name + '_s', "550px", "520px", q_getMsg("popSeek"));
		    }

		    function bbsAssign() {
		        for (var i = 0; i < q_bbsCount; i++) {
		            $('#lblNo_' + i).text(i + 1);
		            if (!$('#btnMinus_' + i).hasClass('isAssign')) {
		                $('#txtMoney_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtAcc1_' + i).change(function (e) {
		                    var str = $.trim($(this).val());
		                    if ((/^[0-9]{4}$/g).test(str))
		                        $(this).val(str + '.');
		                });
		            }
		        }
		        _bbsAssign();
		    }

		    function sum() {
		        if (!(q_cur == 1 || q_cur == 2))
		            return;
		        var t_money = 0;
		        for (var i = 0; i < q_bbsCount; i++) {
		            t_money += q_float('txtMoney_' + i);
		        }
		        $('#txtMoney').val(t_money);
		    }

		    function btnIns() {
		        _btnIns();
		        $('#txtNoa').val('AUTO');
		        //申請日期與時間
		        var now = new Date();
		        $('#txtDatea').val(q_date());
		        $('#txtTime').val((now.getHours() < 10 ? '0' : '') + now.getHours() + ':' + (now.getMinutes() < 10 ? '0' : '') + now.getMinutes());

		        //申請金額初始
		        $('#txtMoney').val(0);

		        $('#txtDatea').focus();
		    }

		    function btnModi() {
		        if (emp($('#txtNoa').val()))
		            return;
		        if (q_chkClose())
             		    return;
		        _btnModi();
		        $('#txtDatea').focus();
		        sum();
		    }

		    function btnPrint() {
		        q_box('z_chgcash.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "90%", "600px", q_getMsg("popPrint"));
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
		        return true;
		    }

		    function refresh(recno) {
		        _refresh(recno);	
		        cashorg();
		        if ($("#chkCarchg").prop("checked"))
		            $(".carchg").css('display', '');
		        else
		            $(".carchg").css('display', 'none');
		        if ($("#chkCustchg").prop("checked"))
		            $(".custchg").css('display', '');
		        else
		            $(".custchg").css('display', 'none');
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
		    	if (q_chkClose())
					return;
		        _btnDele();
		    }

		    function btnCancel() {
		        _btnCancel();
		    }
		    //...........................................零用金餘額查詢
		    function cashorg() {
		    	if($('#cmbChgpartno').val()==null&&abbm[0])
		    		var t_where = "where=^^ chgpartno='" + abbm[0].chgpartno + "'^^";
		    	else
		        	var t_where = "where=^^ chgpartno='" + $('#cmbChgpartno').val() + "'^^";
		        q_gt('chgcashorg', t_where, 0, 0, 0, "", r_accy);
		    }

		    //..........................................................
		    function q_stPost() {
		        if (!(q_cur == 1 || q_cur == 2))
		            return false;
		        abbm[q_recno]['accno'] = xmlString;
		        $('#txtAccno').val(xmlString);
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
		        } else if ((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//西元年
		            var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
		            if (regex.test(str))
		                return 3;
		        } else if ((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//民國年
		            str = (parseInt(str.substring(0, 3)) + 1911) + str.substring(3);
		            var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
		            if (regex.test(str))
		                return 4
		        }
		        return 0; //錯誤
		    }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 750px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 950px;
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
                width: 10%;
            }
            .tbbm .tr1 {
                background-color: #FFEC8B;
            }
            .tbbm .tr_carchg {
                background-color: #DAA520;
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
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 40%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
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
            .dbbs {
                width: 950px;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"], select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewMoney'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewChgpart'> </a></td>
						<td align="center" style="width:250px; color:black;"><a id='vewAcc2'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" />
						</td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="money,0,1" style="text-align: right;">~money,0,1</td>
						<td id="chgpart" style="text-align: center;">~chgpart</td>
						<td id="acc2" style="text-align: center;">~acc2</td>
					</tr>
				</table>
			</div>
			<div style="background-color:gray; width:200px;float:left; margin: 5px; padding: 5px; color:white;">
				<b>若要歸到個人成本，才需輸入員工編號。</b>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr name="schema" style="height:1px;">
						<td class="td1"><span class="schema"> </span></td>
						<td class="td2"><span class="schema"> </span></td>
						<td class="td3"><span class="schema"> </span></td>
						<td class="td4"><span class="schema"> </span></td>
						<td class="td5"><span class="schema"> </span></td>
						<td class="td6"><span class="schema"> </span></td>
						<td class="td7"><span class="schema"> </span></td>
						<td class="td8"><span class="schema"> </span></td>
						<td class="tdZ"><span class="schema"> </span></td>
					</tr>
					<tr class="tr1">
						<td class="td1"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td2"><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblTime" class="lbl"> </a></td>
						<td class="td4"><input id="txtTime"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
						<td class="td7"> </td>
						<td class="td8"> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr class="tr3">
						<td><span > </span><a id="lblDc" class="lbl"> </a></td>
						<td><select id="cmbDc" class="txt c1"> </select></td>
						<td><span> </span><a id="lblSss" class="lbl btn"> </a></td>
						<td>
							<input id="txtSssno"  type="text"  class="txt c4"/>
							<input id="txtNamea" type="text"  class="txt c4"/>
							<input id="txtPartno"  type="hidden"/>
							<input id="txtPart" type="hidden"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblChgpart" class="lbl"> </a></td>
						<td>
							<select id="cmbChgpartno" class="txt c1"> </select>
							<input id="txtChgpart"  type="text" style="display: none;"/>
						</td>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblAcc1" class="lbl btn"> </a></td>
						<td><input id="txtAcc1" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtAcc2" type="text" class="txt c1"/>
						</td>					
					</tr>
					<tr>
						<td><span> </span><a id="lblOrg" class="lbl"> </a></td>
						<td><input id="txtOrg"  type="text" class="txt num c1" /></td>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo"  type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:80px;"><a id='lblPart_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblProj_s'>專案代號</a></td>
					<td align="center" style="width:200px;"><a id='lblAcc_s'> </a></td>
					<td align="center" style="width:300px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMoney_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<select id="cmbPartno.*" class="txt c1"> </select>
						<input id="txtPart.*"  type="text" style="display: none;"/>
					</td>
					<td><input type="text" id="txtProj.*"  /></td>
					<td>
						<input class="btn"  id="btnAcc.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
						<input type="text" id="txtAcc1.*"  style="width:35%;"/>
						<input type="text" id="txtAcc2.*"  style="width:45%;"/>
					</td>
					<td ><input type="text" id="txtMemo.*" style="width:95%;" /></td>
					<td><input type="text" id="txtMoney.*" style="width:95%;text-align: right;" /></td>

				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
