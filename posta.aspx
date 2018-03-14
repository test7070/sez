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
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            var q_name = "posta";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_desc = 1;
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array();

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
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
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm], ['txtBdate', '99'], ['txtEdate', '99'],['txtBvccdate',r_picd],['txtEvccdate',r_picd]];
                q_mask(bbmMask);
                $("#lblMon").text('帳款月份');
                q_cmbParse("cmbTypea", q_getPara('posta.typea'));
                q_cmbParse("cmbKind", '客戶,廠商');

                $('#btnInput').click(function() {
                    if ($('#cmbKind').val() == '廠商') {
                        var t_where = "where=^^ EXISTS ( select c.noa from tgg_2s c where c.noa = a.noa and c.mon <= '" + $('#txtMon').val() + "'and c.unpay>0) ^^";
                        var t_where1 = "where[1]=^^a.noa=noa and isnull(bill,0)=1 ^^";
                        q_gt('tgg_conn', t_where + t_where1, 0, 0, 0, "", r_accy);
                    } else {
                    	var t_where = "";
                    	if (q_getPara('sys.project').toUpperCase() == 'XY') {
                    		t_where = "EXISTS (select case when xb.vcccustno!='' then xb.vcccustno else xa.custno end custno from view_vcc xa left join custm xb on xa.custno=xb.noa";
                    		t_where = t_where + " where xa.unpay!=0  and xa.mon<='"+$('#txtMon').val()+"'";
                    		if(!emp($('#txtBvccdate').val()) || !emp($('#txtEvccdate').val())){
                    			var t_evdate=$.trim($('#txtEvccdate').val());
                    			if(t_evdate.length==0){
                    				t_where = t_where + "and xa.datea between '"+$('#txtBvccdate').val()+"' and char(255) ";
                    			}else{
                    				t_where = t_where + "and xa.datea between '"+$('#txtBvccdate').val()+"' and '"+t_evdate+"' ";
                    			}
                    		}
                    		t_where = t_where + " group by case when xb.vcccustno!='' then xb.vcccustno else xa.custno end having case when xb.vcccustno!='' then xb.vcccustno else xa.custno end=a.noa )";
                    		t_where = t_where + " and c.postmemo!='不寄單' and c.postmemo!='抵貨款' and c.postmemo!='親送單' ";
                            if(!emp($('#txtBdate').val()) || !emp($('#txtEdate').val())){
                            	var t_bate=$('#txtBdate').val();
                            	var t_eate=$('#txtEdate').val();
                            	if(t_eate.length==0){
                            		t_eate='31';
                            	}
                            	t_where = t_where + " and isnull(a.startdate,'') between '" + t_bate + "' and '" + t_eate + "'";
                            }
                            if (!emp($('#txtSalesno').val()))
								t_where = t_where + " and salesno='" + $('#txtSalesno').val() + "' order by c.postmemo,a.noa";
                        }else{
                        	t_where = "EXISTS ( select c.noa from cust_2s c where c.noa = a.noa and c.mon <= '" + $('#txtMon').val() + "'and c.unpay>0) ";
                        }
                        t_where = "where=^^ " + t_where + " ^^";
                        var t_where1 = "where[1]=^^a.noa=noa and isnull(bill,0)=1 ^^";
                        q_gt('cust_conn', t_where + t_where1, 0, 0, 0, "", r_accy);
                    }
                });
                
                $('#cmbKind').change(function() {
                    if ($('#cmbKind').val() == '廠商') {
                        if (q_getPara('sys.project').toUpperCase() == 'XY')
                            aPop = new Array(['txtUseno_', 'btnUseno_', 'tgg', 'noa,nick,addr_invo,zip_invo,comp,tel,conntel,serial', 'txtUseno_,txtComp_,txtAddr_,txtZipcode_', 'tgg_b.aspx'], ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']);
                        else
                            aPop = new Array(['txtUseno_', 'btnUseno_', 'tgg', 'noa,comp,addr_home,zip_home', 'txtUseno_,txtComp_,txtAddr_,txtZipcode_', 'tgg_b.aspx']);
                    } else {
                        if (q_getPara('sys.project').toUpperCase() == 'XY')
                            aPop = new Array(['txtUseno_', 'btnUseno_', 'cust', 'noa,nick,addr_invo,zip_invo,comp,tel,invoicetitle,serial', 'txtUseno_,txtComp_,txtAddr_,txtZipcode_', 'cust_b.aspx'], ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']);
                        else
                            aPop = new Array(['txtUseno_', 'btnUseno_', 'cust', 'noa,comp,addr_home,zip_home', 'txtUseno_,txtComp_,txtAddr_,txtZipcode_', 'cust_b.aspx']);
                    }
                });
                q_popAssign();
                $('#cmbKind').change();

            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                
                if(q_cur==1 || q_cur==2){
                	if( b_pop == '' && s2[0]!=undefined){
                		if(tbseq.toString()!='' && b_seq==""){
                			b_seq=tbseq;
                		}
                		if (q_getPara('sys.project').toUpperCase() == 'XY' && !emp($('#txtUseno_' + b_seq).val())) {
                            if ($('#cmbKind').val() != '廠商') {
                            	//1050302 不管附回郵 都顯示出來 and charindex('附回郵',postmemo)>0
                                t_where = "where=^^ noa='" + $('#txtUseno_' + b_seq).val() + "' ^^";
                                q_gt('custm', t_where, 0, 0, 0, "cust_post_xy", r_accy);
                            }
                            t_where = "where=^^ noa='" + $('#txtUseno_' + b_seq).val() + "' and isnull(bill,0)=1^^";
                            q_gt('conn', t_where, 0, 0, 0, "conn_xy", r_accy);
                        }
                	}
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    case 'cust_post_xy':
                        var as = _q_appendData("custm", "", true);
                        if (as[0] != undefined) {
                            var t_memo = as[0].postmemo;
                            //105/03/02 t_memo = t_memo.substring(2, t_memo.length);
                            //t_memo=t_memo.substring(0,t_memo.indexOf('##'));
                            $('#txtMemo_' + b_seq).val(t_memo);
                            //$('#txtMemo_'+b_seq).val('附回郵');
                        }
                        break;
                    case 'conn_xy':
                        var as = _q_appendData("conn", "", true);
                        if (as[0] != undefined) {
                            $('#txtPart_' + b_seq).val(as[0].part);
                            $('#txtConn_' + b_seq).val(as[0].namea);
                        }
                        break;
                    case 'tgg_conn':
                        var as = _q_appendData("tgg_conn", "", true);
                        for ( i = 0; i < as.length; i++) {
                            if (as[i].addr_invo != '' && q_getPara('sys.project').toUpperCase() == 'XY')
                                as[i].addr_comp = as[i].addr_invo;
                        }
                        q_gridAddRow(bbsHtm, 'tbbs', 'txtUseno,txtComp,txtZipcode,txtAddr,txtPart,txtConn', as.length, as, 'noa,comp,zip_comp,addr_comp,cpart,cname', '');
                        break;
                    case 'cust_conn':
                        var as = _q_appendData("cust_conn", "", true);
                        for ( i = 0; i < as.length; i++) {
                            as[i].memo = '';
                            if (as[i].addr_invo != '' && q_getPara('sys.project').toUpperCase() == 'XY')
                                as[i].addr_comp = as[i].addr_invo;
							//105/10/17 條件不適用
                            /*if (q_getPara('sys.project').toUpperCase() == 'XY') {
                                if (as[i].postmemo.indexOf('附回郵') > -1)
                                    as[i].memo = as[i].memo.substring(2, as[i].memo.length);
                            }*/
                        }
                        
                        if (q_getPara('sys.project').toUpperCase() == 'XY') {
                        	q_gridAddRow(bbsHtm, 'tbbs', 'txtUseno,txtComp,txtZipcode,txtAddr,txtPart,txtConn,txtMemo', as.length, as, 'noa,nick,zip_comp,addr_comp,cpart,cname,memo', '');
						}else{
							q_gridAddRow(bbsHtm, 'tbbs', 'txtUseno,txtComp,txtZipcode,txtAddr,txtPart,txtConn,txtMemo', as.length, as, 'noa,comp,zip_comp,addr_comp,cpart,cname,memo', '');
						}
						
						
                        break;
                }  /// end switch
            }

            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                if(q_cur==1 && !emp($('#txtBsno').val()) && q_getPara('sys.project').toUpperCase() == 'XY'){
                	//產生掛號編號
                	var counts=0;
                	for (var j = 0; j < q_bbsCount; j++) {
                		if(emp($('#txtSno_'+j).val()) && (!emp($('#txtUseno_'+j).val()) || !emp($('#txtComp_'+j).val()) || !emp($('#txtZipcode_'+j).val()) || !emp($('#txtAddr_'+j).val()))){
                			var t_no=$('#txtBsno').val().substr(0,6);
                			var t_nos=$('#txtBsno').val().substr(7,$('#txtBsno').val().length);
                			t_no=dec(t_no)+counts;
                			t_no=('000000'+t_no).slice(-6);
                			$('#txtSno_'+j).val(t_no);//+t_nos  1117 不需要出現後面的數字
                			counts++;
                		}
                	}
                }
				
				if(q_cur==1)
                	$('#txtWorker').val(r_name);
                else
                	$('#txtWorker2').val(r_name);

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll($('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('posta_s.aspx', q_name + '_s', "550px", "440px", q_getMsg("popSeek"));
            }
			
			var tbseq='',tpseq='';
            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	
                    }
                    $('#txtUseno_' + i).change(function() {
                        t_IdSeq = -1;
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        tbseq=b_seq;
                        tpseq=b_seq;
                    });
                    $('#btnUseno_' + i).change(function() {
                        t_IdSeq = -1;
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        tbseq=b_seq;
                        tpseq=b_seq;
                    });
                }
                _bbsAssign();
                
                $('#btnRenumber_xy').bind('click', function(event) {
                  if(q_cur==1 || q_cur==2){
                    	//產生掛號編號
	                	var counts=0;
	                	for (var j = 0; j < q_bbsCount; j++) {
	                		$('#txtSno_'+j).val('');
	                		if((!emp($('#txtUseno_'+j).val()) || !emp($('#txtComp_'+j).val()) || !emp($('#txtZipcode_'+j).val()) || !emp($('#txtAddr_'+j).val()))){
	                			var t_no=$('#txtBsno').val().substr(0,6);
	                			t_no=dec(t_no)+counts;
	                			t_no=('000000'+t_no).slice(-6);
	                			$('#txtSno_'+j).val(t_no);
	                			counts++;
	                		}
	                	}
                    }
                });

                if (q_getPara('sys.project').toUpperCase() == 'XY') {
                    $('#lblBsno').text('條碼起始號');
                    $('#lblSales').text('業務');
                    $('#lblSno_s').text('條碼編號');
                    $('#lblBdate').text('起算日起迄');
                    $('#lblVccdate').text('出貨日起迄');
                    $('.isXY').show();
                } else
                    $('.isXY').hide();
            }

            function btnIns() {
                _btnIns();
                var sInfo = (q_getPara('sys.tel')).toUpperCase();
                var s_tel = sInfo.substring(0, sInfo.indexOf('FAX'));
                $('#txtTel').val(s_tel);
                $('#txtComp').val(q_getPara('sys.comp'));
                $('#txtAddr').val(q_getPara('sys.addr'));
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date()).focus();
                $('#txtMon').val(q_date().substr(0, 6));
                $('#cmbTypea').val('2');
                //預設掛號
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
                var t_where = "noa='" + $('#txtNoa').val() + "'";
                q_box("z_posta.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['useno'] && !as['comp'] && !as['zipcode'] && !as['addr']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['date'] = abbm2['date'];
                return true;
            }

            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
            function refresh(recno) {
                _refresh(recno);
                if (q_getPara('sys.project').toUpperCase() == 'XY') {
                    $('#lblBsno').text('條碼起始號');
                    $('#lblSales').text('業務');
                    $('#lblSno_s').text('條碼編號');
                    $('#lblBdate').text('起算日起迄');
                    $('.isXY').show();
                } else
                    $('.isXY').hide();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    $('#btnInput').attr('disabled', 'disabled');
                    $('#btnRenumber_xy').attr('disabled', 'disabled');
                } else {
                    $('#btnInput').removeAttr('disabled', 'disabled');
                    $('#btnRenumber_xy').removeAttr('disabled', 'disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
                /// 表身運算式
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

            function q_popPost(s1) {
                switch (s1) {
                    case 'txtUseno_':
                    	if(tpseq.toString()!='' && b_seq==""){
                			b_seq=tpseq;
                		}
                        if (q_getPara('sys.project').toUpperCase() == 'XY' && !emp($('#txtUseno_' + b_seq).val())) {
                            if ($('#cmbKind').val() != '廠商') {
                            	//1050302 不管附回郵 都顯示出來 and charindex('附回郵',postmemo)>0
                                t_where = "where=^^ noa='" + $('#txtUseno_' + b_seq).val() + "' ^^";
                                q_gt('custm', t_where, 0, 0, 0, "cust_post_xy", r_accy);
                            }
                            t_where = "where=^^ noa='" + $('#txtUseno_' + b_seq).val() + "' and isnull(bill,0)=1^^";
                            q_gt('conn', t_where, 0, 0, 0, "conn_xy", r_accy);
                        }
                        break;
                }
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 250px;
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
                width: 850px;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 0px white double;
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
                width: 3%;
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
                width: 61%;
                float: left;
            }
            .txt.c4 {
                width: 25%;
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
                width: 1250px;
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
            select {
                font-size: medium;
            }
            .tbbs .td1 {
                width: 4%;
            }
            .tbbs .td2 {
                width: 6%;
            }
            .tbbs .td3 {
                width: 8%;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" style="float: left;">
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:50%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:30%"><a id='vewTypea'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='typea=cmbTypea'>~typea=cmbTypea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='0'>
					<tr class="tr1">
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td class="td4"><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblTypea" class="lbl" > </a></td>
						<td class="td6"><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id='lblComp' class="lbl"> </a></td>
						<td class="td2" colspan="3"><input id="txtComp" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblKind" class="lbl" > </a></td>
						<td class="td6"><select id="cmbKind" class="txt c1"> </select></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblTel" class="lbl" > </a></td>
						<td class="td2" colspan="3"><input id="txtTel" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblMon" class="lbl" > </a></td>
						<td class="td4"><input id="txtMon" type="text" class="txt c1"/></td>
						<td class="td6"><input id="btnInput" type="button" value="帳款匯入" /></td>
					</tr>
					<tr class="isXY" style="display: none;">
						<td class="td1"><span> </span><a id="lblBsno" class="lbl" > </a></td>
						<td class="td2" colspan="3"><input id="txtBsno" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblBdate" class="lbl" > </a></td>
						<td class="td6" colspan="3">
							<input id="txtBdate" type="text" class="txt c1" style="width: 50px;"/>
							<a class="lbl" style="float: left;">~</a>
							<input id="txtEdate" type="text" class="txt c1" style="width: 50px;"/>
						</td>
					</tr>
					<tr class="isXY" style="display: none;">
						<td class="td1"><span> </span><a id="lblSales" class="lbl btn" > </a></td>
						<td class="td2"><input id="txtSalesno" type="text" class="txt c1"/></td>
						<td class="td3"><input id="txtSales" type="text" class="txt c1"/></td>
						<td class="td4"> </td>
						<td class="td5"><span> </span><a id="lblVccdate" class="lbl" > </a></td>
						<td class="td6" colspan="3">
							<input id="txtBvccdate" type="text" class="txt c1" style="width:85px;"/>
							<a class="lbl" style="float: left;">~</a>
							<input id="txtEvccdate" type="text" class="txt c1" style="width:85px;"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td class="td2" colspan="5"><input id="txtAddr" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td class="td4"><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width: 1%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td style="width:20px;"> </td>
					<td align="center" style="width: 10%;">
						<a id='lblSno_s'>掛號號碼</a>
						<input id="btnRenumber_xy" type="button" class="isXY" value="重新編號" style="display: none;" />
					</td>
					<td align="center" style="width: 13%;"><a id='lblUseno_s'> </a></td>
					<td align="center" style="width: 15%;"><a id='lblComp_s'> </a></td>
					<td align="center" style="width: 65px;"><a id='lblZipcode_s'> </a></td>
					<td align="center" style="width: 30%;"><a id='lblAddr_s'> </a></td>
					<td align="center"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width: 8%;"><a id='lblPart_s'> </a></td>
					<td align="center" style="width: 8%;"><a id='lblConn_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtSno.*" type="text" class="txt c1" /></td>
					<td>
						<input id="txtUseno.*" type="text" class="txt" style="width:80%;"/>
						<input type="button" id="btnUseno.*" value="." style="width:1%;">
					</td>
					<td><input id="txtComp.*" type="text" class="txt c1"/></td>
					<td><input id="txtZipcode.*" type="text" class="txt c1" /></td>
					<td><input id="txtAddr.*" type="text" class="txt c1" /></td>
					<td><input id="txtMemo.*" type="text" class="txt c1" /></td>
					<td><input id="txtPart.*" type="text" class="txt c1" /></td>
					<td><input id="txtConn.*" type="text" class="txt c1" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>