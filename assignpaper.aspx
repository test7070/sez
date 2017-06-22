<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'assignpaper', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 15;
            var t_sqlname = 'assignpaper_load';
            t_postname = q_name;
            var isBott = false;

            var afield, t_htm;
            var i, s1;
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;noa='0015'";
                    return;
                }
                if(!q_paraChk())
                    return;

                main();
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname);
                q_mask(bbmMask);
            }

            function q_gtPost(t_name) {

            }

            function bbsAssign() {
                
                for(var j = 0; j < q_bbsCount; j++) {
                }
                _bbsAssign();//_bbsAssign('tbbs', bbsHtm, fbbs, '_', bbsMask, bbsNum, q_readonlys, 'btnPlus');
            }
            
            function btnModi() {
                _btnModi();
                if(emp($('#txtProduct_0').val())){//表示第一次新增
	                $('#txtProduct_0').val('運輸執照正本');
	                $('#txtMount_0').val(1);
	                $('#txtUnit_0').val('份');
	                $('#txtProduct_1').val('會員證');
	                $('#txtMount_1').val(1);
	                $('#txtUnit_1').val('份');
	                $('#txtProduct_2').val('監理處函');
	                $('#txtMount_2').val(1);
	                $('#txtUnit_2').val('份');
	                $('#txtProduct_3').val('登記事項表');
	                $('#txtMount_3').val(1);
	                $('#txtUnit_3').val('份');
	                $('#txtProduct_4').val('章程');
	                $('#txtMount_4').val(1);
	                $('#txtUnit_4').val('份');
	                $('#txtProduct_5').val('公文(公文准文)正本');
	                $('#txtMount_5').val(1);
	                $('#txtUnit_5').val('份');
	                $('#txtProduct_6').val('股東名冊');
	                $('#txtMount_6').val(1);
	                $('#txtUnit_6').val('份');
	                $('#txtProduct_7').val('工商憑証');
	                $('#txtMount_7').val(1);
	                $('#txtUnit_7').val('張');
	                $('#txtProduct_8').val('公司、負責人及股東印鑑');
	                $('#txtMount_8').val(1);
	                $('#txtUnit_8').val('枚');
	                $('#txtProduct_9').val('規費單');
	                $('#txtMount_9').val(1);
	                $('#txtUnit_9').val('張');
	                $('#txtProduct_10').val('會計師簽證收據');
	                $('#txtMount_10').val(1);
	                $('#txtUnit_10').val('張');
	                $('#txtProduct_11').val('公司登記規費單');
	                $('#txtMount_11').val(1);
	                $('#txtUnit_11').val('張');
	                $('#txtProduct_12').val('公司預查規費單');
	                $('#txtMount_12').val(1);
	                $('#txtUnit_12').val('張');
	                $('#txtProduct_13').val('會員證規費單');
	                $('#txtMount_13').val(1);
	                $('#txtUnit_13').val('張');
	                $('#txtProduct_14').val('運輸執照費');
	                $('#txtMount_14').val(1);
	                $('#txtUnit_14').val('張');
                }
            }

            function btnOk() {
                sum();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['product']) {// Dont Save Condition
                    as[bbsKey[0]] = '';
                    return;
                }
                q_getId2('', as);
                return true;
            }

            function refresh() {
                _refresh();
            }

            function sum() {
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
                if(q_tables == 's')
                    bbsAssign();
            }
		</script>
		<style type="text/css">
            td a {
                font-size: 14px;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<!--#include file="../inc/pop_modi.inc"-->
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:1%; max-width:20px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td class="td8" align="center" style="width:40%;"><a id='lblProduct_s'></a></td>
					<td class="td8" align="center" style="width:10%;"><a id='lblMount_s'></a></td>
					<td class="td8" align="center" style="width:5%;"><a id='lblUnit_s'></a></td>
					<td class="td8" align="center" style="width:40%;"><a id='lblMemo_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center"><input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  /></td>
					<td class="td2"><input class="txt" id="txtProduct.*" type="text" style="width:95%; text-align: left;"  /></td>
					<td class="td3"><input class="txt" id="txtMount.*" type="text" style="width:95%; text-align: left;"  /></td>
					<td class="td4"><input class="txt" id="txtUnit.*" type="text" style="width:95%; text-align: left;"  /></td>
					<td class="td5"><input class="txt" id="txtMemo.*" type="text" style="width:95%; text-align: left;"  /></td>
				</tr>
			</table>
			
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
