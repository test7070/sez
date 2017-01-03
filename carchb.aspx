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
	
	        var q_name = "carchb";
	        var q_readonly = ['txtNoa'];
	        var bbmNum = [];
	        var bbmMask = [];
	        q_sqlCount = 6;
	        brwCount = 6;
	        brwCount2 = 20;
	        brwList = [];
	        brwNowPage = 0;
	        brwKey = 'noa';
	
	        $(document).ready(function() {
	            bbmKey = ['noa'];
	            q_brwCount();
	            q_gt(q_name, q_content, q_sqlCount, 1);
	            $('#txtNoa').focus();
	        });
	
	        function main() {
	            if (dataErr) {
	                dataErr = false;
	                return;
	            }
	            mainForm(0);
	        }
	
	        function mainPost() {
	            document.title = '駕駛出車檢驗單'
	            bbmMask = [['txtDatea', r_picd], ['txtChkdate', r_picd], ['txtChktime', '99:99']];
	            q_getFormat();
	            q_mask(bbmMask);
	           	q_cmbParse("cmbTypea", '1@板櫃,2@油罐,3@高壓,4@粉粒槽,5@傾卸車');
	            $('#cmbTypea').change(function(e){
					cmbTypea_chg();
				});
				$('#textCarno1').change(function() {
                	$('#txtCarno1').val($(this).val());
				});
				$('#textCarno2').change(function() {
                	$('#txtCarno2').val($(this).val());
				});
				$('#textCarno3').change(function() {
                	$('#txtCarno1').val($(this).val());
				});
				$('#textCarno4').change(function() {
                	$('#txtCarno2').val($(this).val());
				});
				$('#textCarno5').change(function() {
                	$('#txtCarno1').val($(this).val());
				});
				$('#textCarno6').change(function() {
                	$('#txtCarno2').val($(this).val());
				});
				$('#textCarno7').change(function() {
                	$('#txtCarno1').val($(this).val());
				});
				$('#textCarno8').change(function() {
                	$('#txtCarno2').val($(this).val());
				});
				$('#textCarno9').change(function() {
                	$('#txtCarno1').val($(this).val());
				});
				$('#textCarno10').change(function() {
                	$('#txtCarno2').val($(this).val());
				});
	        }
	        function cmbTypea_chg(){
		         if($('#cmbTypea').val()== 1){
	                $('.istya').show();
	                $('.istyb').hide();
	                $('.istyc').hide();
	                $('.istyd').hide();
	                $('.istye').hide();			          		
	             }else if($('#cmbTypea').val() == 2){
      	            $('.istya').hide();         		
               		$('.istyb').show();
	                $('.istyc').hide();
	                $('.istyd').hide();
	                $('.istye').hide();          		
	             }else if($('#cmbTypea').val() == 3){
	             	$('.istya').hide();
	             	$('.istyb').hide(); 
               		$('.istyc').show();	
               		$('.istyd').hide();
	                $('.istye').hide();          		
	             }else if($('#cmbTypea').val()== 4){
	             	$('.istya').hide();
	             	$('.istyb').hide();
	                $('.istyc').hide();	             		             	
               		$('.istyd').show();
               		$('.istye').hide();	          		
	             }else{
	             	$('.istya').hide();
	             	$('.istyb').hide();
	                $('.istyc').hide();
               		$('.istyd').hide();	                		             	
	                $('.istye').show();	 
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
	
	        function q_gtPost(t_name) {
	            switch (t_name) {
	                case 'checkNoa_change':
	                    var as = _q_appendData("uccga", "", true);
	                    if (as[0] != undefined) {
	                        alert('已存在 ' + as[0].noa + ' ' + as[0].namea);
	                    }
	                    Unlock();
	                    break;
	                case 'checkNoa_btnOk':
	                    var as = _q_appendData("uccga", "", true);
	                    if (as[0] != undefined) {
	                        alert('已存在 ' + as[0].noa + ' ' + as[0].namea);
	                        Unlock();
	                        return;
	                    } else {
	                        wrServer($('#txtNoa').val());
	                        Unlock();
	                    }
	                    break;
	                case q_name:
	                    if (q_cur == 4)
	                        q_Seek_gtPost();
	                    break;
	            }  /// end switch
	        }
	
	        function _btnSeek() {
	            if (q_cur > 0 && q_cur < 4)// 1-3
	                return;
	        }
	
	        function btnIns() {
	            _btnIns();
	            $('#txtDatea').val(q_date());
	            refreshBbm();
	            $('#txtNoa').focus();
	            cmbTypea_chg();
	        }
	
	        function btnModi() {
	            if (emp($('#txtNoa').val()))
	                return;
	            _btnModi();
	            refreshBbm();
	            cmbTypea_chg();
	        }
	
	        function btnPrint() {
	
	        }
	
	        function q_stPost() {
	            if (!(q_cur == 1 || q_cur == 2))
	                return false;
	        }
	
	        function btnOk() {
	
	            var t_noa = trim($('#txtNoa').val());
	            var t_date = trim($('#txtDatea').val());
	            if (t_noa.length == 0 || t_noa == "AUTO")
	                q_gtnoa(q_name, replaceAll('CB' + (t_date.length == 0 ? q_date() : t_date), '/', ''));
	            else
	                wrServer(t_noa);
	        }
	
	        function wrServer(key_value) {
	            var i;
	
	            xmlSql = '';
	            if (q_cur == 2)
	                xmlSql = q_preXml();
	
	            $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
	            _btnOk(key_value, bbmKey[0], '', '', 2);
	            Unlock();
	        }
	
	        function refresh(recno) {
	            _refresh(recno);
	            refreshBbm();
	            $('#vewNoa').text('單據編號');
	            $('#vewDatea').text('日期');
	            cmbTypea_chg();
	        }
	
	        function refreshBbm() {
	            if (q_cur == 1) {
	                $('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
	            } else {
	                $('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
	            }
	            
	             $('#textCarno1').val($('#txtCarno1').val());
	             $('#textCarno2').val($('#txtCarno2').val());
	             $('#textCarno3').val($('#txtCarno1').val());
	             $('#textCarno4').val($('#txtCarno2').val());
	             $('#textCarno5').val($('#txtCarno1').val());
	             $('#textCarno6').val($('#txtCarno2').val());
	             $('#textCarno7').val($('#txtCarno1').val());
	             $('#textCarno8').val($('#txtCarno2').val());
	             $('#textCarno9').val($('#txtCarno1').val());
	             $('#textCarno10').val($('#txtCarno2').val());
	        }
	
	        function readonly(t_para, empty) {
	            _readonly(t_para, empty);
	            if(t_para){
                	$('#textCarno1').attr('disabled', 'disabled');
                	$('#textCarno2').attr('disabled', 'disabled');
                	$('#textCarno3').attr('disabled', 'disabled');
                	$('#textCarno4').attr('disabled', 'disabled');
                	$('#textCarno5').attr('disabled', 'disabled');
                	$('#textCarno6').attr('disabled', 'disabled');
                	$('#textCarno7').attr('disabled', 'disabled');
                	$('#textCarno8').attr('disabled', 'disabled');
                	$('#textCarno9').attr('disabled', 'disabled');
                	$('#textCarno10').attr('disabled', 'disabled');                	
                }else{
                	$('#textCarno1').removeAttr('disabled');
                	$('#textCarno2').removeAttr('disabled');
                	$('#textCarno3').removeAttr('disabled');
                	$('#textCarno4').removeAttr('disabled');
                	$('#textCarno5').removeAttr('disabled');
                	$('#textCarno6').removeAttr('disabled');
                	$('#textCarno7').removeAttr('disabled');
                	$('#textCarno8').removeAttr('disabled');
                	$('#textCarno9').removeAttr('disabled');
                	$('#textCarno10').removeAttr('disabled');
                }
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
	        }
	        .dview {
	            float: left;
	            width: 270px;
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
	            width: 930px;
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
	
	        }
	        .tbbm .tdZ {
	
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
	            width: 70%;
	            float: left;
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
	
	        input[type="text"], input[type="button"] {
	            font-size: medium;
	        }
		</style>
	</head>
	<body>
	<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:1%"><a id='vewChk'> </a></td>				
						<td align="center" style="width:58%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewDatea'> </a></td>								
					</tr>
				 	<tr>
					   <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
					   <td align="center" id='noa'>~noa</td>
					   <td align="center" id='datea'>~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="float: left;">
				<table class="tbbm" id="tbbm"  border="1">	
					<tr align="center" style="height: 1px;">
						<td style="width: 40px;"> </td>
						<td style="width: 160px;"> </td>
						<td style="width: 380px;"> </td>
						<td style="width: 60px;"> </td>
						<td style="width: 50px;"> </td>
						<td style="width: 50px;"> </td>
						<td style="width: 60px;"> </td>
						<td style="width: 50px;"> </td>
						<td style="width: 50px;"> </td>
						<td style="width: 30px;"> </td>
					</tr>
					<tr>
						<td colspan="9">
							<a style="float: left;">單據編號</a>
							<span style="float: left;"> </span>
							<input id='txtNoa' type="text" class="txt c1" style="width: 150px;">
							<span style="width: 50px;float: left;"> </span>
							<a style="float: left;">日期</a>	
							<span style="float: left;"> </span>
							<input id='txtDatea' type="text" class="txt c1" style="width: 100px;">
							<span style="width: 50px;float: left;"> </span>
							<a style="float: left;">類型</a>	
							<span style="float: left;"> </span>
							<select id="cmbTypea" class="txt c1" style="width: 100px;"></select>
							<input id='txtCarno1' type="hidden" class="txt c2" style="float: none;">
							<input id='txtCarno2' type="hidden" class="txt c2" style="float: none;">
						</td>
					</tr>
					<tr align="center">
						<td rowspan="2" > 項<br> 次 </td>
						<td rowspan="2"> 檢　查　項　目 </td>
						<td rowspan="2">　檢　查　標　準　</td>
						<td colspan="3">前手駕駛座頁中檢察</td>
						<td colspan="3">後手駕駛座頁中檢察</td>
					</tr>
					<tr align="center">
						<td>時機</td>
						<td>正常</td>
						<td>異常</td>
						<td>時機</td>
						<td>正常</td>
						<td>異常</td>
					</tr>
					<tr class="istya" style="display: none;">
						<td rowspan="5" align="center" > 板<br> 櫃 </td>
						<td >簾幕、雨棚</td>
						<td >無破損漏水、束帶完整、操作順暢</td>
						<td rowspan="5" align="center">尾<BR>車<BR>車<BR>號<BR>︵<BR><input id='textCarno1' type="text" class="txt c2" style="float: none;"><BR>︶</td>
						<td align="center"><input id="chkA01a" type="checkbox"></td>
						<td align="center"><input id="chkA01b" type="checkbox"></td>
						<td rowspan="5" align="center">尾<BR>車<BR>車<BR>號<BR>︵<BR><input id='textCarno2' type="text" class="txt c2" style="float: none;"><BR>︶</td>
						<td align="center"><input id="chkA01c" type="checkbox"></td>
						<td align="center"><input id="chkA01d" type="checkbox"></td>
					</tr>
					<tr class="istya" style="display: none;">
						<td>車柄及中性</td>
						<td>完整無變形操作順暢</td>
						<td align="center"><input id="chkA02a" type="checkbox"></td>
						<td align="center"><input id="chkA02b" type="checkbox"></td>
						<td align="center"><input id="chkA02c" type="checkbox"></td>
						<td align="center"><input id="chkA02d" type="checkbox"></td>
					</tr>
					<tr class="istya" style="display: none;">
						<td>簾幕櫃</td>
						<td>櫃頂、尾門、防水條完整無變形</td>
						<td align="center"><input id="chkA03a" type="checkbox"></td>
						<td align="center"><input id="chkA03b" type="checkbox"></td>
						<td align="center"><input id="chkA03c" type="checkbox"></td>
						<td align="center"><input id="chkA03d" type="checkbox"></td>
					</tr>
					<tr class="istya" style="display: none;">
						<td>綑綁器</td>
						<td>完整無變形</td>
						<td align="center"><input id="chkA04a" type="checkbox"></td>
						<td align="center"><input id="chkA04b" type="checkbox"></td>
						<td align="center"><input id="chkA04c" type="checkbox"></td>
						<td align="center"><input id="chkA04d" type="checkbox"></td>
					</tr>
					<tr class="istya" style="display: none;">
						<td>安全插銷</td>
						<td>安全插銷處、插銷完整</td>
						<td align="center"><input id="chkA05a" type="checkbox"></td>
						<td align="center"><input id="chkA05b" type="checkbox"></td>
						<td align="center"><input id="chkA05c" type="checkbox"></td>
						<td align="center"><input id="chkA05d" type="checkbox"></td>
					</tr>
					<!--------------------------------------------------->
					<tr class="istyb" style="display: none;">
						<td rowspan="6" align="center"> 油<br> 罐 </td>
						<td>人孔蓋</td>
						<td>扣抱緊路良好、墊圈完整無洩漏、異味及油漬</td>
						<td rowspan="5" align="center">尾<BR>車<BR>車<BR>號<BR>︵<BR><input id='textCarno3' type="text" class="txt c2" style="float: none;"><BR>︶</td>
						<td align="center"><input id="chkA06a" type="checkbox"></td>
						<td align="center"><input id="chkA06b" type="checkbox"></td>
						<td rowspan="5" align="center">尾<BR>車<BR>車<BR>號<BR>︵<BR><input id='textCarno4' type="text" class="txt c2" style="float: none;"><BR>︶</td>
						<td align="center"><input id="chkA06c" type="checkbox"></td>
						<td align="center"><input id="chkA06d" type="checkbox"></td>
					</tr>
					<tr class="istyb" style="display: none;">
						<td>槽體、爬梯、排水閥</td>
						<td>外觀無變形、龜裂、銹蝕等，槽頂排水順暢閥門正常</td>
						<td align="center"><input id="chkA07a" type="checkbox"></td>
						<td align="center"><input id="chkA07b" type="checkbox"></td>
						<td align="center"><input id="chkA07c" type="checkbox"></td>
						<td align="center"><input id="chkA07d" type="checkbox"></td>
					</tr>
					<tr class="istyb" style="display: none;">
						<td>洩料軟管</td>
						<td>外觀無變破損二端接頭無變形墊圏、盲塞完整</td>
						<td align="center"><input id="chkA08a" type="checkbox"></td>
						<td align="center"><input id="chkA08b" type="checkbox"></td>
						<td align="center"><input id="chkA08c" type="checkbox"></td>
						<td align="center"><input id="chkA08d" type="checkbox"></td>
					</tr>
					<tr class="istyb" style="display: none;">
						<td>管路、溫度表</td>
						<td>支架固定穩固、管路無歸裂滲漏、溫度表作用正常</td>
						<td align="center"><input id="chkA09a" type="checkbox"></td>
						<td align="center"><input id="chkA09b" type="checkbox"></td>
						<td align="center"><input id="chkA09c" type="checkbox"></td>
						<td align="center"><input id="chkA09d" type="checkbox"></td>
					</tr>
					<tr class="istyb" style="display: none;">
						<td>閥門、接地線</td>
						<td>裝、卸料閥操作順暢無洩漏、緊急遮斷間、通氣閥、呼吸閥作用正常，盲蓋、墊圈、接地線等完整。</td>
						<td align="center"><input id="chkA10a" type="checkbox"></td>
						<td align="center"><input id="chkA10b" type="checkbox"></td>
						<td align="center"><input id="chkA10c" type="checkbox"></td>
						<td align="center"><input id="chkA10d" type="checkbox"></td>
					</tr>
					<tr class="istyb" style="display: none;">
						<td>煞車反鎖</td>
						<td>操作及作用正常、閥門及管路無漏氣</td>
						<td align="center"><input id="chkA11a" type="checkbox"></td>
						<td align="center"><input id="chkA11b" type="checkbox"></td>
						<td align="center"><input id="chkA11c" type="checkbox"></td>
						<td align="center"><input id="chkA11d" type="checkbox"></td>
					</tr>
				<!--------------------------------------------------->
					<tr class="istyc" style="display: none;">
						<td rowspan="7" align="center"> 高<br> 壓 </td>
						<td>槽體</td>
						<td>外觀無變形、龜裂、銹蝕等</td>
						<td rowspan="7" align="center">尾<BR>車<BR>車<BR>號<BR>︵<BR><input id='textCarno5' type="text" class="txt c2" style="float: none;"><BR>︶</td>
						<td align="center"><input id="chkA12a" type="checkbox"></td>
						<td align="center"><input id="chkA12b" type="checkbox"></td>
						<td rowspan="7" align="center">尾<BR>車<BR>車<BR>號<BR>︵<BR><input id='textCarno6' type="text" class="txt c2" style="float: none;"><BR>︶</td>
						<td align="center"><input id="chkA12c" type="checkbox"></td>
						<td align="center"><input id="chkA12d" type="checkbox"></td>
					</tr>
					<tr class="istyc" style="display: none;">
						<td>管路、壓力（溫度）<br>表</td>
						<td>支架固定穩固、管路無歸裂滲漏、壓力(溫度)表作用正常</td>
						<td align="center"><input id="chkA13a" type="checkbox"></td>
						<td align="center"><input id="chkA13b" type="checkbox"></td>
						<td align="center"><input id="chkA13c" type="checkbox"></td>
						<td align="center"><input id="chkA13d" type="checkbox"></td>
					</tr>
					<tr class="istyc" style="display: none;">
						<td>洩料軟管</td>
						<td>外表鋼絲及接頭處無破損</td>
						<td align="center"><input id="chkA14a" type="checkbox"></td>
						<td align="center"><input id="chkA14b" type="checkbox"></td>
						<td align="center"><input id="chkA14c" type="checkbox"></td>
						<td align="center"><input id="chkA14d" type="checkbox"></td>
					</tr>
					<tr class="istyc" style="display: none;">
						<td>閥門、接地線</td>
						<td>操作順暢無滲漏油漬異味、盲蓋、墊圈等完整</td>
						<td align="center"><input id="chkA15a" type="checkbox"></td>
						<td align="center"><input id="chkA15b" type="checkbox"></td>
						<td align="center"><input id="chkA15c" type="checkbox"></td>
						<td align="center"><input id="chkA15d" type="checkbox"></td>
					</tr>
					<tr class="istyc" style="display: none;">
						<td>煞車反鎖</td>
						<td>操作及作用正常、閥門及管路無溫度</td>
						<td align="center"><input id="chkA16a" type="checkbox"></td>
						<td align="center"><input id="chkA16b" type="checkbox"></td>
						<td align="center"><input id="chkA16c" type="checkbox"></td>
						<td align="center"><input id="chkA16d" type="checkbox"></td>
					</tr>
					<tr class="istyc" style="display: none;">
						<td>安全閥</td>
						<td>閥門在開位置、鉛封完整、作用正常</td>
						<td align="center"><input id="chkA17a" type="checkbox"></td>
						<td align="center"><input id="chkA17b" type="checkbox"></td>
						<td align="center"><input id="chkA17c" type="checkbox"></td>
						<td align="center"><input id="chkA17d" type="checkbox"></td>
					</tr>
					<tr class="istyc" style="display: none;">
						<td>洩料馬達及幫浦</td>
						<td>幫浦油面視窗一半以上，馬達線無破損，無熔絲開關及電磁開關完整</td>
						<td align="center"><input id="chkA18a" type="checkbox"></td>
						<td align="center"><input id="chkA18b" type="checkbox"></td>
						<td align="center"><input id="chkA18c" type="checkbox"></td>
						<td align="center"><input id="chkA18d" type="checkbox"></td>
					</tr>
				<!--------------------------------------------------->
					<tr class="istyd" style="display: none;">
						<td rowspan="7" align="center"> 粉<br> 粒<br> 槽 </td>
						<td>蒸發器</td>
						<td>固定座、螺絲完整無鬆脫、管路無洩漏龜裂</td>
						<td rowspan="7" align="center">尾<BR>車<BR>車<BR>號<BR>︵<BR><input id='textCarno7' type="text" class="txt c2" style="float: none;"><BR>︶</td>
						<td align="center"><input id="chkA19a" type="checkbox"></td>
						<td align="center"><input id="chkA19b" type="checkbox"></td>
						<td rowspan="7" align="center">尾<BR>車<BR>車<BR>號<BR>︵<BR><input id='textCarno8' type="text" class="txt c2" style="float: none;"><BR>︶</td>
						<td align="center"><input id="chkA19c" type="checkbox"></td>
						<td align="center"><input id="chkA19d" type="checkbox"></td>
					</tr>
					<tr class="istyd" style="display: none;">
						<td>槽體、爬梯</td>
						<td>外觀無變形、龜裂、銹蝕等，卸料等無漏氣</td>
						<td align="center"><input id="chkA20a" type="checkbox"></td>
						<td align="center"><input id="chkA20b" type="checkbox"></td>
						<td align="center"><input id="chkA20c" type="checkbox"></td>
						<td align="center"><input id="chkA20d" type="checkbox"></td>
					</tr>
					<tr class="istyd" style="display: none;">
						<td>管路</td>
						<td>支架、管束固定穩固、管路無龜裂滲漏</td>
						<td align="center"><input id="chkA21a" type="checkbox"></td>
						<td align="center"><input id="chkA21b" type="checkbox"></td>
						<td align="center"><input id="chkA21c" type="checkbox"></td>
						<td align="center"><input id="chkA21d" type="checkbox"></td>
					</tr>
					<tr class="istyd" style="display: none;">
						<td>安全閥、壓力表</td>
						<td>開啟壓力正常、管壓、桶壓壓力錶作用正常</td>
						<td align="center"><input id="chkA22a" type="checkbox"></td>
						<td align="center"><input id="chkA22b" type="checkbox"></td>
						<td align="center"><input id="chkA22c" type="checkbox"></td>
						<td align="center"><input id="chkA22d" type="checkbox"></td>
					</tr>
					<tr class="istyd" style="display: none;">
						<td>閥門、接地線</td>
						<td>卸料閥操作順暢無滲漏作用正常、盲蓋、墊圈、接地線等完整。</td>
						<td align="center"><input id="chkA23a" type="checkbox"></td>
						<td align="center"><input id="chkA23b" type="checkbox"></td>
						<td align="center"><input id="chkA23c" type="checkbox"></td>
						<td align="center"><input id="chkA23d" type="checkbox"></td>
					</tr>
					<tr class="istyd" style="display: none;">
						<td>人孔蓋</td>
						<td>扣把緊度良好完整、墊圈完整卸料時無洩漏</td>
						<td align="center"><input id="chkA24a" type="checkbox"></td>
						<td align="center"><input id="chkA24b" type="checkbox"></td>
						<td align="center"><input id="chkA24c" type="checkbox"></td>
						<td align="center"><input id="chkA24d" type="checkbox"></td>
					</tr>
					<tr class="istyd" style="display: none;">
						<td>震動馬達</td>
						<td>作用良好</td>
						<td align="center"><input id="chkA25a" type="checkbox"></td>
						<td align="center"><input id="chkA25b" type="checkbox"></td>
						<td align="center"><input id="chkA25c" type="checkbox"></td>
						<td align="center"><input id="chkA25d" type="checkbox"></td>
					</tr>
					<!--------------------------------------------------->
					<tr class="istye" style="display: none;">
						<td rowspan="3" align="center"> 傾<br> 卸<br> 車 </td>
						<td>覆蓋網、馬達</td>
						<td>不破損、作用正常</td>
						<td rowspan="3" align="center">尾<BR>車<BR>車<BR>號<BR>︵<BR><input id='textCarno9' type="text" class="txt c2" style="float: none;"><BR>︶</td>
						<td align="center"><input id="chkA26a" type="checkbox"></td>
						<td align="center"><input id="chkA26b" type="checkbox"></td>
						<td rowspan="3" align="center">尾<BR>車<BR>車<BR>號<BR>︵<BR><input id='textCarno10' type="text" class="txt c2" style="float: none;"><BR>︶</td>
						<td align="center"><input id="chkA26c" type="checkbox"></td>
						<td align="center"><input id="chkA26d" type="checkbox"></td>
					</tr>
					<tr class="istye" style="display: none;">
						<td>攀昇油壓缸</td>
						<td>支架固定穩固、油壓缸、軟管無破損滲漏</td>
						<td align="center"><input id="chkA27a" type="checkbox"></td>
						<td align="center"><input id="chkA27b" type="checkbox"></td>
						<td align="center"><input id="chkA27c" type="checkbox"></td>
						<td align="center"><input id="chkA27d" type="checkbox"></td>
					</tr>
					<tr class="istye" style="display: none;">
						<td>車斗及尾門</td>
						<td>無破損變形、尾門開啟及緊閉良好</td>
						<td align="center"><input id="chkA28a" type="checkbox"></td>
						<td align="center"><input id="chkA28b" type="checkbox"></td>
						<td align="center"><input id="chkA28c" type="checkbox"></td>
						<td align="center"><input id="chkA28d" type="checkbox"></td>
					</tr>
					<!--------------------------------------------------->
					<tr>
						<td colspan="2" align="center">值班人員檢查出車<br>駕駛員身體狀況</td>
						<td colspan="7">
							1.精神狀況：
							<input id="chkB01a" type="checkbox">佳
							<input id="chkB01b" type="checkbox">不佳　
							2.喝酒或吃藥：
							<input id="chkB02a" type="checkbox">有
							<input id="chkB02b" type="checkbox">沒有
							酒測值
							<input id='txtBf1' type="text" class="txt c2" style="float: none;width: 50px;">mg/L
							<p> </p>
							3.血壓及心跳：
							<input id='txtBf2' type="text" class="txt c2" style="float: none;width: 50px;">/
							<input id='txtBf3' type="text" class="txt c2" style="float: none;width: 50px;">/
							<input id='txtBf4' type="text" class="txt c2" style="float: none;width: 50px;">
							<input id="chkB03a" type="checkbox">合格
							<input id="chkB03b" type="checkbox">不合格
							<p> </p>
							4.監督員簽名：<input id='txtChecker' type="text" class="txt c1" style="float: none;width: 100px;">
							日期：<input id='txtChkdate' type="text" class="txt c1" style="float: none;width: 100px;">
							時間：<input id='txtChktime' type="text" class="txt c1" style="float: none;width: 100px;">時/分
						</td>
					</tr>
					<tr align="center">
						<td colspan="2"> 異　常　說　明 </td>
						<td colspan="5"><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 80px;"> </textarea></td>
						<td colspan="2" style="vertical-align: top;">修復單編號：<BR><input id='txtRepairnoa' type="text" class="txt c1"></td>
					</tr>
					<tr>
						<td colspan="9">　註：1.以上檢查油、水、氣不足請自行添加，其他異常無法處理請填修復單請修。<br>
									　　　2.未依規定執行回廠及出車前檢查者每次依品質獎金核發準則減發500元。<br>
									　　　3.駕駛員精神、身體狀況不佳(高血壓含160以上)或飲酒者(酒測值含0.001mg/L以上)不准出車。<br>
						</td>
					</tr>
					<tr>
						<td colspan="9">
							調度員：<input id='txtWorker' type="text" class="txt c1" style="float: none;width: 100px;">
							後手駕駛員：<input id='txtDriver1' type="text" class="txt c1" style="float: none;width: 100px;">
							前手駕駛員：<input id='txtDriver2' type="text" class="txt c1" style="float: none;width: 100px;">
						</td>
					</tr>
				</table>
			</div>
		</div> 
		<input id="q_sys" type="hidden" />	
	</body>
</html>
