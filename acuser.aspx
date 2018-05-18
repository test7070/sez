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
            var q_name = "acuser";
            var q_readonly = [];
            var q_readonlys = ['txtAccc6'];
            var decbbs = ['accc8', 'floata'];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [], t_proj;
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = [['txtPart_', 'btnPart_', 'part', 'noa,part', 'txtPart_', "acpart_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno], ['txtAccc5_', 'btnAcc_', 'acc', 'acc1,acc2,acc7', 'txtAccc5_,txtAccc6_,txtAccc7_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno], ['txtProj_', 'btnProj_', 'proj', 'noa,proj', 'txtProj_,,txtPart_', "proj_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]];
            var dcType;
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                brwCount2 = 6;
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

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                    case 'qphr':
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if (!b_ret || b_ret.length == 0)
                                return;

                            if (b_seq < 0 || b_seq >= q_bbsCount)
                                ;
                            $('#txtAccc7_' + b_seq).val(b_ret[0].phr);
                        }
                        break;

                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'qphr':
                        var as = _q_appendData('qphr', '', true);
                        if (as && as.length > 0)
                            $('#txtAccc7_' + b_seq).val(as[0]['phr']);
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

                var td = 0, tc = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    td = td + dec($('#txtDmoney_' + j).val());
                    tc = tc + dec($('#txtCmoney_' + j).val());
                }// j
                if ((td != 0 || tc != 0) && td != tc) {
                    alert("不平衡：借方合計=" + td + "  貸方合計=" + tc);
                    return 0;
                }

                $('#txtWorker').val(r_name)
                sum();

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('acuser_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function mainPost() {
                q_getFormat();
                dcType = q_getPara2('acc.dc');
                t_proj = q_getPara('accc.proj');
                
                //上方插入空白行
		        $('#lblTop_row').mousedown(function (e) {
		            if (e.button == 0) {
		                mouse_div = false;
		                q_bbs_addrow(row_bbsbbt, row_b_seq, 0);
		            }
		        });
		        //下方插入空白行
		        $('#lblDown_row').mousedown(function (e) {
		            if (e.button == 0) {
		                mouse_div = false;
		                q_bbs_addrow(row_bbsbbt, row_b_seq, 1);
		            }
		        });
            }

            function q_popPost(s2) {
                if (s2 == 'txtAccc5_')/// for body
                    changeDC();
            }

            function changeDC() {
                var s1 = ($('#txtAccc4_' + b_seq).val() == dcType[0] ? '' : '　　') + $.trim($('#txtAccc6_' + b_seq).val());
                $('#txtAccc6_' + b_seq).val(s1);
            }

            function bbsAssign() {

                aPop[0][5] = "acpart_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno;
                aPop[1][5] = "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno;

                for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
                    $('#txtAccc5_' + j).change(function() {
                        t_IdSeq = -1;
                        /// 要先給  才能使用 q_bodyId()
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;

                        var s1 = trim($(this).val());
                        if (s1.length > 4 && s1.indexOf('.') < 0)
                            $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                        if (s1.length == 4)
                            $(this).val(s1 + '.');
                    });

                    $('#txtAccc8_' + j).focusout(function() {
                        sum();
                    });

                    $('#txtAccc4_' + j).focus(function() {
                        var s1 = $.trim($(this).val());
                        if (s1.length == 0)
                            $(this).val(dcType[0]);
                    });
                    $('#txtAccc4_' + j).focusout(function() {
                        var s1 = $(this).val();

                        if (s1.toLowerCase() == 'd')
                            $(this).val(dcType[0]);

                        if (s1.toLowerCase() == 'c')
                            $(this).val(dcType[1]);

                        s1 = $(this).val();

                        if (s1 != dcType[0] && s1 != dcType[1])
                            $(this).val(dcType[0]);

                        t_IdSeq = -1;
                        /// 要先給  才能使用 q_bodyId()
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        changeDC();

                        sum();
                    });

                    $('#txtAccc8_' + j).focusout(function() {
                        sum();
                    });
                    $('#txtAccc7_' + j).focusout(function() {
                        var s1 = $(this).val();
                        if (s1.length == 1 && s1 == "=") {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if (b_seq > 0) {
                                var i = b_seq - 1;
                                var s1 = $('#txtAccc7_' + i).val();
                                $('#txtAccc7_' + b_seq).val(s1);
                            }
                        }

                        if (s1.length < 6 && s1.substr(0, 1) == "-") {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;

                            q_gt('qphr', " where=^^noa='" + $.trim(s1.substr(1)) + "'^^", 0, 1, 0, '', '');
                        }
                    });

                    $('#btnQphr_' + j).click(function(e) {
                        t_IdSeq = -1;
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;

                        q_box('qPhr_b.aspx' + "?;;;;" + r_accy, 'qphr', "800px", "600px", m_print);
                    });
                    
                    $('#btnMinus_' + j).bind('contextmenu', function (e) {
						e.preventDefault();

						mouse_div = false;
						////////////控制顯示位置
						$('#div_row').css('top', e.pageY);
						$('#div_row').css('left', e.pageX);
						////////////
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						$('#div_row').show();
						row_b_seq = b_seq;
						row_bbsbbt = 'bbs';
					});

                }//j
                _bbsAssign();

                if (t_proj != 1)
                    $('.tdProj').hide();
            }

            function btnIns() {
                _btnIns();
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
                if (!as['accc5']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['datea'] = abbm2['datea'];

                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0;
                for (var j = 0; j < q_bbsCount; j++) {

                } // j

            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
		            $('#div_row').hide();
		        }
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

            var mouse_div = true;
            //控制滑鼠消失div
            var row_bbsbbt = '';
            //判斷是bbs或bbt增加欄位
            var row_b_seq = '';
            //判斷第幾個row
            //插入欄位
            function q_bbs_addrow(bbsbbt, row, topdown) {
                //取得目前行
                var rows_b_seq = dec(row) + dec(topdown);
                if (bbsbbt == 'bbs') {
                    q_gridAddRow(bbsHtm, 'tbbs', 'txtNoq', 1);
                    //目前行的資料往下移動
                    for (var i = q_bbsCount - 1; i >= rows_b_seq; i--) {
                        for (var j = 0; j < fbbs.length; j++) {
                            if (i != rows_b_seq)
                                $('#' + fbbs[j] + '_' + i).val($('#' + fbbs[j] + '_' + (i - 1)).val());
                            else
                                $('#' + fbbs[j] + '_' + i).val('');
                        }
                    }
                }
                if (bbsbbt == 'bbt') {
                    q_gridAddRow(bbtHtm, 'tbbt', fbbt, 1, '', '', '', '__');
                    //目前行的資料往下移動
                    for (var i = q_bbtCount - 1; i >= rows_b_seq; i--) {
                        for (var j = 0; j < fbbt.length; j++) {
                            if (i != rows_b_seq)
                                $('#' + fbbt[j] + '__' + i).val($('#' + fbbt[j] + '__' + (i - 1)).val());
                            else
                                $('#' + fbbt[j] + '__' + i).val('');
                        }
                    }
                }
                $('#div_row').hide();
                row_bbsbbt = '';
                row_b_seq = '';
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
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1px;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 98%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .tbbs .td1 {
                width: 4%;
            }
            .tbbs .td2 {
                width: 9%;
            }

            #div_row {
                display: none;
                width: 750px;
                background-color: #ffffff;
                position: absolute;
                left: 20px;
                z-index: 50;
            }
		</style>
	</head>
	<body>
		<div id="div_row" style="position:absolute; top:300px; left:500px; display:none; width:150px; background-color: #ffffff; ">
			<table id="table_row"  class="table_row" style="width:100%;" border="1" cellpadding='1'  cellspacing='0'>
				<tr>
					<td align="center" ><a id="lblTop_row" class="lbl btn">上方插入空白行</a></td>
				</tr>
				<tr>
					<td align="center" ><a id="lblDown_row" class="lbl btn">下方插入空白行</a></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" style="float: left;  width:25%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:20%"><a id='vewNamea'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='namea'>~namea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 73%;float:left">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr>
						<td class='td1'><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class='td3'><span> </span><a id="lblNamea" class="lbl"> </a></td>
						<td class="td4"><input id="txtNamea" type="text" class="txt c1"/></td>
						<td class="td5"> </td>
					</tr>
				</table>
			</div>
			<div class='dbbs' >
				<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
					<tr style='color:White; background:#003366;' >
						<td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /></td>
						<td align="center"><a id='lblNoq'> </a></td>
						<td align="center"><a id='lblAccc4'> </a></td>
						<td align="center" class="tdProj"><a id='lblProj'> </a></td>
						<td align="center"><a id='lblPart'> </a></td>
						<td align="center"><a id='lblAccc5'> </a></td>
						<td align="center"><a id='lblAccc6'> </a></td>
						<td align="center"><a id='lblAccc7'> </a></td>
						<td align="center"><a id='lblDmoney'> </a></td>
						<td align="center"><a id='lblCmoney'> </a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
						<td style="width:3%;"><input class="txt" id="txtNoq.*" type="text" maxlength='5' style="width:90%;" /></td>
						<td style="width:3%; text-align:center"><input class="txt"  id="txtAccc4.*" maxlength='30'type="text" style="width:90%;" /></td>
						<td class="tdProj" style="width:10%;">
							<input class="btn"  id="btnProj" type="button" value='.' style=" font-weight: bold; " />
							<input class="txt" id="txtProj.*" type="text" maxlength='90' style="width:55%; " />
						</td>
						<td style="width:7%;">
							<input class="btn"  id="btnPart.*" type="button" value='.' style=" font-weight: bold; " />
							<input class="txt" id="txtPart.*" type="text" maxlength='90' style="width:55%; " />
						</td>
						<td style="width:13%;">
							<input class="btn"  id="btnAcc.*" type="button" value='.' style=" font-weight: bold;" />
							<input class="txt" id="txtAccc5.*" type="text" maxlength='90' style="width:75%;" />
						</td>
						<td style="width:20%;"><input class="txt" id="txtAccc6.*" type="text" maxlength='10' style="width:97%;"/></td>
						<td style="width:25%;">
							<input class="btn"  id="btnQphr.*" type="button" value='.'  />
							<input class="txt" id="txtAccc7.*" type="text" maxlength='20' style="width:85%;"/>
						</td>
						<td style="width:8%;">
							<input class="txt" id="txtDmoney.*" type="text" maxlength='20' style="width:97%; text-align:right;"/>
							<input id="recno.*" type="hidden" />
						</td>
						<td style="width:8%;">
							<input class="txt" id="txtCmoney.*" type="text" maxlength='20' style="width:97%; text-align:right;"/>
							<input id="Hidden1" type="hidden" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

